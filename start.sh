#!/bin/sh

# Проверяем, что токен задан
if [ -z "$NGROK_AUTH_TOKEN" ]; then
  echo "Ошибка: не найден NGROK_AUTH_TOKEN в переменных окружения!"
  exit 1
fi

# Авторизуем ngrok
ngrok config add-authtoken "$NGROK_AUTH_TOKEN"

# Запускаем ngrok в фоновом режиме (tcp-туннель на порт 25565)
ngrok tcp 25565 --log=stdout &

# Ждём секунду, чтобы ngrok успел подняться
sleep 2

# Запускаем Forge сервер как основной процесс
exec java -Xmx1G -jar forge-1.20.1-47.2.17-universal.jar nogui
