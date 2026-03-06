package com.learningpath.service;

import com.learningpath.model.LearningPath;
import com.learningpath.model.LearningPath.Phase;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class LearningPathService {

    private final Map<String, LearningPath> paths = new LinkedHashMap<>();

    public LearningPathService() {
        initPaths();
    }

    private void initPaths() {
        // QA / Testing Engineer
        paths.put("testing", new LearningPath(
            "testing", "QA / Testing Engineer", "Master quality assurance from manual to automation",
            "🧪", "#6366f1",
            List.of(
                new Phase("Phase 1: Fundamentals", List.of("Software Testing Basics", "SDLC & STLC", "Test Types (Unit, Integration, E2E)", "Bug Lifecycle & Reporting"), "4 weeks"),
                new Phase("Phase 2: Manual Testing", List.of("Test Case Design", "Equivalence Partitioning", "Boundary Value Analysis", "JIRA / TestRail", "API Testing with Postman"), "6 weeks"),
                new Phase("Phase 3: Test Automation", List.of("Java / Python Basics", "Selenium WebDriver", "TestNG / JUnit", "Page Object Model", "Maven / Gradle"), "8 weeks"),
                new Phase("Phase 4: Advanced", List.of("BDD with Cucumber", "CI/CD Integration", "Performance Testing (JMeter)", "API Automation (RestAssured)", "Docker for Testing"), "8 weeks"),
                new Phase("Phase 5: Expert", List.of("SDET Practices", "Test Architecture Design", "Cloud Testing (BrowserStack)", "Security Testing Basics", "AI in Testing"), "6 weeks")
            )
        ));

        // DevOps Engineer
        paths.put("devops", new LearningPath(
            "devops", "DevOps Engineer", "Bridge development and operations with modern tooling",
            "⚙️", "#10b981",
            List.of(
                new Phase("Phase 1: Foundations", List.of("Linux Fundamentals", "Networking Basics", "Shell Scripting (Bash)", "Version Control (Git)", "Python Scripting"), "4 weeks"),
                new Phase("Phase 2: CI/CD", List.of("Jenkins", "GitHub Actions", "GitLab CI", "Build Pipelines", "Artifact Management (Nexus)"), "6 weeks"),
                new Phase("Phase 3: Containers & Orchestration", List.of("Docker", "Docker Compose", "Kubernetes Fundamentals", "Helm Charts", "Service Mesh"), "8 weeks"),
                new Phase("Phase 4: Cloud & IaC", List.of("AWS / Azure / GCP", "Terraform", "Ansible", "CloudFormation", "Pulumi"), "8 weeks"),
                new Phase("Phase 5: Monitoring & Security", List.of("Prometheus & Grafana", "ELK Stack", "DevSecOps", "SRE Practices", "Cost Optimization"), "6 weeks")
            )
        ));

        // .NET Developer
        paths.put("dotnet", new LearningPath(
            "dotnet", ".NET Developer", "Build enterprise applications with the .NET ecosystem",
            "💜", "#8b5cf6",
            List.of(
                new Phase("Phase 1: C# Basics", List.of("C# Syntax & OOP", "Data Types & Collections", "LINQ", "Exception Handling", "File I/O"), "4 weeks"),
                new Phase("Phase 2: .NET Core", List.of("ASP.NET Core MVC", "Web API Development", "Entity Framework Core", "Dependency Injection", "Middleware"), "6 weeks"),
                new Phase("Phase 3: Data & Security", List.of("SQL Server", "Dapper ORM", "Authentication & JWT", "Authorization", "Data Validation"), "6 weeks"),
                new Phase("Phase 4: Advanced Patterns", List.of("Clean Architecture", "CQRS & MediatR", "gRPC", "SignalR", "Microservices"), "8 weeks"),
                new Phase("Phase 5: Cloud & DevOps", List.of("Azure DevOps", "Docker & Kubernetes", "Azure Functions", "Application Insights", "CI/CD Pipelines"), "6 weeks")
            )
        ));

        // Java Developer
        paths.put("java", new LearningPath(
            "java", "Java Developer", "Master Java from fundamentals to enterprise-grade apps",
            "☕", "#f59e0b",
            List.of(
                new Phase("Phase 1: Java Core", List.of("OOP Concepts", "Java Collections", "Generics & Streams", "Exception Handling", "Multithreading"), "4 weeks"),
                new Phase("Phase 2: Spring Framework", List.of("Spring Core & IoC", "Spring MVC", "Spring Boot", "Spring Data JPA", "Spring Security"), "8 weeks"),
                new Phase("Phase 3: Database & ORM", List.of("JDBC", "Hibernate", "MySQL / PostgreSQL", "Redis Caching", "Database Design"), "6 weeks"),
                new Phase("Phase 4: Microservices", List.of("REST API Design", "Spring Cloud", "API Gateway", "Service Discovery (Eureka)", "Message Queues (Kafka)"), "8 weeks"),
                new Phase("Phase 5: Production", List.of("Docker & Kubernetes", "AWS / GCP", "Performance Tuning", "Monitoring (Actuator)", "Clean Code & Design Patterns"), "6 weeks")
            )
        ));

        // Frontend Developer
        paths.put("frontend", new LearningPath(
            "frontend", "Frontend Developer", "Create stunning user interfaces for the modern web",
            "🎨", "#ec4899",
            List.of(
                new Phase("Phase 1: Web Fundamentals", List.of("HTML5 Semantics", "CSS3 & Flexbox/Grid", "JavaScript ES6+", "DOM Manipulation", "Responsive Design"), "4 weeks"),
                new Phase("Phase 2: JavaScript Deep Dive", List.of("Async/Await & Promises", "Fetch API / Axios", "ES Modules", "LocalStorage", "TypeScript Basics"), "5 weeks"),
                new Phase("Phase 3: React / Vue", List.of("Component Architecture", "State Management (Redux/Pinia)", "React Hooks", "Routing", "Forms & Validation"), "8 weeks"),
                new Phase("Phase 4: Build Tools & Testing", List.of("Vite / Webpack", "Jest & Testing Library", "Cypress E2E", "Storybook", "Performance Optimization"), "6 weeks"),
                new Phase("Phase 5: Professional", List.of("Web Accessibility (a11y)", "PWA", "GraphQL", "Web Security", "CI/CD for Frontend"), "5 weeks")
            )
        ));

        // Data Engineer
        paths.put("data", new LearningPath(
            "data", "Data Engineer", "Build robust data pipelines and analytics infrastructure",
            "📊", "#14b8a6",
            List.of(
                new Phase("Phase 1: Foundations", List.of("Python for Data", "SQL Advanced", "Data Modeling", "Statistics Basics", "Excel / Pandas"), "4 weeks"),
                new Phase("Phase 2: Big Data", List.of("Hadoop Ecosystem", "Apache Spark", "Hive & HBase", "Kafka Streaming", "Flink"), "8 weeks"),
                new Phase("Phase 3: Data Warehousing", List.of("Snowflake", "Redshift / BigQuery", "dbt (Data Build Tool)", "Star Schema Design", "ETL vs ELT"), "6 weeks"),
                new Phase("Phase 4: Pipelines & Orchestration", List.of("Apache Airflow", "Luigi", "Prefect", "Data Quality (Great Expectations)", "CI/CD for Data"), "6 weeks"),
                new Phase("Phase 5: Cloud & ML Ops", List.of("AWS Glue / Athena", "Azure Data Factory", "MLflow", "Feature Stores", "DataOps Practices"), "8 weeks")
            )
        ));
    }

    public Collection<LearningPath> getAllPaths() {
        return paths.values();
    }

    public LearningPath getPathById(String id) {
        return paths.get(id);
    }

    public Map<String, LearningPath> getPathsMap() {
        return paths;
    }
}
