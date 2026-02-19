# Python Flask til Docker Demo

Dette repositoryet demonstrerer hvordan man bygger en enkel Flask "Hello World" applikasjon til et Docker image og pusher det til [ttl.sh](https://ttl.sh/) med GitHub Actions.

## 📋 Oversikt

Prosjektet inneholder:
- En Flask web-applikasjon med ordentlig pakkestruktur (`src/python_flask_demo/`)
- `pyproject.toml` for moderne Python dependency management
- Dockerfile som bruker `uv` for rask pakkeinstallasjon
- GitHub Actions workflow som automatisk bygger og pusher Docker imaget til ttl.sh

## � Øvelser

Denne workshopen inneholder 2 hands-on øvelser som tar deg gjennom hele prosessen fra kloning til automatisk deployment:

- [Øvelse 1 - Klone, endre og kjøre lokalt](exercise-1/README.md) - Klon repositoriet, gjør endringer i Flask applikasjonen, bygg Docker image og kjør lokalt
- [Øvelse 2 - Fork, CI/CD og ttl.sh](exercise-2/README.md) - Fork repositoriet, bruk GitHub Actions til å automatisk bygge og publisere til ttl.sh

**Symboler brukt i øvelsene:**
- :pencil2: - En oppgave du skal gjøre
- :bulb: - Tilleggsinformasjon
- :exclamation: - Noe viktig

## �🚀 Komme i gang

### Forutsetninger

- Python 3.11+
- Docker
- Git
- [uv](https://github.com/astral-sh/uv) (valgfritt for lokal utvikling)

### Kjøre lokalt med Python

**Med uv (anbefalt - mye raskere):**
```bash
# Installer prosjektet og avhengigheter
uv sync

# Kjør applikasjonen
uv run python -m python_flask_demo

# Eller etter installasjonen:
uv run flask-demo
```

**Med pip:**
```bash
# Installer prosjektet i editable mode
pip install -e .

# Kjør applikasjonen
python -m python_flask_demo

# Eller bruk entry point:
flask-demo
```

Applikasjonen vil være tilgjengelig på `http://localhost:5000`

### Kjøre lokalt med Docker

```bash
# Bygg Docker image
docker build -t flask-demo .

# Kjør containeren
docker run -p 5000:5000 flask-demo
```

Åpne nettleseren og gå til `http://localhost:5000`

## 🔧 Prosjektstruktur

```
.
├── src/
│   └── python_flask_demo/
│       ├── __init__.py   # Hoved Flask applikasjon
│       └── __main__.py   # Entry point for å kjøre som modul
├── exercise-1/           # Øvelse 1: Klone, endre og kjøre lokalt
│   └── README.md
├── exercise-2/           # Øvelse 2: Fork, CI/CD og ttl.sh
│   └── README.md
├── pyproject.toml        # Python avhengigheter og prosjekt metadata
├── Dockerfile            # Docker konfigurasjon (bruker uv)
├── .github/
│   └── workflows/
│       └── docker.yml    # GitHub Actions workflow
└── README.md
```

## 🐳 Docker Image

Dockerfilen bruker:
- `python:3.11-slim` som base image
- `uv` for lynrask pakkeinstallasjon (10-100x raskere enn pip)
- `pyproject.toml` for moderne dependency management
- Eksponerer port 5000
- Kjører Flask applikasjonen

**Hvorfor uv?**
- Ekstremt rask pakkeinstallasjon (skrevet i Rust)
- Bedre dependency resolution
- Mindre diskbruk
- Reduserer byggetid betydelig i Docker

## 🔄 GitHub Actions Workflow

Workflowen kjører automatisk når:
- Kode pushes til `main` branch
- En pull request opprettes mot `main`
- Manuelt via "workflow_dispatch"

### Hva skjer i workflowen?

1. **Checkout**: Henter koden fra repositoryet
2. **Set up Docker Buildx**: Konfigurerer Docker for building
3. **Generate image tag**: Lager et unikt tag med timestamp og commit SHA
4. **Build and Push**: Bygger Docker imaget og pusher det til ttl.sh
5. **Output**: Viser informasjon om hvordan man bruker imaget

### Om ttl.sh

[ttl.sh](https://ttl.sh/) er et anonymt og ephemeral (kortvarig) Docker image registry. Imager slettes automatisk etter en spesifisert tid (standard 1 time).

**Fordeler:**
- Ingen registrering eller autentisering nødvendig
- Perfekt for testing og CI/CD demos
- Gratis å bruke

**Begrensninger:**
- Imager er kun tilgjengelige i kort tid (1 time i denne demoen)
- Ikke egnet for produksjon
- Ingen persistens

## 📝 Endpoints

- `GET /` - Returnerer "Hello, World from Flask in Docker!"
- `GET /health` - Health check endpoint

## 🛠️ Tilpasning

### Endre hvor lenge imaget er tilgjengelig

I `.github/workflows/docker.yml`, endre `1h` til ønsket varighet:
- `1h` = 1 time
- `4h` = 4 timer  
- `24h` = 24 timer

```yaml
TAG="ttl.sh/python-flask-demo-$(date +%s)-${{ github.sha }}:1h"
```

### Endre image navn

Endre `python-flask-demo` til ønsket navn i workflow-filen.

## 📚 Lær mer

- [Flask dokumentasjon](https://flask.palletsprojects.com/)
- [Docker dokumentasjon](https://docs.docker.com/)
- [GitHub Actions dokumentasjon](https://docs.github.com/en/actions)
- [ttl.sh informasjon](https://ttl.sh/)

## 📄 Lisens

Dette er et demo-prosjekt for læring og testing.
