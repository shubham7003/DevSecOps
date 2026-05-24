# AzureShield

AzureShield is a DevSecOps CI/CD pipeline on Microsoft Azure designed to embed automated security scanning at every stage of the software delivery lifecycle. It provides a robust, defense-in-depth approach covering source hardening, SAST, container security, runtime defense, and observability.

## Prerequisites
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm 3.x](https://helm.sh/docs/intro/install/)
- [Trivy](https://aquasecurity.github.io/trivy/latest/getting-started/installation/)
- [Cosign](https://docs.sigstore.dev/cosign/installation/)
- [Conftest](https://www.conftest.dev/install/)
- Python 3.11+

## Quick Start
1. Clone this repository.
2. Run `scripts/setup.sh` to verify your environment.
3. Deploy the infrastructure via Bicep: `az deployment group create --resource-group <rg-name> --template-file infra/bicep/main.bicep`.
4. Run the CI/CD pipeline in Azure DevOps pointing to `pipelines/azure-pipeline.yml`.

## Folder Structure
- `.husky/` - Pre-commit Git hooks
- `infra/` - Bicep IaC and Helm charts for provisioning and deployment
- `pipelines/` - Azure DevOps pipeline configurations and security templates
- `policies/` - OPA and Falco policies for compliance and runtime defense
- `scripts/` - Utility scripts for setup and CI/CD operations
- `src/` - Sample Python microservice

## Pipeline Templates
- **SAST**: ([sast.yml](pipelines/templates/sast.yml)) Code scanned for static vulnerabilities and secrets.
- **Container**: ([container.yml](pipelines/templates/container.yml)) Docker builds, container scanning, signing, and SBOM generation.
- **DAST**: ([dast.yml](pipelines/templates/dast.yml)) Dynamic Active Security Testing via OWASP ZAP on Staging.
- **Deploy**: ([deploy.yml](pipelines/templates/deploy.yml)) Helm deployment logic with smoke testing.

## Onboarding a New Application Team
1. Create a new microservice folder inside `src/`.
2. Provide a multi-stage Dockerfile that follows base-image restrictions (e.g., distroless).
3. Connect the new application manifest to the Bicep environment or Helm configurations.
4. Update the main pipeline build jobs to integrate the new service's artifact paths.
