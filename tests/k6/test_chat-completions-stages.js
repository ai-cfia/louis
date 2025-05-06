import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  stages: [
    { target: 15, duration: '10s' },
    { target: 10, duration: '10s' },
    { target: 5, duration: '10s' },
  ],
  tags: { testid: 'openwebui-chat-completions-1000' },
//   thresholds: {
//     http_req_duration: ['p(95)<2000'],
//     http_req_failed: ['rate<0.01'],
//   },
};

export default function () {
  const url = 'http://open-webui-service.louis.svc.cluster.local:8080/api/chat/completions';
  const payload = JSON.stringify({
    model: 'DSDP_.o4-mini',
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

  sleep(1); // Pause de 1 seconde
}
