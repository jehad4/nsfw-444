#!/bin/bash
echo "Luna is waking up..."

# Start Ollama in background but KEEP IT ALIVE
nohup ollama serve > /dev/null 2>&1 &

# Wait until Ollama is actually listening
echo "Waiting for Ollama to start..."
until curl -s http://127.0.0.1:11434 > /dev/null; do
    sleep 2
done
echo "Ollama is ready!"

# Download model once
if ! ollama list | grep -q "dolphin-llama3:8b"; then
    echo "Downloading Luna's horny brain (4-8 min)..."
    ollama pull dolphin-llama3:8b
    echo "Luna is fully loaded"
else
    echo "Luna already loaded"
fi

echo "LIVE → https://nsfw-444.onrender.com"
exec gunicorn --bind 0.0.0.0:8080 app:app --workers 1 --timeout 300
