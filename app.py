from flask import Flask, send_from_directory, request, jsonify
import requests

app = Flask(__name__, static_folder='public')

OLLAMA_URL = "http://localhost:11434"

@app.route('/')
def index():
    return send_from_directory('public', 'index.html')

@app.route('/<path:path>')
def static_files(path):
    return send_from_directory('public', path)

@app.route('/api/<path:path>', methods=['GET', 'POST'])
def proxy(path):
    url = f"{OLLAMA_URL}/api/{path}"
    resp = requests.request(
        method=request.method,
        url=url,
        headers={k: v for k, v in request.headers if k != 'Host'},
        data=request.get_data(),
        cookies=request.cookies,
        allow_redirects=False
    )
    return (resp.content, resp.status_code, resp.headers.items())

if __name__ == "__main__":
    app.run()
