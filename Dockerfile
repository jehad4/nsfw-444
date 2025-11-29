FROM ollama/ollama:latest

ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_ORIGINS=*

# Install Python + pip + tini + Flask (with the magic flag)
RUN apt-get update && apt-get install -y python3 python3-pip tini && \
    pip3 install --no-cache-dir --break-system-packages flask gunicorn requests && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
COPY app.py /app.py
COPY public /public

RUN chmod +x /entrypoint.sh

EXPOSE 8080
ENV PORT=8080

ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]
