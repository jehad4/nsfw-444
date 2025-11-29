FROM ollama/ollama:latest

# Allow public access
ENV OLLAMA_HOST=0.0.0.0
ENV OLLAMA_ORIGINS=*

# Install Node.js + http-server for the web UI
RUN apt-get update && apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g http-server

# Copy files
COPY entrypoint.sh /entrypoint.sh
COPY public /public

RUN chmod +x /entrypoint.sh

# Web UI on port 8080
EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
