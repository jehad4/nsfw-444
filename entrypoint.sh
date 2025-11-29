#!/bin/bash
echo "Luna is waking up..."

# Start Ollama in background
ollama serve &
sleep 12

# Download model only once
if ! ollama list | grep -q "dolphin-llama3:8b"; then
    echo "Downloading Luna's horny brain (4-8 min)..."
    ollama pull dolphin-llama3:8b
    echo "Luna is ready and dripping"
else
    echo "Luna already loaded"
fi

echo "LIVE → https://nsfw-444.onrender.com"
exec gunicorn --bind 0.0.0.0:8080 app:app --workers 1 --timeout 300
