# Checkpoints (Section 03)

SmartKBase is one project. The `smartkbase/` folder starts without Terraform files. You add those files in the lectures. If you break the files, copy a known-good checkpoint into `smartkbase/` and continue. You do not have to have completed every previous step perfectly.

| Checkpoint | What it contains | When to use it |
|---|---|---|
| `checkpoints/section-03-start` | Version pins and provider only | You are starting Section 03 or need to write `main.tf` again |
| `checkpoints/section-03-solution` | Resource group with `environment = "development"` | You finished the tag update and broke the files later |

## How to restore

1. Copy the `.tf` and `.gitignore` files from the checkpoint into `smartkbase/`.
2. Put your sandbox subscription id in `providers.tf`.
3. `cd smartkbase` and run `terraform init` then `terraform plan`.

Do not apply the checkpoint folder as a second Azure project if `smartkbase/` already manages the same resource group. Two working directories with the same resource and two state files can create duplicates or fight each other.

Later sections will add more start/solution pairs. They are not in this repository yet.
