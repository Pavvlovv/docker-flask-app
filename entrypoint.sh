#!/bin/sh
# Этот скрипт-обертка позволяет использовать переменные окружения
# в exec-форме CMD/ENTRYPOINT, сохраняя корректную обработку сигналов.

# `exec` заменяет процесс shell-скрипта на процесс gunicorn.
# Это позволяет gunicorn получать сигналы напрямую (например, SIGTERM от `docker stop`).
exec gunicorn --bind 0.0.0.0:${APP_PORT} app:app
