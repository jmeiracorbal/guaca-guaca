# Guaca-Guaca

![Maintained](https://img.shields.io/badge/maintained-yes-brightgreen.svg)
![Status](https://img.shields.io/badge/status-active-success)
[![Docker](https://img.shields.io/badge/docker-ready-blue)](https://www.docker.com/)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![GitHub last commit](https://img.shields.io/github/last-commit/jmeiracorbal/guaca-guaca)](https://github.com/jmeiracorbal/guaca-guaca/commits/main)

Guaca-Guaca is a pre-configured Apache Guacamole setup on Docker. 

This project try to make the initial setup simple so that you can run Guacamole without any setup processes:

- The database is pre-initialized with the official schema (uses MariaDB).
- An administrative user is already configured and created by default.
- No writing of bash scripts or installing dependencies manually.

# How it works

Apache Guacamole is composed of two main components:

- `guacd`: the daemon that handles the remote connection protocols (RDP, VNC, SSH). It acts as the backend for all supported protocols.
- `guacamole`: the frontend and API which provides the user interface.

`guacd` is required for Guacamole to work properly. You make sure it’s running and it's accessible on the web container.

If you need more details, you can check the [official documentation](https://guacamole.apache.org/doc/gug/).

# Getting started

To quickly start using Guaca-Guaca you need to create a `docker-compose.yml` file with the following content:

```yaml
services:

  guacd:
    image: guacamole/guacd:1.5.3
    container_name: guacd
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "pgrep", "guacd"]
      interval: 10s
      timeout: 5s
      retries: 5

  guaca-guaca:
    image: jmeiracorbal/guaca-guaca:latest
    container_name: guacamole
    restart: unless-stopped
    env_file: .env
    environment:
      GUACD_HOSTNAME: guacd
    ports:
      - "8080:8080"
    depends_on:
      guacd:
        condition: service_healthy
```

You always have to indicate the host for `guacd` on guacamole environment:

```yaml
    environment:
      GUACD_HOSTNAME: guacd
```

**Ensure to configure database credentials:**

Before starting, make sure to create a .env file in the same directory as your `docker-compose.yml`, with this content:

```text
MYSQL_DATABASE=guacamole_db
MYSQL_USER=guacuser
MYSQL_PASSWORD=guacpass
```

These values are used to init the database and configure the internal connection between Guacamole and MariaDB. Check if the compose file has the env file indicated:

```yaml
    env_file: .env
```

**Run the compose**:

```bash
docker compose up -d
```

Open http://localhost:8080/guacamole in your browser. Remember that Guacamole is served under the /guacamole/ path.

The default admin user is created automatically:
- Username: `guacadmin`
- Password: `guacadmin`

>It's recommended change the password after first log in.

## Healthcheck

To monitor container readiness and improve resilience, it's recommended to include a health check in your `docker-compose.yml` file.

Since Guacamole depends on both the database and the Tomcat webserver, the required check is a simple HTTP request to the main web interface.

```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost:8080/guacamole/"]
  interval: 15s
  timeout: 5s
  retries: 5
  start_period: 20s
```

- Wait for the Guacamole interface to be available.
- Automatically fail if the container isn't running.

You can add this block to the guacamole service in your compose file:

```yaml
services:
  guaca-guaca:
    image: jmeiracorbal/guaca-guaca:latest
    container_name: guacamole
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/guacamole/"]
      interval: 15s
      timeout: 5s
      retries: 5
      start_period: 20s
```

You can add to to `guacd`:

```yaml
  guacd:
    image: guacamole/guacd:1.5.3
    restart: unless-stopped
    container_name: guacd
    healthcheck:
      test: ["CMD", "pgrep", "guacd"]
      interval: 10s
      timeout: 5s
      retries: 5
```

# Customization

Create a directory `guac_home`, with this structure:

```
└── guaca-guaca/
    └── guac_home/
        ├── extensions/
        ├── lib/
        ├── log/
```

You can add `jar` extensions, configure logs, brand, assets inside. 

You must to bind the volume in a the compose file on guacamole container:

```yaml
    volumes:
      - ./guac_home:/guac-home
```

# Database connector

This image uses an embedded MariaDB instance to initialize and run Guacamole. Bellow, are included some notes about the database drivers and his problems with Guacamole:

| Driver                          | Installed | Notes                                                                 |
|------------------------------------|------------|-----------------------------------------------------------------------|
| `mariadb-server` (database engine) | ✅ YES     | Used as internal database inside the container.                      |
| `mariadb-java-client-*.jar` (JDBC) | ❌ NO      | Not correctly recognized by Guacamole 1.5.3 due to SPI incompatibility. |
| `mysql-connector-java-8.0.x.jar`   | ✅ YES     | Fully compatible with MariaDB and required for Guacamole to work.    

_Note_: To prevent moved links from Maven repositories, the connector is downloaded on build/guac-home/lib.

# Disclaimers 

Improvements are welcome, but this is a personal project designed to assist my own server manager. It's not intended for commercial use, nor is there any business interest associated with it.

Issues might exist and will be handled as time permits, but one should not expect any fixes or changes as certain. 

If you found a bug or have any suggestion, please create an [issue](https://github.com/jmeiracorbal/guaca-guaca/issues) in line with the [code of conduct](./CODE_OF_CONDUCT.md) and [Contributing guide](./CONTRIBUTING.md) of the project.

# License

The project is covered under the MIT License.
