# `test/live/` - live-test harness

A live, real-Azure-AD-resource harness used to prove that a candidate change
to this module doesn't destroy or replace a resource a real consumer already
has running. It is **not** a substitute for `tests/*.tftest.hcl` (mock-based
unit tests, no provider credentials, no live resources - run these first,
they're fast and free) or `ESLZ/` (a usage example, not exercised by CI).

## No automated per-PR workflow (deliberate)

Unlike other modules in this org that pair `test/live/` with a
`.github/workflows/live-test.yml` run via OIDC against the shared sandbox
identity, **this module intentionally has no such workflow**. The Azure AD
Graph permissions this module needs (`Group.ReadWrite.All` / `User.Read.All`)
are RBAC the shared `id-live-test-sandbox` managed identity does not hold,
and granting Graph API permissions to that identity is a larger decision than
this harness should make unilaterally. `test/live/` here exists **only** for
a maintainer to run by hand, authenticated as themselves.

## What's here

| File | Purpose |
|---|---|
| `main.tf` | Module block with `source = "../../"` (a relative path, not a pinned `?ref` - "baseline" and "candidate" are just two on-disk checkouts of this repo), the `azuread` provider config, and an empty `backend "local" {}` block (path supplied at `init` time - see below). |
| `variables.tf` | `env`, `userDefinedString`, `owners`, and `pr_number` (reserved for parity with other harnesses; unused today since this module has no Azure resource dependency to name-suffix). |
| `config/azuread_group.tfvars` | One representative real-usage fixture: a plain security-enabled group with a single owner, no v1.4.0 optional arguments. |

No `test_dependencies.tf` - `azuread_group` has no Azure resource dependency
(no RG/vnet). It needs only Azure AD Graph permissions via your own
`az login` session, not subscription Contributor.

## Running it manually

Requires your own `az login` session against a tenant where you hold
`Group.ReadWrite.All` / `User.Read.All` (or equivalent Entra ID role) - there
is no OIDC/service-identity path for this harness.

```bash
cd test/live
terraform init
terraform plan  -var-file=config/azuread_group.tfvars
terraform apply -var-file=config/azuread_group.tfvars
```

Confirm only `module.azuread_group` is planned/applied, then tear it down:

```bash
terraform destroy -var-file=config/azuread_group.tfvars
```

No `.tfstate` file is ever committed under `test/live/` - every run is
fully ephemeral.

## Two-checkout comparison (baseline vs. candidate), run by hand

To compare a baseline ref against a candidate branch the same way the
automated workflow would for other modules, without CI:

```bash
# Directory A: candidate branch checkout, directory B: baseline branch checkout.
STATE=/tmp/live-test-azuread_group.tfstate

# 1. Baseline apply, from B.
cd B/test/live
terraform init -backend-config="path=$STATE"
terraform apply -var-file=config/azuread_group.tfvars

# 2. Candidate plan (and, if desired, apply), from A, against the same state file.
cd A/test/live
terraform init -backend-config="path=$STATE"
terraform plan -var-file=config/azuread_group.tfvars

# 3. Tear down from A once done comparing.
terraform destroy -var-file=config/azuread_group.tfvars
```

Keep `config/azuread_group.tfvars` byte-for-byte identical between the two
checkouts so any diff in the plan is attributable to the module code change
alone, not the fixture.
