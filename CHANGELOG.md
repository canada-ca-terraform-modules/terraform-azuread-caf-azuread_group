# Changelog

All notable changes to this module will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [1.4.0] - 2026-08-05

### Added

- `providers.tf` pinning `azuread ~> 3.0` and `required_version >= 1.9`.
- `name` optional override for the auto-generated `display_name` (Pattern 12).
- `administrative_unit_ids`, `auto_subscribe_new_members`, `dynamic_membership`, `external_senders_allowed`, `hide_from_address_lists`, `hide_from_outlook_clients`, `members`, `onpremises_group_type`, `provisioning_options`, `theme`, `visibility`, `writeback_enabled` — new optional arguments exposed from the `azuread_group` v3.9.0 schema, all gated with `null` defaults so existing tfvars produce an identical plan.
- `ESLZ/azuread_group.tf` and `ESLZ/azuread_group.tfvars` — module block and example tfvars for L2 callers.
- `tests/azuread_group.tftest.hcl` and `tests/upgrade_compat.tftest.hcl` — mock_provider test coverage.
- `.tflint.hcl`, `.gitignore` (replaced minimal template), `.github/workflows/terraform-ci.yml`, `.github/workflows/release.yml`.

### Changed

- `output.object` marked `sensitive = true` (full resource object exposure).
- Bumped `.github/workflows/documentation.yml` action pins (`actions/checkout` v4.1.7 → v7.0.1, `terraform-docs/gh-actions` v1.2.0 → v1.4.1).

### Fixed

- None — no bugs found in the existing `azuread_group`/`azuread_users` implementation against the v3.9.0 schema.

### Known blockers

- None.
