LangGraph

LangGraph is a library for building stateful, multi-actor applications with LLMs. This example uses Langgraph to automate the process of an in depth research on any given topic.
Use case​

By using Langgraph, the research process can be significantly improved in depth and quality by leveraging multiple agents with specialized skills. Inspired by the recent STORM paper, this example showcases how a team of AI agents can work together to conduct research on a given topic, from planning to publication.

An average run generates a 5-6 page research report in multiple formats such as PDF, Docx and Markdown.

Please note: This example uses the OpenAI API only for optimized performance.
The Multi Agent Team​

The research team is made up of 7 AI agents:

    Human - The human in the loop that oversees the process and provides feedback to the agents.
    Chief Editor - Oversees the research process and manages the team. This is the "master" agent that coordinates the other agents using Langgraph.
    Researcher (gpt-researcher) - A specialized autonomous agent that conducts in depth research on a given topic.
    Editor - Responsible for planning the research outline and structure.
    Reviewer - Validates the correctness of the research results given a set of criteria.
    Revisor - Revises the research results based on the feedback from the reviewer.
    Writer - Responsible for compiling and writing the final report.
    Publisher - Responsible for publishing the final report in various formats.

How it works​

Generally, the process is based on the following stages:

    Planning stage
    Data collection and analysis
    Review and revision
    Writing and submission
    Publication

Architecture​

Steps​

More specifically (as seen in the architecture diagram) the process is as follows:

    Browser (gpt-researcher) - Browses the internet for initial research based on the given research task.
    Editor - Plans the report outline and structure based on the initial research.
    For each outline topic (in parallel):
        Researcher (gpt-researcher) - Runs an in depth research on the subtopics and writes a draft.
        Reviewer - Validates the correctness of the draft given a set of criteria and provides feedback.
        Revisor - Revises the draft until it is satisfactory based on the reviewer feedback.
    Writer - Compiles and writes the final report including an introduction, conclusion and references section from the given research findings.
    Publisher - Publishes the final report to multi formats such as PDF, Docx, Markdown, etc.

How to run​

    Install required packages:

    pip install -r requirements.txt

Update env variables

export OPENAI_API_KEY={Your OpenAI API Key here}
export TAVILY_API_KEY={Your Tavily API Key here}

Run the application:

python main.py

Usage​

To change the research query and customize the report, edit the task.json file in the main directory.
Task.json contains the following fields:​

    query - The research query or task.
    model - The OpenAI LLM to use for the agents.
    max_sections - The maximum number of sections in the report. Each section is a subtopic of the research query.
    include_human_feedback - If true, the user can provide feedback to the agents. If false, the agents will work autonomously.
    publish_formats - The formats to publish the report in. The reports will be written in the output directory.
    source - The location from which to conduct the research. Options: web or local. For local, please add DOC_PATH env var.
    follow_guidelines - If true, the research report will follow the guidelines below. It will take longer to complete. If false, the report will be generated faster but may not follow the guidelines.
    guidelines - A list of guidelines that the report must follow.
    verbose - If true, the application will print detailed logs to the console.

For example:​

{
  "query": "Is AI in a hype cycle?",
  "model": "gpt-4o",
  "max_sections": 3, 
  "publish_formats": { 
    "markdown": true,
    "pdf": true,
    "docx": true
  },
  "include_human_feedback": false,
  "source": "web",
  "follow_guidelines": true,
  "guidelines": [
    "The report MUST fully answer the original question",
    "The report MUST be written in apa format",
    "The report MUST be written in english"
  ],
  "verbose": true
}

To Deploy​

pip install langgraph-cli
langgraph up