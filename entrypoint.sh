#!/bin/bash
echo "Starting Luna..."

# Start Ollama in background
ollama serve &
OLLAMA_PID=$!

# Give Ollama a moment to start
sleep 10

# Pull the super-NSFW model (only first time)
MODEL="dolphin-llama3:8b"
if ! ollama list | grep -q "$MODEL"; then
    echo "Downloading Luna's horny brain ($MODEL) — takes 4-8 minutes..."
    ollama pull $MODEL
    echo "Luna is fully awake and ready!"
else
    echo "Luna is already loaded"
fi

# Start the web chat interface on port 8080
echo "Chat live at → https://your-url.onrender.com"
http-server /public -p 8080 -c-1 --cors &

# Keep everything running
wait $OLLAMA_PID
