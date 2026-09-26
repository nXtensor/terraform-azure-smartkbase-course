# Checkpoint: section-03-solution

Known-good SmartKBase **code** at the end of Section 03.

This is the resource group configuration **after** the in-place tag change (`environment = "development"`).

## How to use it

If you finished Section 03 but broke the files, copy these `.tf` files into `smartkbase/`, put your sandbox subscription id in `providers.tf`, then:

```bash
cd smartkbase
terraform init
terraform plan
```

If Azure still has the group, the plan should be a no-op or a small tag update. If you destroyed the group during a pause, apply again.

Submitting this checkpoint as later course work is not a pass. It is recovery, not the capstone.
