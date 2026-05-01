FROM eclipse-temurin:17-jdk-alpine

RUN apk add --no-cache curl

WORKDIR /app

# 1. Скачиваем и устанавливаем Forge 1.20.1
RUN curl -L -o forge-installer.jar "https://maven.minecraftforge.net/net/minecraftforge/forge/1.20.1-47.4.18/forge-1.20.1-47.4.18-installer.jar" && \
    java -jar forge-installer.jar --installServer && \
    rm forge-installer.jar

# 2. Создаём папку mods и кладём туда Create (прямая ссылка Modrinth)
RUN mkdir mods && \
    curl -L -o mods/create-1.20.1-0.5.1.i.jar "https://cdn.modrinth.com/data/LNytGWDc/versions/6.0.8/create-1.20.1-6.0.8.jar"

# 3. Принимаем EULA
RUN echo "eula=true" > eula.txt

# 4. Копируем наш файл настроек server.properties (он перезапишет дефолтный)
COPY server.properties /app/server.properties

# 5. Копируем скрипт запуска и даём права
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Порт, который будет слушать сервер
EXPOSE 25565

# Стартуем всё через наш скрипт
CMD ["/app/start.sh"]
