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

- `output.object` marked `sensitive = true` (full resource object exposure). **Minor breaking change**: any caller referencing this output in a non-sensitive context (e.g. interpolating it into a plain string, or passing it to another module's non-sensitive input) will now see a plan-time error and must adjust for the sensitive marking.
- Bumped `.github/workflows/documentation.yml` action pins (`actions/checkout` v4.1.7 → v7.0.1, `terraform-docs/gh-actions` v1.2.0 → v1.4.1).
- All GitHub Actions across `terraform-ci.yml`, `release.yml`, and `documentation.yml` pinned to immutable commit SHAs (with the version tag as a trailing comment) instead of mutable version tags — `release.yml` holds `contents: write` permissions, so a retagged/compromised action could otherwise execute with release-creating credentials.
- Fixed a copy-paste error: `security_enabled`'s description was identical to `mail_enabled`'s; now describes its own semantics (security-enabled group / role-assignable when `assignable_to_role = true`).

### Fixed

- None — no bugs found in the existing `azuread_group`/`azuread_users` implementation against the v3.9.0 schema.

### Follow-ups (not blocking, tracked for a future release)

- `owners` variable description claims Service Principal support, but `data.azuread_users` only resolves user UPNs — SP object IDs are silently dropped or error. Consider a separate `owner_object_ids` variable if SP ownership is required.
- `lifecycle.ignore_changes` on `owners` and `administrative_unit_ids` (pre-existing) freezes both after initial creation; operator-configured changes and out-of-band drift are never reconciled. Revisit in a future breaking-change release.
- `dynamic_membership` (and other `type = any` variables) would benefit from an explicit object type (`object({ enabled = bool, rule = string })`) to surface bad shapes at plan time instead of at resource evaluation.
- Missing negative-path test coverage for provider-enforced mutual exclusions (`dynamic_membership` vs `members`; `mail_enabled = true` requiring `types = ["Unified"]`) — would need a `mock_provider` override to simulate the rejection.
- `names.tf`'s `maxLenght` local is a pre-existing typo (should be `maxLength`), out of scope for this upgrade.

### Known blockers

- None.
