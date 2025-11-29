#!/bin/bash
# প্রথমবার মডেল চেক করুন এবং পুল করুন
if ! ollama list | grep -q "dolphin-mixtral:8x7b"; then
    echo "NSFW মডেল ডাউনলোড হচ্ছে... (৫-১০ মিনিট লাগতে পারে)"
    ollama pull dolphin-mixtral:8x7b
fi

# Ollama সার্ভার চালু করুন
exec ollama serve
