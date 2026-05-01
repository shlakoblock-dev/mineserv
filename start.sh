#!/bin/sh
if [ -z "$NGROK_AUTH_TOKEN" ]; then
  echo "Ошибка: не найден NGROK_AUTH_TOKEN в переменных окружения!"
  exit 1
fi
ngrok config add-authtoken "$NGROK_AUTH_TOKEN"
ngrok tcp 25565 --log=stdout &
sleep 2
exec java -Xmx1G -jar $(ls /app/forge-*.jar | head -n 1) nogui
