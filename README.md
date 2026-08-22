# 🚀 Axion System Monorepo

Welcome to the **Axion System Microservices Monorepo**. Axion is a state-of-the-art Industrial IoT (IIoT) telemetry condition monitoring and anomaly alerting platform. It simulates, ingests, stores, queries, and visualizes real-time sensor metrics (temperature, vibration, electrical current) from industrial assets (pumps, motors, compressors) across multiple refinery regions.

This repository serves as the unified codebase for the Axion platform, consolidating all microservices, Kubernetes manifests, and Terraform infrastructure. It provides a single source of truth for service deployment, infrastructure provisioning, and system configuration, enabling reproducible environments and streamlined CI/CD workflows.

---

## 📐 System Architecture & Data Flow

The platform is designed around a decoupled microservice architecture:

```
┌────────────────────────┐
│  axion-data-simulator  │  (Generates mock telemetry & injects anomalies)
└───────────┬────────────┘
            │
            │ HTTP POST /api/v1/telemetry/ingest
            ▼
┌────────────────────────┐
│axion-ingestion-service │  (FastAPI - Ingests data asynchronously)
└───────────┬────────────┘
            │
            │ asyncpg connection pool
            ▼
┌────────────────────────┐
│      PostgreSQL        │  (Stores telemetry & query logs)
└───────────▲────────────┘
            │
            │ Read Queries
            ▼
┌────────────────────────┐
│ axion-telemetry-query  │  (FastAPI - Exposes dashboard aggregation APIs)
└───────────▲────────────┘
            │
            │ HTTP GET /dashboard/*
            ▼
┌────────────────────────┐
│      axion-ui          │  (React + Vite + TS - 3D Digital Twin, Maps & Trends)
└────────────────────────┘
```

---

## 📁 Repository Structure

The monorepo is structured as follows:

```
axion-system-microservices-monorepo/
├── axion-microservices/
│   ├── axion-data-simulator-main/      # Python telemetry data generator with random-walk algorithm
│   ├── axion-database-schema-main/     # PostgreSQL schema migrations (Extensions & Telemetry tables)
│   ├── axion-ingestion-service-main/   # FastAPI service for telemetry ingestion and storage
│   ├── axion-telemetry-query-service/  # FastAPI service querying telemetry for the dashboard
│   └── axion-ui-main/                  # Vite + React + TypeScript + Tailwind CSS dashboard UI
├── infra-terraform/
│   ├── environments/
│   │   ├── development/                # Dev environment provisioning (AKS & ACR on Azure)
│   │   └── production/                 # Placeholder for Prod environment provisioning
│   └── modules/                        # Reusable Terraform infrastructure modules (AKS, ACR, RG, Roles)
└── k8s-manifest/
    └── namespace.yaml                  # Declarative Kubernetes namespace configuration
```

---

## 🛠️ Components & Technology Stack

### 1. [📈 Data Simulator](file:///Users/anurag_vijay/Working-Directory/Github-Private%20Repositories/axion-system-microservices-monorepo/axion-microservices/axion-data-simulator-main)
* **Description**: A client-side service simulating physical equipment (Pumps, Motors, Compressors) spread across 5 regions (North, South, East, West, and Central Refineries).
* **Algorithm**: Uses a random-walk algorithm for natural metric drift, adding realistic noise and a 1% probability of anomaly spikes.
* **Tech Stack**: Python 3.12, `requests`.

### 2. [🛢️ Database Schema](file:///Users/anurag_vijay/Working-Directory/Github-Private%20Repositories/axion-system-microservices-monorepo/axion-microservices/axion-database-schema-main)
* **Description**: Manages table structures and database indexes optimized for time-series telemetry storage.
* **Tech Stack**: PostgreSQL 13+, SQL Migrations.

### 3. [🚀 Ingestion Service](file:///Users/anurag_vijay/Working-Directory/Github-Private%20Repositories/axion-system-microservices-monorepo/axion-microservices/axion-ingestion-service-main)
* **Description**: High-throughput service receiving telemetry payloads and writing them to the database.
* **Tech Stack**: FastAPI, Pydantic v2, `asyncpg` (async connection pooling), Uvicorn.

### 4. [🔍 Telemetry Query Service](file:///Users/anurag_vijay/Working-Directory/Github-Private%20Repositories/axion-system-microservices-monorepo/axion-microservices/axion-telemetry-query-service-main)
* **Description**: Service providing analytics APIs for the monitoring dashboard (latest telemetry, device trends, regional summaries, system throughput, and top anomalous devices).
* **Tech Stack**: FastAPI, `asyncpg`, Uvicorn.

### 5. [🖥️ Frontend UI Dashboard](file:///Users/anurag_vijay/Working-Directory/Github-Private%20Repositories/axion-system-microservices-monorepo/axion-microservices/axion-ui-main)
* **Description**: Real-time condition monitoring UI featuring a 3D Digital Twin visualization (Three.js), Leaflet Map integration, anomaly alert panel, throughput monitoring, and historical trends.
* **Tech Stack**: React 19, TypeScript, Vite, Tailwind CSS v4, React Three Fiber (R3F), Leaflet, Recharts.

---

## ⚙️ Infrastructure & Deployment

### Infrastructure as Code (IaC)
Infrastructure is defined via Terraform inside [infra-terraform/](file:///Users/anurag_vijay/Working-Directory/Github-Private%20Repositories/axion-system-microservices-monorepo/infra-terraform) andtargets Azure Cloud:
* **Resource Group**: Unified logical container.
* **Azure Container Registry (ACR)**: Image repository.
* **Azure Kubernetes Service (AKS)**: Container execution platform.
* **RBAC Role Assignment**: Grants AKS `ACRPull` permissions on ACR.

### Kubernetes Manifests
The [k8s-manifest/](file:///Users/anurag_vijay/Working-Directory/Github-Private%20Repositories/axion-system-microservices-monorepo/k8s-manifest) directory manages basic cluster setups, creating the `axion-system` namespace to isolate application workloads.

---

## 🚀 Getting Started (Local Run)

To run the full stack locally, follow these steps:

### 1. Database Setup
Ensure PostgreSQL is running and apply the schema migrations in order:
```bash
cd axion-microservices/axion-database-schema-main
cat *.sql | psql -h localhost -U postgres -d axiondb
```

### 2. Ingestion Service Setup
```bash
cd ../axion-ingestion-service-main
pip install -r requirements.txt
cp .env.example .env # configure your DATABASE_URL
uvicorn main:app --reload --port 8000
```

### 3. Telemetry Query Service Setup
```bash
cd ../axion-telemetry-query-service-main
pip install -r requirements.txt
# Set environment variables for DB connection
export DATABASE_URL="postgresql://postgres:postgres@localhost:5432/axiondb"
export PORT=8001
python main.py
```

### 4. Data Simulator Setup
```bash
cd ../axion-data-simulator-main
pip install -r requirements.txt
export API_URL="http://localhost:8000/api/v1/telemetry/ingest"
python simulator.py
```

### 5. Frontend UI Setup
```bash
cd ../axion-ui-main
npm install
npm run dev
```
Open `http://localhost:5173` to explore the dashboard.

---

## 🐳 Docker Images
The images are structured to be built and stored in the Azure Container Registry (or Docker Hub):
* **Ingestion Service**: `devopsinsiders/axion-ingestion-service:latest`
* **Query Service**: `devopsinsiders/axion-telemetry-query-service:latest`
* **UI Service**: `devopsinsiders/axion-ui:latest`
* **Simulator**: `devopsinsiders/axion-data-simulator:latest`
