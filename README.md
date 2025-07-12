# Shopverse

**Shopverse** is a modular, cloud-native e-commerce backend built using a microservices architecture. The goal of this project is to simulate a real-world distributed system and deepen expertise in backend engineering, event-driven design, and scalable deployment.

## Tech Stack

- **Java 17**, **Spring Boot 3.x**
- **Spring Cloud** – Gateway, Config Server, Eureka
- **Apache Kafka** – Event-driven communication
- **Microsoft SQL Server** – Persistent storage
- **Docker** & **Docker Compose** – Containerization
- **AWS Free Tier** – Deployment (EC2, RDS, S3, ECR, ECS)
- **JWT** – Authentication and authorization
- **Postman** – API testing
- **GitHub Actions** *(optional)* – CI/CD


## Microservices Overview

| Service               | Description                                     |
|-----------------------|-------------------------------------------------|
| `user-service`        | Handles user registration, login, auth          |
| `product-service`     | Manages product catalog                         |
| `inventory-service`   | Tracks stock levels                             |
| `order-service`       | Manages shopping cart, order placement          |
| `payment-service`     | Simulated payment gateway                       |
| `notification-service`| Sends email/SMS notifications (via Kafka)       |
| `analytics-service`   | Real-time metrics collector (Kafka consumer)    |
| `api-gateway`         | Routes requests to internal services            |
| `config-server`       | Centralized configuration                       |
| `service-registry`    | Eureka for service discovery                    |

---

