FROM eclipse-temurin:17-jdk-alpine

# Устанавливаем нужные пакеты
RUN apk add --no-cache curl wget bash

WORKDIR /app

# --- Установка ngrok ---
RUN wget -q https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.tgz \
    && tar xf ngrok-stable-linux-amd64.tgz \
    && mv ngrok /usr/local/bin/ngrok \
    && rm ngrok-stable-linux-amd64.tgz

# --- Установка Forge 1.20.1 (рекомендованная версия 47.2.17 – она стабильна) ---
RUN curl -L -o forge-installer.jar \
    "https://maven.minecraftforge.net/net/minecraftforge/forge/1.20.1-47.2.17/forge-1.20.1-47.2.17-installer.jar" \
    && java -jar forge-installer.jar --installServer \
    && rm forge-installer.jar

# --- Папка mods и мод Create ---
RUN mkdir -p mods \
    && curl -L -o mods/create-1.20.1-0.5.1.i.jar \
    "https://cdn.modrinth.com/data/LNytGWDc/versions/0.5.1.i/create-1.20.1-0.5.1.i.jar"

# --- Принимаем EULA ---
RUN echo "eula=true" > eula.txt

# --- Копируем наши файлы ---
COPY server.properties /app/server.properties
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 25565

# Запускаем через наш скрипт
CMD ["/app/start.sh"]
