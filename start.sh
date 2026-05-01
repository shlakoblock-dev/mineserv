#!/bin/sh

PLAYIT_SECRET="514e2bd3d78ade26ef14b93a9a658bf79a6800f408d13d9c9eef25eaf0a22bb6"

echo "Запускаем playit.gg..."
playit --secret "$PLAYIT_SECRET" --tcp 25565 &
sleep 5

echo "Ищем серверный jar..."
# Берём любой forge*jar или minecraft_server*.jar
SERVER_JAR=$(ls /app/forge-*.jar /app/minecraft_server*.jar 2>/dev/null | head -n 1)
if [ -z "$SERVER_JAR" ]; then
  echo "Не найден серверный jar! Вывожу список всех jar:"
  ls -la /app/*.jar
  exit 1
fi
echo "Найден серверный jar: $SERVER_JAR"
exec java -Xmx1G -jar "$SERVER_JAR" nogui
