﻿Prosjektportalen for Office 365 Bygg og Anlegg  [![version](https://img.shields.io/badge/version-0.5.0-yellow.svg)](https://semver.org)
=================

Prosjektportalen for Office 365 Bygg og Anlegg er en tilleggsmodul som installeres over en eksisterende installasjon av <a href="https://github.com/Puzzlepart/prosjektportalen365">Prosjektportalen for Office 365</a>.

## Hva er Prosjektportalen for Office 365 Bygg og Anlegg? ##

Prosjektportalen for Office 365 Bygg og Anlegg er bygget av <a href="http://www.puzzlepart.com">Puzzlepart AS</a>. Det er en tilleggsmodul som installeres over en eksisterende installasjon av <a href="https://github.com/Puzzlepart/prosjektportalen365">Prosjektportalen for Office 365</a>.

## Installering ##

### Installer med skriptet Install.ps1

Du kan velge om du vil ha med standardinnhold for Bygg og Anlegg med parameterene IncludeAnlegg og IncludeBygg.

### Eksempel
```
.\Install.ps1 -Url https://prosjektportalen.sharepoint.com/sites/Prosjektportalenbyggoganlegg -UseWebLogin -IncludeBygg -IncludeAnlegg
```


### Konfigurer manuelt

* Gå til Konfigurasjon av Prosjektportalen, deretter Prosjektmaler. For hver av malene Bygg og Anlegg, rediger elementene og velg standardinnhold: Fasesjekkliste, Planneroppgaver og Standarddokumenter (hhv. for Bygg og Anlegg).

## Kontakt ##

Har du spørsmål om Prosjektportalen for Office 365 - Bygg og anlegg, behov for bistand til installasjon av løsningen eller muligheter for videreutvikling og spesialtilpasninger, ta kontakt med <a href="mailto:prosjektportalen@puzzlepart.com">Prosjektportalen @ Puzzlepart</a>. 

For tekniske og funksjonelle spørsmål, ta kontakt med <a href="mailto:jan.lindset@puzzlepart.com">Jan Lindset</a>. Vi gjør oppmerksom på at eventuell bistand vil være en fakturerbar tjeneste. 

## Maintainers ##

Ole Martin Pettersen (olemp@puzzlepart.com)
