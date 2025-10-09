# Bao Application v2 - Helm Charts with Environment Variables

## Overview

Version 2 of the Bao Application deployment uses Helm charts with environment variable substitution for secure configuration management. This approach separates sensitive data from the codebase and allows for different configurations per environment.

## Architecture

The application consists of three main components:
- **Database**: PostgreSQL with PgPool for connection pooling
- **Grafana**: OTEL LGTM stack for observability
- **Message Queue**: RabbitMQ for message processing

## Environment Variable Configuration

### Staging Environment
Configuration file: `staging/env-config.sh`

**Database Variables:**
- `POSTGRES_USER` - PostgreSQL username
- `POSTGRES_PASSWORD` - PostgreSQL password
- `POSTGRES_DB` - Database name
- `PGPOOL_BACKEND_NODES` - PgPool backend configuration

**Grafana Variables:**
- `GF_SECURITY_ADMIN_USER` - Grafana admin username
- `GF_SECURITY_ADMIN_PASSWORD` - Grafana admin password
- `ENABLE_LOGS_*` - Feature toggles for logging components
- `DOMAIN_NAME` - Domain for ingress
- `GF_SERVER_ROOT_URL` - Grafana server root URL
- `GF_SERVER_DOMAIN` - Grafana server domain

**RabbitMQ Variables:**
- `RABBITMQ_DEFAULT_USER` - RabbitMQ username
- `RABBITMQ_DEFAULT_PASS` - RabbitMQ password
- `RABBITMQ_ERLANG_COOKIE` - Erlang cookie for clustering

### Production Environment
Configuration file: `production/env-config.sh`
Uses the same variables as staging but with production-specific values and enhanced security.

## Deployment Process

### 1. Environment Setup
Each environment has its own configuration:
```bash
# Load environment variables
source ./staging/.env  # or production/.env
```

### 2. Variable Substitution
The deployment script uses `envsubst` to replace variables in the values files:
```bash
envsubst < values-staging.yaml > values-staging-processed.yaml
```

### 3. Helm Deployment
```bash
helm upgrade --install bao-application ./bao-application \
    --namespace bao-staging-env \
    --values values-staging-processed.yaml
```

## Usage

### Deploy to Staging
```bash
cd v2/staging
./deploy.sh
```

### Deploy to Production
```bash
cd v2/production
./deploy.sh
```

### Undeploy
```bash
# Staging
cd v2/staging
./undeploy.sh

# Production (requires confirmation)
cd v2/production
./undeploy.sh
```

## Security Features

1. **Environment Variable Isolation**: Sensitive data is stored in environment-specific configuration files
2. **No Hardcoded Secrets**: All sensitive values are externalized
3. **Production Safeguards**: Additional confirmation required for production operations
4. **Temporary Files**: Processed values files are automatically cleaned up

## File Structure

```
v2/
├── bao-application/           # Main Helm chart
│   ├── Chart.yaml
│   ├── values.yaml           # Default values
│   ├── values-staging.yaml   # Staging overrides (with env vars)
│   ├── values-production.yaml # Production overrides (with env vars)
│   └── charts/               # Sub-charts
│       ├── database/
│       ├── grafana/
│       └── message-queue/
├── staging/
│   ├── env-config.sh        # Staging environment variables
│   ├── deploy.sh            # Staging deployment script
│   └── undeploy.sh          # Staging removal script
└── production/
    ├── env-config.sh        # Production environment variables
    ├── deploy.sh            # Production deployment script
    └── undeploy.sh          # Production removal script
```

## Environment Variables Reference

| Variable | Description | Example |
|----------|-------------|---------|
| `POSTGRES_PASSWORD` | PostgreSQL password | `Qu_bao1604` |
| `GF_SECURITY_ADMIN_PASSWORD` | Grafana admin password | `Qu_bao1604` |
| `RABBITMQ_DEFAULT_PASS` | RabbitMQ password | `Qu_bao1604` |
| `DOMAIN_NAME` | Application domain | `dashboard.gauas.online` |
| `DEPLOY_ENV` | Environment name | `staging` or `production` |

## Migration from v1

The v2 approach improves upon v1 by:
- Using Helm for better dependency management
- Centralizing environment configuration
- Implementing proper secret management
- Providing consistent deployment workflows

## Troubleshooting

### Common Issues

1. **Missing envsubst**: Install gettext package
   ```bash
   # Ubuntu/Debian
   sudo apt-get install gettext-base
   
   # macOS
   brew install gettext
   ```

2. **Environment variables not loaded**: Ensure env-config.sh is sourced correctly

3. **Deployment failures**: Check namespace existence and RBAC permissions

### Verification

Check deployment status:
```bash
# Staging
kubectl get pods -n bao-staging-env

# Production  
kubectl get pods -n bao-production-env
```
