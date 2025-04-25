Below is a pragmatic, component-level architecture you can implement today with open-source tools (LangChain / Llama-Index / Haystack) or a custom stack.  It marries Retrieval-Augmented Generation (RAG) with a small “society” of specialized agents that cooperate to return accurate, properly cited answers.  
  
────────────────────────────────────────  
1. HIGH-LEVEL BLOCKS  
────────────────────────────────────────  
User  
│  
├─►  Orchestrator / Conversation Manager  ←───↵  (turn-level control, memory  
│                      ▲                          hand-off, rate-limit, etc.)  
│                      │  
│                      ▼  
├─►  Retrieval Agent         (finds text that might contain the answer)  
│       │  
│       ▼  
├─►  Drafting Agent          (writes answer in natural language)  
│       │  
│       ▼  
├─►  Validation Agent        (checks accuracy vs. sources)  
│       │  
│       ▼  
└──►  Citation Agent         (formats & attaches inline citations)  

A persistent Vector Store (FAISS / Chroma / Weaviate / pgvector) and a
Metadata Store (relational / NoSQL) sit beside the agents and are shared
resources.

────────────────────────────────────────  
2. AGENT ROLES & RESPONSIBILITIES
────────────────────────────────────────  
A. Ingestion / Indexer (offline)
   • Splits every guidance document into semantically coherent chunks
     (e.g., ~300 words with 50 word overlap).
   • Creates:
       – Dense embeddings (for semantic search)  
       – Sparse BM-25 index (keyword fallback)  
       – Metadata per chunk (title, section, page, URL, doc-date, etc.)
   • Stores them in Vector Store + Metadata DB.

B. Retrieval Agent (online, stateless per request)
   1. Receives user’s question Q and chat history.
   2. Converts Q → embedding, performs hybrid search  
      (dense + sparse) with filters (date, doc-type, tags).
   3. Ranks top-k (k≈8–12) chunks by:
        sim_score + λ*citation_popularity − penalty_too_long
   4. Returns the passages + metadata to Orchestrator.

C. Drafting (Answer-Generation) Agent
   • System prompt enforces:  
     “Use only the supplied context. Quote document
      fragments verbatim where relevant. Return in APA style.”
   • Generates an answer along with preliminary citation keys
     (e.g. [docId-3], [docId-7]).

D. Validation Agent (self-consistency & fact-check)
   1. Re-reads each factual claim in the draft.
   2. Verifies the supporting passage truly backs the claim (chain-of-thought:
      “Is X explicitly stated or can be inferred with ≤1 logical step?”).
   3. Flags unsupported sentences.
   4. Two strategies:
        • Fix on its own (auto-repair)  
        • Request Orchestrator to send a follow-up retrieval for missing evidence.

E. Citation Agent
   • Maps citation keys to full references using metadata.
   • Formats inline citations (e.g. “[WHO-2023-sec4-para2]”) and bibliography.

F. Orchestrator / Conversation Manager
   • Maintains per-session memory (prior Q&A, follow-ups).
   • Coordinates turn order, retries, temperature settings.
   • Throttles or parallelizes agents (e.g., run retrieval + first-pass
     validation concurrently to save latency).

────────────────────────────────────────  
3. END-TO-END PROCESS FLOW
────────────────────────────────────────  
① User question → Orchestrator  
② Orchestrator → Retrieval Agent → returns context passages  
③ Orchestrator → Drafting Agent (with context + guidelines)  
④ Draft answer → Validation Agent  
     • If invalid → extra Retrieval round(s) or rewrite  
⑤ Validated answer → Citation Agent  
⑥ Formatted answer with bibliography → User  
⑦ Logs & traces persisted for audit.

────────────────────────────────────────  
4. ACCURACY & TRACEABILITY STRATEGIES
────────────────────────────────────────  
• Chunk size tuning: small enough for direct quotation, large enough for
  coherent meaning; store original page/section for trace audits.

• “Linked-source prompting”:  
  Begin every system prompt with:  
  “If you cannot support a statement with one of the provided chunks, respond
   ‘INSUFFICIENT DATA’ for that statement.”

• Temperature schedule: Retrieval (N/A), Drafting (0.2-0.5),
  Validation (0), Citation (0).

• Self-consistency majority vote: spawn 3 Drafting Agents with different
  seeds; pass best-scoring one (using ReAct + factuality scorer) to Validation.

• Automatic regression suite: a YAML file of {question, expected_regex,
  must_include_docIds}.  Run nightly CI against model updates.

────────────────────────────────────────  
5. TECHNOLOGY HINTS (OPEN SOURCE)
────────────────────────────────────────  
• LangChain Routing: LLMRouter → select agent chains.  
• Llama-Index SubQuestionQueryEngine for multi-hop retrieval.  
• Guardrails.ai or DeepEval for factuality checks.  
• FastAPI + WebSocket streaming for Orchestrator.  
• Celery / RabbitMQ if you need distributed agent execution.

────────────────────────────────────────  
6. FUTURE EXTENSIONS
────────────────────────────────────────  
• Provenance graph: each claim node links to passage nodes → doc nodes.  
• Human-in-the-loop review queue for low-confidence answers.  
• Active-Learning retriever: log missed passages, fine-tune embedder.

Use this blueprint as a starting point: wire up the agents as independent
“skills” (Docker micro-services or classes in one repo) and iterate on the
retrieval tuning + validation heuristics—the two biggest levers for
accuracy.
