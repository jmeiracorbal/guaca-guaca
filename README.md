## Guaca-Guaca

[![CI](https://github.com/jmeiracorbal/guaca-guaca/actions/workflows/ci.yml/badge.svg)](https://github.com/jmeiracorbal/guaca-guaca/actions)
[![Docker](https://img.shields.io/badge/docker-ready-blue)](https://www.docker.com/)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![GitHub last commit](https://img.shields.io/github/last-commit/jmeiracorbal/guaca-guaca)](https://github.com/jmeiracorbal/guaca-guaca/commits/master)

Guaca-Guaca is a simplified Docker-based environment for deploying Apache Guacamole with built-in extensibility and clean structure. It is designed for easy resets and custom setups without added complexity.

### Project structure oriented to scaling

Oriented to customization without complexity:

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

Use the `generate-guac-properties.sh` script to generate the guacamole.properties file. The .env file defines database credentials and other environment settings.

### Before compose up, build the init.sql script

You need a init.sql file to complete the installation of guacamole.
The initdb.sql file is a SQL script required by Guacamole for first-time setup.

```bash
export $(grep -v '^#' .env | xargs)
```

```bash
## If you previously exported the environment variables
docker run --rm guacamole/guacamole:$GUACAMOLE_VERSION /opt/guacamole/bin/initdb.sh --mysql > init/initdb.sql
```

### Run compose

```bash
docker compose up -d
```

* Init the database with the required tables.
* Loads guacamole.properties from `GUACAMOLE_HOME`.
* All is prepared and running correctly.

### Customization

Add .jar extensions under data/guac_home/extensions/, configure logs, or modify branding by adjusting guacamole.properties and placing assets inside guac_home.

### License

This project is licensed under the MIT License.