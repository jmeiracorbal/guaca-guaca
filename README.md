# Guaca Guaca

![Maintained](https://img.shields.io/badge/maintained-yes-brightgreen.svg)
![Status](https://img.shields.io/badge/status-active-success)
[![Docker](https://img.shields.io/badge/docker-ready-blue)](https://www.docker.com/)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![GitHub last commit](https://img.shields.io/github/last-commit/jmeiracorbal/guaca-guaca)](https://github.com/jmeiracorbal/guaca-guaca/commits/master)

Guaca-Guaca is a light Docker-based installation for deploying Apache Guacamole with built-in extensibility and clean design. It facilitates easy resets and customizations without additional complication.

# Project structure

The structure is oriented to scale and to the customization without complexity:

```text
guaca-guaca/
├── docker-compose.yml
├── .env.example
├── init/
│   └── initdb.sql
└── data/
    └── guac_home/
        ├── extensions/
        ├── lib/
        ├── log/
        └── guacamole.properties
```

Create the guacamole.properties file by running the `generate-guac-properties.sh` script. The.env file configures database credentials and other environment variables.

# Database structure from init file

You need an `init.sql` file to complete setting up guacamole.
The initdb.sql script is a SQL script employed by Guacamole for initial configuration.

```bash
export $(grep -v '^#' .env | xargs)
```

```bash
## If you previously exported the environment variables
docker run --rm guacamole/guacamole:$GUACAMOLE_VERSION /opt/guacamole/bin/initdb.sh --mysql > init/initdb.sql
```

# Run compose

```bash
docker compose up -d
```

* Initialize the database with the required tables.
* Loads guacamole.properties from `GUACAMOLE_HOME`.
* Everything is ready and functioning properly.

# Customization

Add.jar extensions in data/guac_home/extensions, configure logs, or brand by modifying guacamole.properties and placing assets inside guac_home.

# License

The project is covered under the MIT License.
