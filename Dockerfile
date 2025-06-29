# Этап 1: 'builder' - устанавливает зависимости в изолированном окружении
FROM python:3.10-slim AS builder

WORKDIR /app

# Копируем только файл с зависимостями для кеширования
COPY requirements.txt .

# Устанавливаем зависимости. Они попадут в системный site-packages этого образа.
RUN pip install --no-cache-dir -r requirements.txt


# Этап 2: Финальный, production-ready образ
FROM python:3.10-slim

# Создаем пользователя с ограниченными правами и рабочую директорию
RUN useradd --create-home appuser
WORKDIR /home/appuser/app

# Копируем ТОЛЬКО установленные пакеты из системного site-packages стадии 'builder'.
# Это ключевой шаг многостадийной сборки.
COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages

# Копируем код приложения и наш новый скрипт-точку входа
COPY app.py entrypoint.sh ./

# Делаем скрипт исполняемым и меняем владельца всех файлов
RUN chmod +x entrypoint.sh
RUN chown -R appuser:appuser .

# Переключаемся на нашего безопасного пользователя
USER appuser

# Устанавливаем переменную окружения по умолчанию
ENV APP_PORT=8080

# Документируем порт, который приложение слушает
EXPOSE 8080

# Запускаем приложение через наш скрипт-точку входа
ENTRYPOINT ["./entrypoint.sh"]
