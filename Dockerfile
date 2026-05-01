# ... всё до этого без изменений ...

# --- Установка Forge (без жёсткой маски) ---
RUN echo "Forge cache bust 1" && \
    curl -L -o forge-installer.jar \
    "https://maven.minecraftforge.net/net/minecraftforge/forge/1.20.1-47.2.17/forge-1.20.1-47.2.17-installer.jar" && \
    java -jar forge-installer.jar --installServer && \
    rm forge-installer.jar && \
    echo "=== Список всех jar в /app ===" && \
    ls -la /app/*.jar && \
    echo "=============================="

# ... дальше mods, eula, server.properties ...
