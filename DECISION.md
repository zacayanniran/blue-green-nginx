# Decision Notes
- Used Nginx upstream with backup role for failover.
- Tight timeouts and retry logic ensure zero failed requests.
- Parameterized via .env for CI flexibility.