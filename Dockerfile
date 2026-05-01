FROM eclipse-temurin:17-jdk-alpine

RUN apk add --no-cache curl wget bash

WORKDIR /app

# --- Установка playit.gg (официальный бинарник) ---
RUN curl -L -o /usr/local/bin/playit https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64 \
    && chmod +x /usr/local/bin/playit

# --- Установка Forge 1.20.1 (47.2.17) ---
RUN curl -L -o forge-installer.jar \
    "https://maven.minecraftforge.net/net/minecraftforge/forge/1.20.1-47.2.17/forge-1.20.1-47.2.17-installer.jar" \
    && java -jar forge-installer.jar --installServer \
    && rm forge-installer.jar \
    && ls -la /app/forge-*universal.jar || echo "FATAL: Forge universal jar not found!"

# --- Папка mods и Create ---
RUN mkdir -p mods \
    && curl -L -o mods/create-1.20.1-0.5.1.i.jar \
    "https://cdn.modrinth.com/data/LNytGWDc/versions/0.5.1.i/create-1.20.1-0.5.1.i.jar"

# --- EULA ---
RUN echo "eula=true" > /app/eula.txt

# --- Копируем конфиги ---
COPY server.properties /app/server.properties
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 25565

CMD ["/app/start.sh"]
