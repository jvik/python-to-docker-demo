# Øvelse 1 - Klone, endre og kjøre lokalt

## :bulb: Mål

Lær å klone et repository, gjøre endringer i en Flask applikasjon, bygge et Docker image og kjøre det lokalt.

## Forutsetninger

- Git installert
- Docker installert
- En terminal/kommandolinje
- En kode-editor (f.eks. VS Code)

## 1.1 - Clone repositoriet

:pencil2: Åpne terminalen og naviger til en mappe hvor du vil lagre prosjektet.

:pencil2: Clone repositoriet:

```bash
git clone https://github.com/jvik/python-to-docker-demo.git
cd python-to-docker-demo
```

:bulb: Hvis du ønsker å bruke SSH i stedet for HTTPS:

```bash
git clone git@github.com:jvik/python-to-docker-demo.git
```

:pencil2: Åpne prosjektet i din kode-editor:

```bash
code .
```

## 1.2 - Utforsk prosjektstrukturen

:pencil2: Ta en titt på filstrukturen:

```
.
├── src/
│   └── python_flask_demo/
│       ├── __init__.py   # Hoved Flask applikasjon
│       └── __main__.py   # Entry point
├── pyproject.toml        # Python avhengigheter
├── Dockerfile            # Docker konfigurasjon
└── README.md
```

:pencil2: Åpne filen `src/python_flask_demo/__init__.py` og se på koden.

:bulb: Dette er en enkel Flask webserver med to endpoints:
- `/` - Returnerer en velkomstmelding
- `/health` - Health check endpoint

## 1.3 - Gjør en endring

:pencil2: I filen `src/python_flask_demo/__init__.py`, finn linjen som returnerer teksten:

```python
return 'Hello, World from Flask in Docker!'
```

:pencil2: Endre teksten til noe eget, for eksempel:

```python
return 'Hei! Mitt navn er [ditt navn] og dette er min Docker app!'
```

:pencil2: Lagre filen.

:bulb: Du kan også legge til et nytt endpoint hvis du vil:

```python
@app.route('/mynavn')
def mitt_navn():
    return 'Dette er mitt eget endpoint!'
```

## 1.4 - Bygg Docker imaget

:pencil2: I terminalen, bygg Docker imaget:

```bash
docker build -t flask-demo .
```

:bulb: Dette vil:
1. Laste ned base imaget (`uv:python3.11-bookworm-slim`)
2. Kopiere filene dine inn i containeren
3. Installere Python-avhengigheter med `uv`
4. Klargjøre applikasjonen for kjøring

:bulb: Flagget `-t flask-demo` gir imaget navnet "flask-demo".

:pencil2: Når byggingen er ferdig, sjekk at imaget er opprettet:

```bash
docker images | grep flask-demo
```

## 1.5 - Kjør containeren lokalt

:pencil2: Start containeren:

```bash
docker run -p 5000:5000 flask-demo
```

:bulb: Flagget `-p 5000:5000` mapper port 5000 på din maskin til port 5000 i containeren.

:pencil2: Du skal nå se output som indikerer at Flask serveren kjører:

```
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:5000
 * Running on http://172.17.0.2:5000
```

## 1.6 - Test applikasjonen

:pencil2: Åpne nettleseren og gå til `http://localhost:5000`

:pencil2: Du skal nå se den endrede teksten du skrev tidligere!

:pencil2: Test også health endpoint: `http://localhost:5000/health`

:bulb: Du kan også bruke `curl` i en ny terminal:

```bash
curl http://localhost:5000
curl http://localhost:5000/health
```

## 1.7 - Stopp containeren

:pencil2: Gå tilbake til terminalen hvor containeren kjører og trykk `Ctrl+C` for å stoppe den.

:bulb: Alternativt kan du kjøre containeren i bakgrunnen med `-d` flagget:

```bash
docker run -d -p 5000:5000 flask-demo
```

:pencil2: For å se kjørende containere:

```bash
docker ps
```

:pencil2: For å stoppe en bakgrunns-container:

```bash
docker stop <container-id>
```

## 1.8 - Bonus: Kjør med volume for live-oppdatering

:bulb: Hvis du vil gjøre endringer uten å rebuilde imaget hver gang, kan du mounte kildekoden som et volume (men dette fungerer best uten Docker - bruk heller `uv run python -m python_flask_demo` for lokal utvikling).

---

**Gratulerer! 🎉 Du har fullført Øvelse 1!**

Du har nå:
- Klonet et repository
- Gjort endringer i en Flask applikasjon
- Bygget et Docker image
- Kjørt applikasjonen i en Docker container
- Testet applikasjonen lokalt

[:arrow_right: Gå til neste øvelse](../exercise-2/README.md)
