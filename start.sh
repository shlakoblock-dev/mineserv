#!/bin/bash

# ========== НАСТРОЙКИ (МЕНЯЙ ТУТ) ==========
# Прямая ссылка на серверный jar (Paper 1.20.1, последняя сборка)
SERVER_JAR_LINK="https://api.papermc.io/v2/projects/paper/versions/1.20.1/builds/196/downloads/paper-1.20.1-196.jar"
SERVER_JAR="server.jar"

# Ник администратора
ADMIN_NICK="slhakoblock"
# ============================================

echo "=========================================="
echo " Установка сервера Minecraft + pinggy"
echo "=========================================="

# 1. Создаём папку и переходим в неё
mkdir -p ~/mc-server && cd ~/mc-server

# 2. Устанавливаем ssh (на всякий случай, обычно он есть)
sudo apt-get update -qq && sudo apt-get install -y -qq openssh-client

# 3. Скачиваем сервер
echo ">>> Скачиваю сервер..."
curl -L -o $SERVER_JAR "$SERVER_JAR_LINK"

# 4. Скачиваем плагин AuthMe
echo ">>> Устанавливаю плагин AuthMe..."
mkdir -p plugins
curl -L -o plugins/AuthMe-5.6.0-beta2.jar "https://github.com/AuthMe/AuthMeReloaded/releases/download/5.6.0-beta2/AuthMe-5.6.0-beta2.jar"

# 5. Соглашаемся с EULA и настраиваем сервер
echo ">>> Принимаю правила..."
echo "eula=true" > eula.txt

# Базовые настройки server.properties (можно дополнить своими)
cat > server.properties <<EOF
allow-flight=true
allow-nether=true
difficulty=normal
enable-command-block=false
gamemode=survival
hardcore=false
max-players=20
motd=§aБратский сервер §6[1.20.1]§r
online-mode=false
pvp=true
server-port=25565
spawn-protection=0
view-distance=10
allow-end=true
enforce-secure-profile=false
EOF

# Выдаём права администратора только указанному нику
echo ">>> Назначаю администратора $ADMIN_NICK..."
cat > ops.json <<EOF
[
  {
    "uuid": "00000000-0000-0000-0000-000000000000",
    "name": "$ADMIN_NICK",
    "level": 4,
    "bypassesPlayerLimit": false
  }
]
EOF

# 6. Запускаем туннель pinggy и сразу ловим адрес
echo ">>> Запускаю туннель pinggy..."
# Запускаем в фоне с сохранением вывода
ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=30 -R 0:localhost:25565 a.pinggy.io &> /tmp/pinggy.log &
PINGGY_PID=$!

# Ждём, пока появится адрес
echo ">>> Ожидаю адрес от pinggy (10 секунд)..."
sleep 10

# Извлекаем адрес из лога и выводим
TUNNEL_ADDR=$(grep -oP 'tcp://\K[^ ]+' /tmp/pinggy.log | head -1)
if [ -n "$TUNNEL_ADDR" ]; then
  echo ""
  echo "=========================================="
  echo " ТВОЙ АДРЕС ДЛЯ ПОДКЛЮЧЕНИЯ:"
  echo " $TUNNEL_ADDR"
  echo " Скопируй его и передай друзьям!"
  echo "=========================================="
else
  echo "Не удалось автоматически получить адрес. Проверь лог вручную: cat /tmp/pinggy.log"
fi

# 7. Запускаем сервер
echo ">>> Запускаю Minecraft сервер..."
echo "Для остановки нажми CTRL+C"
java -Xmx2G -jar $SERVER_JAR nogui
