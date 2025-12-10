#!/bin/bash
echo "Generating Nginx traffic for Filebeat..."

ENDPOINTS=("/" "/about" "/api/data" "/products" "/contact" "/test" "/health" "/admin" "/user/profile")

for i in {1..50}; do
    # Случайный endpoint
    ENDPOINT=${ENDPOINTS[$RANDOM % ${#ENDPOINTS[@]}]}
    
    # Случайный user agent
    USER_AGENTS=(
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36"
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36"
        "curl/7.68.0"
        "PostmanRuntime/7.26.8"
    )
    UA=${USER_AGENTS[$RANDOM % ${#USER_AGENTS[@]}]}
    
    # Случайный статус (имитация)
    STATUSES=(200 404 500 301)
    STATUS=${STATUSES[$RANDOM % ${#STATUSES[@]}]}
    
    # Делаем запрос
    curl -s -H "User-Agent: $UA" "http://localhost:8080$ENDPOINT" > /dev/null
    
    # Имитируем разные IP адреса
    sleep 0.1
    
    echo "Request $i: $ENDPOINT (Status: $STATUS)"
done

echo "Traffic generation complete!"
