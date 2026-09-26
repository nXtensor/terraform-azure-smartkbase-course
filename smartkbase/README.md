# SmartKBase — Section 03: your first Azure apply

This folder is the start of **SmartKBase**, the same project you will grow for the rest of the course.

Right now SmartKBase is only an Azure resource group. That is intentional. You are learning the Terraform workflow, not a catalogue of Azure services.

After this section you will **leave the resource group in place**. Later sections add storage, a web app, state, a module, environments, and Key Vault to this same project.

Do **not** run `terraform destroy` in this folder unless you are pausing the course and will restore from a checkpoint later. Destroy is taught with a separate disposable example.

---

## 1. What you will build

An Azure resource group named `rg-smartkbase-learning` in `eastus`, tagged as SmartKBase.

Then you will change one tag and apply again so Terraform **updates** the group instead of destroying and recreating it.

---

## 2. What you will learn

- How Terraform configuration becomes a real Azure resource
- The daily command loop: `init` → `fmt` → `validate` → `plan` → `apply`
- How to read a plan (add vs change vs destroy)
- That Terraform manages desired state, not a one-off create script
- How to inspect the result in Azure

You will **not** learn variables, modules, remote state, Key Vault, or virtual networks here. Those come later.

---

## 3. Prerequisites

- Comfort running commands in a terminal (`cd`, run a command, read an error)
- A **sandbox** Azure subscription you are allowed to use for labs (free, student, Visual Studio benefits, or pay-as-you-go)
- Permission to create resource groups (Contributor or Owner on that subscription)

Do **not** use a company production subscription.

---

## 4. Required tools

| Tool | Check |
|---|---|
| Terraform 1.16.x | `terraform version` |
| Azure CLI | `az version` |
| A text editor | VS Code is recommended |

This lab was tested with Terraform **1.16.2** and the AzureRM provider **5.x**. The configuration allows Terraform `>= 1.16.0, < 2.0.0` and AzureRM `~> 5.0` so a later patch should not force a rewrite.

If `terraform version` shows something older than 1.16.0, install a current 1.16.x build from the official HashiCorp download page.

---

## 5. Azure login

```bash
az login
```

A browser window should ask you to sign in. If you are on a machine without a browser, Azure CLI will offer a device-code login.

Confirm who you are:

```bash
az account show
```

You should see your user and a subscription name. If this command fails, you are not logged in yet. Terraform cannot fix that.

---

## 6. Subscription selection

List subscriptions:

```bash
az account list --output table
```

Choose your **sandbox** subscription:

```bash
az account set --subscription "<subscription-id-or-name>"
```

Confirm again:

```bash
az account show --query "{name:name, id:id}" --output table
```

Copy the subscription **id**. Open `providers.tf` and replace the placeholder:

```hcl
subscription_id = "00000000-0000-0000-0000-000000000000"
```

with your id. Do not commit that change to a public repository.

Register the resource provider this lab needs (often already registered):

```bash
az provider register --namespace Microsoft.Resources
```

Terraform is configured with `resource_provider_registrations = "none"`, which matches AzureRM 5.x. That means Terraform will not silently register providers for you.

---

## 7. Terraform commands you will use

| Command | What it does |
|---|---|
| `terraform init` | Downloads the AzureRM provider into this folder |
| `terraform fmt` | Rewrites the files to standard formatting |
| `terraform validate` | Checks the configuration without calling Azure |
| `terraform plan` | Shows what Terraform **would** change |
| `terraform apply` | Makes Azure match the configuration |

`plan` is a preview. `apply` is the change. Read the plan before you apply.

---

## 8. How to deploy (first apply)

From this `smartkbase/` directory:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
```

The first plan should say it will **create** one resource group. You should **not** see destroy lines.

```bash
terraform apply
```

Type `yes` when asked.

Inspect Azure:

```bash
az group show --name rg-smartkbase-learning --output table
az group show --name rg-smartkbase-learning --query tags
```

You should see the tag `environment=learning`.

**Leave this resource group.** It is the start of SmartKBase.

---

## 9. How to make the tag change

In `main.tf`, change only this line:

```hcl
environment = "learning"
```

to:

```hcl
environment = "development"
```

Do not change the resource group **name**. Changing `name` or `location` would force Azure to replace the group. This exercise is an in-place **update**.

---

## 10. How to verify the change

```bash
terraform plan
```

The plan must show an **update** (change) to tags, not a destroy + create, and not “no changes”.

Then:

```bash
terraform apply
```

Verify:

```bash
az group show --name rg-smartkbase-learning --query tags
```

You should now see `environment=development`.

That is the point of Section 03: Terraform compared Azure to your files and updated the tag to match.

---

## 11. How to recover from common errors

| What you see | Likely cause | What to do |
|---|---|---|
| `subscription_id` is required / invalid subscription | Placeholder id not replaced, or wrong subscription | Put your sandbox id in `providers.tf`; run `az account show` |
| `Error building AzureRM Client` / please run `az login` | CLI session expired | `az login`, then `az account set` |
| `403` / AuthorizationFailed | This identity cannot create resource groups | Use a sandbox where you are Contributor or Owner |
| Resource provider errors | `Microsoft.Resources` not registered | `az provider register --namespace Microsoft.Resources` |
| Invalid resource group name | Name has spaces or illegal characters | Keep `rg-smartkbase-learning` |
| `terraform: command not found` | Terraform is not on your PATH | Reinstall; open a new terminal |
| Plan wants to **replace** the group | You changed `name` or `location` | Change them back; only edit the `environment` tag |
| You broke `main.tf` and cannot fix it | Syntax or lost file | Copy `checkpoints/section-03-start` or `section-03-solution` (see below) |

### Checkpoints

If you get stuck, copy a known-good folder over this one (copy the `.tf` files, not a second Azure project):

- `checkpoints/section-03-start` — versions and provider only; you write `main.tf`
- `checkpoints/section-03-solution` — finished Section 03, including the `development` tag

More detail: `docs/checkpoints.md`.

---

## 12. How to clean up

**Normal path:** do nothing. Keep `rg-smartkbase-learning`. Resource groups alone do not have a meaningful Azure charge.

**If you are stopping the course for a while** and want the group gone:

```bash
terraform plan -destroy
terraform destroy
```

Then, when you return, copy `checkpoints/section-03-solution` back into `smartkbase/` and apply again.

**Do not** practise destroy on SmartKBase during Section 03. Use `demos/s03-destroy-demo/` for that lesson.

---

## 13. Expected result

| Check | Expected |
|---|---|
| First plan | Create `azurerm_resource_group.smartkbase` |
| First apply | `rg-smartkbase-learning` exists in `eastus` |
| Tags after first apply | `project=smartkbase`, `environment=learning`, `managed_by=terraform` |
| Second plan | Update in-place (tag change), **not** replace |
| Second apply | `environment=development` |
| SmartKBase after the section | Resource group still exists |

You have started SmartKBase. Next, Section 04 names the Azure objects you already created. You will not build something new yet.
