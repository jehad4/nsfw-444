from flask import Flask, send_from_directory, request, jsonify
import requests
import os

app = Flask(__name__, static_folder='public')
OLLAMA_URL = "http://127.0.0.1:11434"   # ← fixed localhost

@app.route('/')
def index():
    return send_from_directory('public', 'index.html')

@app.route('/<path:path>')
def static_proxy(path):
    return send_from_directory('public', path)

@app.route('/api/<path:subpath>', methods=['GET', 'POST'])
def ollama_proxy(subpath):
    url = f"{OLLAMA_URL}/api/{subpath}"
    resp = requests.request(
        method=request.method,
        url=url,
        headers={k: v for k, v in request.headers if k.lower() != 'host'},
        data=request.get_data(),
        allow_redirects=False,
        timeout=300
    )
    return (resp.content, resp.status_code, resp.headers.items())

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
