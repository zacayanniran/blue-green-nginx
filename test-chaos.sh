#!/bin/bash
# Test Blue/Green failover

source .env

echo "í·ª Testing Blue/Green failover..."

# Baseline: Test Blue (active)
echo "1. Baseline (Blue active):"
curl -s -w "\nHTTP: %{http_code}\nPool: %{X-App-Pool}\nRelease: %{X-Release-Id}\n" \
  -H "Host: localhost" \
  http://localhost:8080/version

# 2. Induce chaos on Blue
echo "2. Inducing chaos on Blue..."
curl -X POST http://localhost:8081/chaos/start?mode=error

# 3. Test failover (should switch to Green)
echo "3. Testing failover to Green..."
for i in {1..5}; do
  curl -s -w "\nHTTP: %{http_code}\nPool: %{X-App-Pool}\nRelease: %{X-Release-Id}\n" \
    -H "Host: localhost" \
    http://localhost:8080/version
  sleep 1
done

# 4. Stop chaos
echo "4. Stopping chaos..."
curl -X POST http://localhost:8081/chaos/stop

# 5. Verify Blue recovers
echo "5. Verifying Blue recovery..."
sleep 2
curl -s -w "\nHTTP: %{http_code}\nPool: %{X-App-Pool}\nRelease: %{X-Release-Id}\n" \
  -H "Host: localhost" \
  http://localhost:8080/version

echo "í·ª Test complete! Check logs for results."
