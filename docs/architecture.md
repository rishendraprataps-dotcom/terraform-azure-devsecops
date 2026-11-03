# Architecture

## Flow

1. A developer opens a pull request or pushes Terraform changes.
2. GitHub Actions checks formatting, initializes Terraform without a backend, validates configuration, and runs Checkov.
3. A push to `main` can authenticate to Azure using GitHub OIDC and generate a Terraform plan.
4. The deploy job targets the `azure-demo` GitHub Environment. Configure required reviewers in repository settings to enforce an approval gate.
5. After approval, Terraform applies the configuration.

## Azure resources

- Resource group
- Virtual network (`10.20.0.0/16`)
- Application subnet (`10.20.1.0/24`)

## Production hardening ideas

- Use an Azure Storage remote backend with state locking and restricted access.
- Separate plan and apply identities and scope RBAC to the target resource group.
- Add TFLint and policy-as-code checks.
- Publish the plan as a workflow artifact and require reviewers to inspect it.
- Add drift detection and cost estimation.
- Pin third-party actions to reviewed commit SHAs in production.
