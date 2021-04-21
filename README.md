﻿
# Prosjektportalen for Office 365 Bygg og Anlegg  [![version](https://img.shields.io/badge/version-0.5.0-yellow.svg)](https://semver.org)

=================

Prosjektportalen for Office 365 Bygg og Anlegg er en tilleggsmodul som installeres over en eksisterende installasjon av <a href="https://github.com/Puzzlepart/prosjektportalen365">Prosjektportalen for Office 365</a>.

## Hva er Prosjektportalen for Office 365 Bygg og Anlegg?

Prosjektportalen for Office 365 Bygg og Anlegg er bygget av <a href="http://www.puzzlepart.com">Puzzlepart AS</a>. Det er en tilleggsmodul som installeres over en eksisterende installasjon av <a href="https://github.com/Puzzlepart/prosjektportalen365">Prosjektportalen for Office 365</a>.

## Installering

Prosjektportalen 365 må være installert i miljøet du skal installere til. PP Bygg og Anlegg installeres som et tillegg til PP365. Installasjonen er dermed kort forklart

0. Last ned siste release-pakke fra [releases](https://github.com/Puzzlepart/prosjektportalen365-bygganlegg/releases)
1. Installer PP365 til en site, e.g. /sites/Prosjektportalenbyggoganlegg
2. Installer PP365 Bygg og Anlegg til samme site (se under)
3. Konfigurer manuelt knytning mellom maler og standardinnhold (se under)

### Installer med skriptet Install.ps1

Du kan velge om du vil ha med standardinnhold for Bygg og Anlegg med parameterene IncludeAnlegg og IncludeBygg.

### Eksempel

```PowerShell
.\Install.ps1 -Url "https://prosjektportalen.sharepoint.com/sites/Prosjektportalenbyggoganlegg" -UseWebLogin -IncludeBygg -IncludeAnlegg
```

### Konfigurer manuelt knytning mellom maler og standardinnhold

Gå til Innstillinger for området, Konfigurasjon av Prosjektportalen, deretter Prosjektmaler. For hver av malene Bygg og Anlegg, rediger elementene og velg standardinnhold: Fasesjekkliste, Planneroppgaver og Standarddokumenter (hhv. for Bygg og Anlegg).

## Oppgradering

Dersom PP365-instansen oppgraderes, så må også PP365 Bygg og anlegg oppgraderes. Dette gjøres ved å laste ned siste pakke fra [releases](https://github.com/Puzzlepart/prosjektportalen365-bygganlegg/releases). Deretter kjøres PowerShell-skriptet som før, men ta med -Upgrade switchen.

### Eksempel

```PowerShell
.\Install.ps1 -Url "https://prosjektportalen.sharepoint.com/sites/Prosjektportalenbyggoganlegg" -UseWebLogin -Upgrade -IncludeBygg -IncludeAnlegg
```

## Kontakt

Har du spørsmål om Prosjektportalen for Office 365 - Bygg og anlegg, behov for bistand til installasjon av løsningen eller muligheter for videreutvikling og spesialtilpasninger, ta kontakt med <a href="mailto:prosjektportalen@puzzlepart.com">Prosjektportalen @ Puzzlepart</a>.

For tekniske og funksjonelle spørsmål, ta kontakt med <a href="mailto:jan.lindset@puzzlepart.com">Jan Lindset</a>. Vi gjør oppmerksom på at eventuell bistand vil være en fakturerbar tjeneste. 

## Maintainers

Tarjei E. Ormestøyl (tarjeieo@puzzlepart.com)
