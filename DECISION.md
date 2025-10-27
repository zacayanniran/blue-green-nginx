# Blue/Green Deployment Decisions

## NGINX Configuration
- **Upstreams**: `least_conn` for load balancing
- **Health Checks**: Built-in `max_fails=2 fail_timeout=5s`
- **Retry Policy**: `proxy_next_upstream` for 5xx/timeouts
- **Headers**: Forwarded `X-App-Pool`, `X-Release-Id` unchanged

## Failover Strategy
- **Primary/Backup**: Blue active, Green backup
- **Switch Time**: <10s (tight timeouts)
- **Zero Failed Requests**: Retries within same connection

## Docker Compose
- **Ports**: 8080 (Nginx), 8081 (Blue), 8082 (Green)
- **Health Checks**: `/healthz` endpoint
- **Parameterized**: `.env` for images, pool, release IDs

## Testing
- **Baseline**: All traffic to Blue
- **Chaos**: POST /chaos/start → Auto-switch to Green
- **Recovery**: POST /chaos/stop → Back to Blue