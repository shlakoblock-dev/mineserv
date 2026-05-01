#!/bin/sh

if [ -z "$NGROK_AUTH_TOKEN" ]; then
  echo "ОШИБКА: переменная NGROK_AUTH_TOKEN не задана!"
  exit 1
fi

echo "Авторизуем ngrok..."
ngrok authtoken "$NGROK_AUTH_TOKEN"
echo "Запускаем ngrok..."
ngrok tcp 25565 --log=stdout &
sleep 3

echo "Запускаем Minecraft сервер..."
exec java -Xmx1G -jar $(ls /app/forge-*.jar | head -n 1) nogui
