# Contributing

Thanks for your interest in improving Guaca-Guaca.

This project aims to provide a preconfigured Docker image of Apache Guacamole. It's not intended to be extended or customized heavily by the user.

## How to contribute

- If you find a bug or something doesn't work, feel free to open an issue.
- If you want to suggest an improvement (documentation, startup behavior, etc.), you can open a pull request.
- Please keep changes simple and focused.
- This image is designed to work out of the box. Avoid proposing changes that require user-side configuration.

## Development setup

If you want to test changes locally:

```bash
docker compose -f docker-compose.yml up -d --build
```