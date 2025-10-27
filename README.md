# Blue/Green Deployment with Nginx

## How to Run
1. Copy `.env.caz` to `.env` and update values.
2. Run `docker-compose up -d`.
3. Access service at `http://localhost:8080/version`.
4. Induce chaos: `curl -X POST http://localhost:8081/chaos/start?mode=error`.
5. Verify failover: `curl http://localhost:8080/version`.

## Files
- docker-compose.yaml
- nginx.conf.template
- .env.caz