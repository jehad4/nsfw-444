FROM ollama/ollama:latest

# পাবলিক অ্যাক্সেস
ENV OLLAMA_HOST=0.0.0.0
ENV OLLAMA_ORIGINS=*

# entrypoint কপি
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# ওয়েব চ্যাটবক্স কপি
COPY public /public

# পোর্ট
EXPOSE 11434
EXPOSE 80

# স্টার্টআপ
ENTRYPOINT ["/entrypoint.sh"]
