import http from 'k6/http';

export const options = {
  vus: 1,
  iterations: 1,
  tags: { testid: 'chat-completions' },
};

export default function () {
  const url = 'http://open-webui-service.louis.svc.cluster.local:8080/api/chat/completions';
  const payload = JSON.stringify({
    model: 'cogito:14b-v1-preview-qwen-q8_0',
    messages: [
      {
        role: 'user',
        content: "Explain to me what is a kubernetes deployment"
      }
    ]
  });

  const params = {
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${__ENV.OPENWEBUI_API_KEY}'
    }
  };

  http.post(url, payload, params);
}
