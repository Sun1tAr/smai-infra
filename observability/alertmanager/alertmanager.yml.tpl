global:
  resolve_timeout: 5m

route:
  receiver: telegram
  group_by: ["alertname", "severity"]
  group_wait: 30s
  group_interval: 5m
  repeat_interval: 3h
  routes:
    - matchers:
        - severity = "critical"
      receiver: telegram
      group_wait: 10s
      repeat_interval: 1h
    - matchers:
        - severity = "warning"
      receiver: telegram
      group_wait: 1m
      repeat_interval: 6h

receivers:
  - name: telegram
    telegram_configs:
      - bot_token: "${TELEGRAM_BOT_TOKEN}"
        chat_id: ${TELEGRAM_CHAT_ID}
        parse_mode: HTML
        send_resolved: true