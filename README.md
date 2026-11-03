# Terraform + Azure + GitHub Actions | DevSecOps Infrastructure Demo

A portfolio-ready demo showing how to validate, scan, plan, and manually approve Terraform changes before deploying a small Azure resource group and virtual network.

> **Demo / learning project:** Review the code and configure your own Azure subscription and GitHub OIDC trust before running `apply`. No credentials are included.

## What this project demonstrates

- Infrastructure as Code with Terraform
- AzureRM provider and reusable variables
- GitHub Actions CI workflow
- Terraform formatting, initialization, validation, and plan
- Security scanning with Checkov
- Manual approval through GitHub Environments before deployment
- Passwordless Azure authentication using GitHub OIDC (no client secret stored in GitHub)

## Architecture

```text
Developer
   |
   | git push / Pull Request
   v
GitHub Actions
   |-- terraform fmt -check
   |-- terraform init
   |-- terraform validate
   |-- Checkov security scan
   |-- terraform plan
   |
   | main branch + approved GitHub Environment
   v
Azure Login (OIDC)
   |
   v
Azure Resource Group
   |
   v
Virtual Network + Subnet
```

## Repository structure

```text
.
├── .github/
│   └── workflows/
│       └── terraform-ci-cd.yml
├── docs/
│   └── architecture.md
├── .gitignore
├── .tflint.hcl
├── checkov.yml
├── main.tf
├── outputs.tf
├── providers.tf
├── terraform.tfvars.example
├── variables.tf
└── versions.tf
```

## Prerequisites

- Terraform >= 1.6
- Azure subscription
- Azure CLI (for local deployment)
- GitHub repository
- Azure App Registration / Service Principal configured for GitHub OIDC

## Run locally

1. Clone this repository.
2. Copy the example variables file:

   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

   On Windows PowerShell:

   ```powershell
   Copy-Item terraform.tfvars.example terraform.tfvars
   ```

3. Sign in to Azure:

   ```bash
   az login
   az account set --subscription "<YOUR_SUBSCRIPTION_ID>"
   ```

4. Initialize and validate:

   ```bash
   terraform init
   terraform fmt -check -recursive
   terraform validate
   terraform plan
   ```

5. To deploy after reviewing the plan:

   ```bash
   terraform apply
   ```

6. Clean up demo resources when finished:

   ```bash
   terraform destroy
   ```

## Configure GitHub Actions with Azure OIDC

Create an Azure App Registration / Service Principal and configure a federated credential for your GitHub repository.

Set these GitHub **Actions repository variables**:

| Variable | Description |
|---|---|
| `AZURE_CLIENT_ID` | Application (client) ID |
| `AZURE_TENANT_ID` | Microsoft Entra tenant ID |
| `AZURE_SUBSCRIPTION_ID` | Azure subscription ID |

The workflow uses `azure/login` with OIDC. Do not add a client secret.

Assign the service principal only the permissions required for this demo. For a learning subscription, a scoped Contributor assignment on the target resource group may be appropriate after the resource group exists; initial resource-group creation may require a suitable scoped role at subscription level. Follow your organization's least-privilege policy.

### GitHub Environment approval

1. In your repository, open **Settings → Environments**.
2. Create an environment named `azure-demo`.
3. Configure required reviewers if your GitHub plan/repository settings support it.
4. The deployment job references this environment and runs only on pushes to `main`.

### Important workflow note

The workflow runs formatting, validation, Checkov, and plan on pull requests. The deployment job is restricted to `main` and the `azure-demo` environment. Review the Terraform plan and approve the environment deployment before it proceeds.

## Security notes

- Never commit `terraform.tfvars`, state files, credentials, or secret values.
- This example uses GitHub OIDC rather than a long-lived Azure client secret.
- Checkov is configured to report security findings; review and fix findings before using this pattern for real workloads.
- This demo provisions billable Azure resources. Destroy them after testing.
- Terraform state is local by default in this demo. For team use, configure a secured remote backend with locking and access controls.

## Suggested GitHub repository description

`DevSecOps demo: Azure infrastructure provisioning with Terraform, GitHub Actions, Checkov security scanning, and Azure OIDC authentication.`

## Suggested GitHub topics

`terraform` `azure` `github-actions` `devsecops` `checkov` `infrastructure-as-code` `cloud-automation` `oidc`

## Portfolio talking points

- Built a Terraform-based Azure network foundation.
- Automated Terraform formatting, validation, security scanning, and planning in GitHub Actions.
- Used GitHub OIDC for passwordless authentication to Azure.
- Added an environment approval gate before deployment.
- Documented cleanup and secret-handling practices.

Only describe deployment as completed after you have actually run it in your own Azure subscription.
