#!/bin/sh

# Проверяем токен
if [ -z "$NGROK_AUTH_TOKEN" ]; then
  echo "ОШИБКА: не задан NGROK_AUTH_TOKEN в переменных окружения Render!"
  exit 1
fi

# Авторизуем и запускаем ngrok
ngrok config add-authtoken "$NGROK_AUTH_TOKEN"
echo "Запускаем ngrok..."
ngrok tcp 25565 --log=stdout &

# Ждём, чтобы туннель поднялся
sleep 5

# Запускаем сервер (автоматически берём любой forge-универсал)
echo "Запускаем Minecraft сервер..."
exec java -Xmx1G -jar /app/forge-*.jar nogui
