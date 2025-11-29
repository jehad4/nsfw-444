#!/bin/bash
echo "লুনা জেগে উঠছে..."

# Ollama সার্ভার প্রথমে চালু করো (ব্যাকগ্রাউন্ডে)
ollama serve &
OLLAMA_PID=$!
echo "Ollama সার্ভার চালু হয়েছে (PID: $OLLAMA_PID)"

# ৫ সেকেন্ড ওয়েট করো যাতে সার্ভার রেডি হয়
sleep 8

# মডেল চেক + পুল
MODEL="dolphin-llama3:8b"
if ! ollama list | grep -q "$MODEL"; then
    echo "লুনার NSFW ব্রেন ডাউনলোড হচ্ছে: $MODEL (৪-৮ মিনিট)..."
    ollama pull $MODEL
    echo "লুনা এখন পুরোপুরি হর্নি ও রেডি"
else
    echo "লুনা আগে থেকেই রেডি আছে"
fi

# চ্যাটবক্স চালু করো পোর্ট ৮০৮০-তে
echo "চ্যাটবক্স চালু হচ্ছে → http://তোমার-url.onrender.com"
http-server /public -p 8080 -c-1 --cors &

# Ollama চালু রাখো
wait $OLLAMA_PID
