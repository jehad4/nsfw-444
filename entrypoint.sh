#!/bin/bash
echo "Starting Luna..."

# Start Ollama
ollama serve &
sleep 10

# Download model once
if ! ollama list | grep -q "dolphin-llama3:8b"; then
    echo "Downloading model..."
    ollama pull dolphin-llama3:8b
fi

# ← THIS IS THE ONLY NEW PART (reverse proxy so /api/chat works)
apt-get update && apt-get install -y nginx
echo 'server {
    listen 8080;
    location / {
        root /public;
        index index.html;
    }
    location /api/ {
        proxy_pass http://127.0.0.1:11434/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}' > /etc/nginx/sites-available/default
nginx &

echo "Luna is LIVE → https://nsfw-444.onrender.com"
http-server /public -p 8080 --cors -c-1
