# Changelog

## [v0.2.0] - 2025-05-08

### Changed
- Switched to Docker-managed volume `guacamole_mysql` for MySQL data.
- Kept `data/guac_home` as a bind mount for editable configuration.
- Removed theme complexity for simplicity and long-term maintainability.
- Improved `.gitignore` to exclude generated and runtime files cleanly.
- Removed unnecessary volume declarations.

### Fixed
- Invalid volume paths (`data/mysql`, `data/guac_home`) no longer interpreted as Docker volumes.