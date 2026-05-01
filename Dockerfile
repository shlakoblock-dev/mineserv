FROM eclipse-temurin:17-jdk-alpine

RUN apk add --no-cache curl wget bash

WORKDIR /app

# --- Ставим playit.gg ---
RUN curl -L -o /usr/local/bin/playit https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64 \
    && chmod +x /usr/local/bin/playit

# --- Качаем Paper 1.20.1 (последняя сборка) ---
RUN curl -L -o server.jar "https://api.papermc.io/v2/projects/paper/versions/1.20.1/builds/196/downloads/paper-1.20.1-196.jar"

# --- EULA ---
RUN echo "eula=true" > /app/eula.txt

# --- Копируем конфиги ---
COPY server.properties /app/server.properties
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 25565

CMD ["/app/start.sh"]
