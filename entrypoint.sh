#!/bin/bash
echo "লুনা ওয়েক আপ করছে..."

# সুপার হর্নি NSFW মডেল (৪GB, Render/Fly.io ফ্রি-তে পারফেক্ট)
MODEL="dolphin-llama3:8b"

if ! ollama list | grep -q "$MODEL"; then
    echo "প্রথমবার মডেল ডাউনলোড হচ্ছে: $MODEL (৪-৮ মিনিট)..."
    ollama pull $MODEL
    echo "লুনা রেডি হয়ে গেছে"
else
    echo "লুনা আগে থেকেই রেডি আছে"
fi

# Ollama + সিম্পল ওয়েব সার্ভার একসাথে চালাও
echo "চ্যাটবক্স চালু হচ্ছে → http://তোমার-url.onrender.com"
ollama serve &
npx http-server /public -p 80 -c-1 --cors
