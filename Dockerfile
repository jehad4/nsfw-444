FROM ollama/ollama:latest

# এনভায়রনমেন্ট সেট করুন (পাবলিক অ্যাক্সেসের জন্য)
ENV OLLAMA_HOST=0.0.0.0
ENV OLLAMA_ORIGINS=*

# এন্ট্রিপয়েন্ট স্ক্রিপ্ট তৈরি করুন
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 11434

ENTRYPOINT ["/entrypoint.sh"]
CMD ["ollama", "serve"]
