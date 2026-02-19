# Python Flask til Docker Demo

Dette repositoryet demonstrerer hvordan man bygger en enkel Flask "Hello World" applikasjon til et Docker image og pusher det til [ttl.sh](https://ttl.sh/) med GitHub Actions.

## 📋 Oversikt

Prosjektet inneholder:
- En enkel Flask web-applikasjon (`app.py`)
- Dockerfile for å containerisere applikasjonen
- GitHub Actions workflow som automatisk bygger og pusher Docker imaget til ttl.sh

## 🚀 Komme i gang

### Forutsetninger

- Python 3.11+
- Docker
- Git

### Kjøre lokalt med Python

```bash
# Installer avhengigheter
pip install -r requirements.txt

# Kjør applikasjonen
python app.py
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
├── app.py                 # Flask applikasjon
├── requirements.txt       # Python avhengigheter
├── Dockerfile            # Docker konfigurasjon
├── .github/
│   └── workflows/
│       └── docker.yml    # GitHub Actions workflow
└── README.md
```

## 🐳 Docker Image

Dockerfilen bruker:
- `python:3.11-slim` som base image
- Installerer Flask og Werkzeug
- Eksponerer port 5000
- Kjører Flask applikasjonen

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
