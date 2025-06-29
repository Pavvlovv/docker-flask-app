from flask import Flask
import os
import socket

app = Flask(__name__)

@app.route('/')
def hello():
    hostname = socket.gethostname()
    return f"Hello, Alex! I'm running inside a container on host: {hostname}\n"

if __name__ == "__main__":
    # Получаем порт из переменной окружения APP_PORT.
    # Если переменная не задана, используем 8080 по умолчанию.
    port = int(os.environ.get('APP_PORT', '8080'))
    
    # Запускаем сервер на указанном порту
    app.run(host='0.0.0.0', port=port)
