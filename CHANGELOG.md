# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [v0.3.1] - 2025-05-16

### Fixed

- Docker Compose example now includes env_file: .env to avoid database creation errors on user setups.
- Add to compose example that .env must contain required variables (MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD).

### Changed

- README updated to indicate that compose file require environment variables.

---

## [v0.3.0] - 2025-05-16

### Added
- Compatibility information added to `README.md` indicated that JDBC drivers and database are supported.
- MySQL JDBC driver (`mysql-connector-java`) is now included directly in the image to ensure that exists library.

### Changed
- Replaced unsupported MariaDB JDBC driver with MySQL Connector/J (`mysql-connector-java`) for Guacamole 1.5.3 compatibility.
- Removed custom `initdb.sql` and added instead the official schema provided by the Guacamole project.
- Simplified `Dockerfile` and `entrypoint.sh` and configuration files.
- Generate dynamically `guacamole.properties` in `/guac-home`.

### Fixed
- JDBC driver loading errors preventing Guacamole from starting.
- Missing `GUACAMOLE_HOME` environment variable causing that the authentication extension isn't loaded.
- Login failures due to misaligned database schema and authentication configuration.

### Removed
- Some variables from .env file. Only required MYSQL_DATABASE, MYSQL_USER and MYSQL_PASSWORD.

---

## [v0.2.0] - 2025-05-08

### Changed
- Switched to Docker-managed volume `guacamole_mysql` for MySQL data.
- Kept `data/guac_home` as a bind mount for editable configuration.
- Removed theme complexity for simplicity and long-term maintainability.
- Improved `.gitignore` to exclude generated and runtime files cleanly.
- Removed unnecessary volume declarations.

### Fixed
- Invalid volume paths (`data/mysql`, `data/guac_home`) no longer interpreted as Docker volumes.