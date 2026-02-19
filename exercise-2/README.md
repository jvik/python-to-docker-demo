# Øvelse 2 - Fork, CI/CD og ttl.sh

## :bulb: Mål

Lær å forke et repository, gjøre endringer, pushe dem, og bruke GitHub Actions til å automatisk bygge og publisere Docker imaget til ttl.sh.

## Forutsetninger

- GitHub konto
- Git konfigurert med SSH keys eller personal access token
- Fullført Øvelse 1

## 2.1 - Fork repositoriet

:pencil2: Gå til https://github.com/jvik/python-to-docker-demo i nettleseren din.

:pencil2: Klikk på **Fork**-knappen i øvre høyre hjørne av siden.

:bulb: En fork er din egen kopi av repositoriet på GitHub. Du kan gjøre endringer i din fork uten å påvirke det originale repositoriet.

:pencil2: GitHub vil opprette en fork under din konto. Når den er ferdig, vil du se at repositoriet nå ligger under ditt brukernavn: `github.com/dittbrukernavn/python-to-docker-demo`

## 2.2 - Clone din fork lokalt

:exclamation: Hvis du allerede har klonet det originale repositoriet fra Øvelse 1, kan du enten slette den mappen eller klone din fork til en ny mappe.

:pencil2: Clone din fork (erstatt `dittbrukernavn` med ditt GitHub brukernavn):

```bash
git clone git@github.com:dittbrukernavn/python-to-docker-demo.git
cd python-to-docker-demo
```

:pencil2: Verifiser at du er i din fork:

```bash
git remote -v
```

Du skal se `origin` peke til din fork (med ditt brukernavn).

## 2.3 - Opprett en branch og gjør endringer

:pencil2: Opprett en ny branch:

```bash
git switch -c endre-melding
```

:pencil2: Åpne `src/python_flask_demo/__init__.py` og endre velkomstmeldingen igjen til noe nytt:

```python
return 'Hei! Dette bygges automatisk med GitHub Actions!'
```

:pencil2: Commit endringen:

```bash
git add src/python_flask_demo/__init__.py
git commit -m "Endre velkomstmelding for CI/CD test"
```

## 2.4 - Push til din fork

:pencil2: Push branchen din til GitHub:

```bash
git push -u origin endre-melding
```

:bulb: Flagget `-u` (upstream) setter opp tracking mellom din lokale branch og remote branchen.

## 2.5 - Opprett en Pull Request

:pencil2: Gå til repositoriet ditt på GitHub (din fork).

:pencil2: Du vil se en melding med en knapp **"Compare & pull request"**. Klikk på den.

:bulb: Pull Request-en går til din egen fork, ikke til det originale repositoriet.

:pencil2: Fyll ut PR-skjemaet:
- **Tittel**: "Endre velkomstmelding"
- **Beskrivelse**: Beskriv hva du har endret

:pencil2: Klikk **Create pull request**.

## 2.6 - Merge Pull Request-en

:pencil2: På Pull Request-siden, klikk på den grønne **"Merge pull request"**-knappen.

:pencil2: Klikk **"Confirm merge"**.

:bulb: Når du merger til `main` branchen, vil GitHub Actions workflowen automatisk starte!

## 2.7 - Se workflowen kjøre

:pencil2: Gå til **Actions**-fanen i repositoriet ditt på GitHub.

:pencil2: Du skal se en workflow kjøring med navnet "Build and Push Docker Image".

:pencil2: Klikk på workflow-kjøringen for å se detaljene.

:bulb: Workflowen vil:
1. Sjekke ut koden din
2. Sette opp Docker Buildx
3. Generere et unikt image tag med timestamp og commit SHA
4. Bygge Docker imaget
5. Pushe imaget til ttl.sh
6. Vise URLen til det publiserte imaget

:pencil2: Vent til workflowen er ferdig (grønn checkmark).

## 2.8 - Finn Docker image URLen

:pencil2: I workflow-kjøringen, klikk på jobben "build-and-push".

