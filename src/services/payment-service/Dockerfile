
# BUILDING STAGE

FROM maven:3.8-openjdk-8 AS builder
WORKDIR /app
COPY pom.xml ./
RUN mvn dependency:go-offline -q
COPY src src
RUN mvn clean package -DskipTests

# RUNTIME STAGE

FROM eclipse-temurin:8-jre
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
COPY --from=builder /app/target/*.jar app.jar
COPY wait-for-it.sh /app/wait-for-it.sh
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh wait-for-it.sh \ 
    && groupadd --system appgroup \
    && useradd --system --gid appgroup appuser 
USER appuser
EXPOSE 8084
HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=3 \
CMD wget --no-verbose --tries=1 --spider  http://localhost:8084/ || exit 1

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["java", "-jar", "app.jar"]

