from flask import Flask
import os
import socket

# Создаем экземпляр приложения Flask
app = Flask(__name__)

# Определяем маршрут для корневого URL ('/')
@app.route('/')
def hello():
    # Получаем имя хоста, чтобы видеть, где мы работаем
    hostname = socket.gethostname()
    return f"Hello, Alex! I'm running inside a container on host: {hostname}\n"

# Условие для запуска сервера при выполнении скрипта напрямую
if __name__ == "__main__":
    # Запускаем веб-сервер на всех сетевых интерфейсах ('0.0.0.0')
    # Это обязательно для доступа к контейнеру извне.
    # Порт 8080 будет использоваться внутри контейнера.
    app.run(host='0.0.0.0', port=8080)
