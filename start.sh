#!/bin/sh

# Вставляем токен напрямую (замени на свой, если надо)
NGROK_TOKEN="3D6BfjFOACUPaerNo6YA4Jp6IGi_6JbDA5dLLngu8dEDtXemW"

echo "Запускаем ngrok v3..."
ngrok tcp 25565 --authtoken "$NGROK_TOKEN" --log=stdout &

sleep 3

echo "Запускаем Minecraft сервер..."
exec java -Xmx1G -jar $(ls /app/forge-*.jar | head -n 1) nogui
