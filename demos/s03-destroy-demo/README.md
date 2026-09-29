# Demo: disposable destroy

This folder is a **tiny, disposable** resource group used only to show:

```text
terraform apply  →  the group exists
terraform destroy  →  the group is gone
```

It is **not** SmartKBase.

## Warning

Do **not** run `terraform destroy` in `smartkbase/` for this lesson.

SmartKBase is the project you keep. Destroying it here would wipe the resource group you just created and break the evolving-lab contract.

Work only in this `demos/s03-destroy-demo/` directory.

## What it creates

Resource group `rg-tfaz-destroy-demo` in `eastus`. Resource groups themselves do not have a meaningful Azure charge. Destroy it when the demo is finished.

## Commands

Replace the placeholder `subscription_id` in `providers.tf` with your sandbox id first.

```bash
cd demos/s03-destroy-demo
terraform init
terraform plan
terraform apply
az group show --name rg-tfaz-destroy-demo --output table
terraform plan -destroy
terraform destroy
az group show --name rg-tfaz-destroy-demo
```

The last command should report that the group was not found.
