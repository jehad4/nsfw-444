#!/bin/bash
echo "Starting Luna..."

# Start Ollama in background
ollama serve &
sleep 10

# Download model once
if ! ollama list | grep -q "dolphin-llama3:8b"; then
    echo "Downloading model (4-8 minutes)..."
    ollama pull dolphin-llama3:8b
fi

# Serve the chat UI on the main URL
echo "Luna is live → https://nsfw-444.onrender.com"
http-server /public -p 8080 --cors -c-1
