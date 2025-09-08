from flask import Flask, request
import subprocess

app = Flask(__name__)

@app.route('/open_vscode', methods=['POST'])
def open_vscode():
    file_path = request.json.get('file_path')
    if not file_path:
        return {'error': 'file_path not provided'}, 400

    # VSCode CLI を呼ぶ
    code_path = '/usr/local/bin/code'  # macOSの場合
    subprocess.run([code_path, '--reuse-window', '--goto', f'{file_path}:1:1'])
    return {'status': 'success'}

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000)