from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World from Flask in Docker!'

@app.route('/health')
def health():
    return {'status': 'healthy'}, 200

def main():
    app.run(host='0.0.0.0', port=5000)
