FROM ollama/ollama:latest

# পাবলিক অ্যাক্সেস
ENV OLLAMA_HOST=0.0.0.0
ENV OLLAMA_ORIGINS=*

# Node.js + http-server ইনস্টল করো (চ্যাটবক্সের জন্য)
RUN apt-get update && apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g http-server

# ফাইল কপি
COPY entrypoint.sh /entrypoint.sh
COPY public /public

RUN chmod +x /entrypoint.sh

EXPOSE 11434
EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
