
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
COPY wait-for-it.sh /app/wait-for-it.sh
RUN chmod +x wait-for-it.sh
RUN groupadd --system appgroup && useradd --system --gid appgroup appuser 
USER appuser
EXPOSE 8087
HEALTHCHECK --interval=15s --timeout=5s --start-period=45s --retries=3 \
    CMD bash -c 'exec 3<>/dev/tcp/localhost/8087' || exit 1
    
CMD ["java", "-jar", "app.jar"]

