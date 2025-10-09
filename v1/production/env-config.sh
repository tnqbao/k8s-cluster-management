#!/bin/sh
# Database Configuration
export POSTGRES_USER="postgres"
export POSTGRES_PASSWORD="Qu_bao1604"
export POSTGRES_DB="postgres"

# Pgpool Admin
export PGPOOL_ADMIN_USERNAME=${POSTGRES_USER}
export PGPOOL_ADMIN_PASSWORD=${POSTGRES_PASSWORD}

# Pgpool Health Check
export PGPOOL_HEALTH_CHECK_USER=${PGPOOL_ADMIN_USERNAME}
export PGPOOL_HEALTH_CHECK_PASSWORD=${PGPOOL_ADMIN_PASSWORD}

# Pgpool Streaming Replication Check
export PGPOOL_SR_CHECK_USER=${PGPOOL_ADMIN_USERNAME}
export PGPOOL_SR_CHECK_PASSWORD=${PGPOOL_ADMIN_PASSWORD}

# Pgpool Internal Postgres Auth
export PGPOOL_POSTGRES_USERNAME=${POSTGRES_USER}
export PGPOOL_POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

export PGPOOL_BACKEND_NODES="0:postgres-service.bao-production-env.svc.cluster.local:5432"

# Grafana Configuration
export GF_SECURITY_ADMIN_USER="tnqbao"
export GF_SECURITY_ADMIN_PASSWORD="Qu_bao1604"
export ENABLE_LOGS_GRAFANA="true"
export ENABLE_LOGS_LOKI="true"
export ENABLE_LOGS_PROMETHEUS="false"
export ENABLE_LOGS_TEMPO="false"
export ENABLE_LOGS_PYROSCOPE="false"
export ENABLE_LOGS_OTELCOL="true"
export DOMAIN_NAME="dashboard.gauas.online"
export GF_SERVER_ROOT_URL="https://dashboard.gauas.online/"
export GF_SERVER_DOMAIN="dashboard.gauas.online"

# Message Queue (RabbitMQ) Configuration
export RABBITMQ_DEFAULT_VHOST="/"
export RABBITMQ_DEFAULT_USER="admin"
export RABBITMQ_DEFAULT_PASS="Qu_bao1604"

# Search Engine (MeiliSearch) Configuration
export MEILI_ENV="production"
export MEILI_MASTER_KEY="Qu_bao1604"

# Environment
export DEPLOY_ENV="production"
