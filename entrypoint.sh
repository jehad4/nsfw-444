#!/bin/bash
echo "Luna waking up..."

# Start Ollama
ollama serve &
sleep 12

# Download model once
if ! ollama list | grep -q "dolphin-llama3:8b"; then
    echo "Downloading Luna's brain (4-8 min)..."
    ollama pull dolphin-llama3:8b
fi

echo "Luna is LIVE at https://nsfw-444.onrender.com"
exec gunicorn --bind 0.0.0.0:8080 app:app
