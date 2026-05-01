#!/bin/sh

# Секретный ключ playit.gg (лучше через переменную окружения)
PLAYIT_SECRET="514e2bd3d78ade26ef14b93a9a658bf79a6800f408d13d9c9eef25eaf0a22bb6"

echo "Запускаем playit.gg..."
playit --secret "$PLAYIT_SECRET" --tcp 25565 &
sleep 5

echo "Запускаем Minecraft сервер..."
exec java -Xmx1G -jar $(ls /app/forge-*universal.jar | head -n 1) nogui
