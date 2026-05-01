#!/bin/sh

echo "Запускаем pinggy туннель..."
# Пробрасываем порт 25565 наружу одной командой
ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=30 -R 0:localhost:25565 a.pinggy.io &
sleep 5

echo "Запускаем Paper сервер 1.20.1..."
exec java -Xmx400M -jar server.jar nogui
