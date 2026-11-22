# azure-lab-connectivity

Terraform solutions for the connectivity subscription.

## Layout

Each solution is a directory under `terraform/solutions/` containing a `main.tf`:

    terraform/solutions/<name>/        -> state key <name>.tfstate

CI plans and applies every solution touched by a PR, using the reusable workflows in
`seanpreston2904/azure-lab-workflows`.

## Solution requirements

Each solution declares an empty backend; the workflows supply the settings at init:

    terraform {
      backend "azurerm" {}
    }

## State

Storage account `stspdevtfstate` (rg `rg-tf-state-aue`), container `sub-connectivity`.
The container must exist before the first run.

## Setup checklist

- Federated credentials: `repo:<owner>/azure-lab-connectivity:environment:terraform-plan` and `...:terraform-apply`
- Secrets: `TF_CLIENT_ID`, `TF_TENANT_ID`, `TF_SUBSCRIPTION_ID`
- Environments: `terraform-plan`, `terraform-apply` (reviewers on apply)
- CI identity: Storage Blob Data Contributor on the state account, plus rights on the connectivity subscription
