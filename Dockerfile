FROM ollama/ollama:latest

ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_ORIGINS=*

# Install tiny web server (10 MB only)
RUN apt-get update && apt-get install -y tini python3 python3-pip && \
    pip3 install flask gunicorn --break-system-packages

COPY entrypoint.sh /entrypoint.sh
COPY app.py /app.py
COPY public /public

RUN chmod +x /entrypoint.sh

EXPOSE 8080
ENV PORT=8080

ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]