:pencil2: Ekspander steget **"Generate image tag"**.

:pencil2: Du vil se en linje som dette:

```
Image will be pushed to: ttl.sh/python-flask-demo-1234567890-abc123def456:1h
```

:pencil2: Kopier hele URLen (inkludert `ttl.sh/` prefikset).

:bulb: **Om ttl.sh**: Dette er et anonymt Docker registry hvor imager automatisk slettes etter en spesifisert tid (1 time i dette tilfellet). Perfekt for testing og demos!

## 2.9 - Kjør imaget fra ttl.sh

:exclamation: **Viktig**: Imaget er kun tilgjengelig i 1 time fra det ble publisert. Hvis det har gått mer enn 1 time, må du trigge workflowen på nytt.

:pencil2: I terminalen din, kjør imaget direkte fra ttl.sh (erstatt med din URLen):

```bash
docker run -p 5000:5000 ttl.sh/python-flask-demo-1234567890-abc123def456:1h
```

:bulb: Docker vil automatisk laste ned imaget fra ttl.sh hvis det ikke finnes lokalt.

:pencil2: Åpne nettleseren og gå til `http://localhost:5000`

:pencil2: Du skal nå se den oppdaterte meldingen fra din fork!

:pencil2: Stopp containeren med `Ctrl+C`.

## 2.10 - Forstå CI/CD pipeline-en

:bulb: La oss se på hva som skjer i `.github/workflows/docker.yml`:

```yaml
name: Build and Push Docker Image

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  workflow_dispatch:
```

Dette betyr at workflowen kjører når:
- Kode pushes direkte til `main` branch
- En PR opprettes mot `main` (kun bygging, ingen push)
- Manuelt trigget via "workflow_dispatch"

:pencil2: Gå til **Actions**-fanen igjen og klikk på workflow-en **"Build and Push Docker Image"** i listen til venstre.

:pencil2: Klikk på knappen **"Run workflow"** for å trigge workflowen manuelt.

:bulb: Dette er nyttig når du vil bygge et nytt image uten å gjøre kodeendringer.

## 2.11 - Bonus: Endre image TTL

:bulb: TTL (Time To Live) bestemmer hvor lenge imaget er tilgjengelig på ttl.sh.

:pencil2: Åpne `.github/workflows/docker.yml` i din editor.

:pencil2: Finn linjen:

```yaml
TAG="ttl.sh/python-flask-demo-$(date +%s)-${{ github.sha }}:1h"
```

:pencil2: Endre `1h` til `4h` for å gjøre imaget tilgjengelig i 4 timer:

```yaml
TAG="ttl.sh/python-flask-demo-$(date +%s)-${{ github.sha }}:4h"
```

:bulb: Mulige verdier: `1h`, `2h`, `4h`, `24h`, etc.

:pencil2: Commit og push endringen for å se den i effekt ved neste workflow-kjøring.

---

**Gratulerer! 🎉 Du har fullført Øvelse 2!**

Du har nå:
- Forket et repository på GitHub
- Opprettet en branch og gjort endringer
- Opprettet og merget en Pull Request
- Sett GitHub Actions bygge og publisere et Docker image automatisk
- Kjørt et image fra ttl.sh ephemeral registry
- Forstått grunnleggende CI/CD pipeline for Docker

**Du har nå ferdighetene til å:**
- Jobbe med Docker i et praktisk prosjekt
- Bruke GitHub Actions for automatisk bygging
- Deploye til ephemeral registries for testing
- Bidra til prosjekter med fork-basert workflow

## 📚 Neste steg

Hvis du vil lære mer:
- Utforsk [GitHub Actions dokumentasjon](https://docs.github.com/en/actions)
- Les om [Docker best practices](https://docs.docker.com/develop/dev-best-practices/)
- Prøv å publisere til andre registries som Docker Hub eller GitHub Container Registry
- Legg til testing i CI/CD pipeline-en før bygging
