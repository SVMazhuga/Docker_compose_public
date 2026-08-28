# BUILD STAGE

# образ для сборки (не забываем про AS builder)
FROM maven:3.8-openjdk-8 AS builder

# Указываем рабочую директорию для сборки внутри контейнера
WORKDIR /app

# Копируем компоненты java,которые редко меняются в верхние слои 
# Копируем maven в рабочую директорию, чтобы был

# переносим зависимости, обёртку maven
COPY pom.xml ./

# Качаем зависимости 
RUN mvn dependency:go-offline -q

#Копируем директорию с исходниками
COPY src src

#Собираем бинарь. Юнит-тестов нет, мы их не писали, поэтому DskipTests 
# clean - каждую новую сборку - чистить старую папку target
RUN mvn clean package -DskipTests


# RUNTIME STAGE

FROM eclipse-temurin:8-jre

WORKDIR /app

# Забираю со стейджа сборки все бинари
COPY --from=builder /app/target/*.jar app.jar

# копирую runtime-скрипт ожидания доступности сервиса
COPY wait-for-it.sh /app/wait-for-it.sh
COPY entrypoint.sh /app/entrypoint.sh
# Делаю файлы исполняемыми, создаю сервисного юзера, группу
RUN chmod +x /app/entrypoint.sh /app/wait-for-it.sh \ 
    && groupadd --system appgroup \
    && useradd --system --gid appgroup appuser 

USER appuser

# Аннотация чисто для инженера  
EXPOSE 8081

# В  eclipse нет curl, попробую проверять здоровье через wget обращаясь по пути /
HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=3 \
CMD wget --no-verbose --tries=1 --spider  http://localhost:8081/ || exit 1

# Обращаюсь к скрипту, запускающему wait-for-it.sh для нужных сервисов
ENTRYPOINT ["/app/entrypoint.sh"]

CMD ["java", "-jar", "app.jar"]

