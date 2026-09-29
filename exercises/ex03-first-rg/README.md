# EX03 — Create and update the SmartKBase resource group

Work in **`smartkbase/`**, not in a new folder.

`smartkbase/` starts without Terraform files. Copy `checkpoints/section-03-start` if you still need pins, then write `main.tf`. Or follow `smartkbase/README.md`.

## Tasks

1. Replace the placeholder subscription id in `smartkbase/providers.tf`.
2. `terraform init`, `fmt`, `validate`, `plan`, `apply` so `rg-smartkbase-learning` exists.
3. Change the `environment` tag from `learning` to `development`.
4. `terraform plan` — you must see an **update**, not replace or create-only.
5. `terraform apply` and confirm the tag in Azure.
6. **Leave the resource group.**

## Success

- You kept a plan snippet that shows an in-place tag update.
- `rg-smartkbase-learning` still exists unless you chose a session pause.

Destroy is taught in `demos/s03-destroy-demo/`. It is not the success test for this exercise.

## Recovery

`checkpoints/section-03-solution` is the finished code (development tag).
