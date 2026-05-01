#!/bin/sh

PLAYIT_SECRET="514e2bd3d78ade26ef14b93a9a658bf79a6800f408d13d9c9eef25eaf0a22bb6"

echo "Запускаем playit.gg..."
playit --secret "$PLAYIT_SECRET" &
sleep 5

echo "Запускаем Paper сервер 1.20.1..."
exec java -Xmx400M -jar server.jar nogui
