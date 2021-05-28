<!-- ⚠️ This README has been generated from the file(s) ".README" ⚠️--><p align="center">
  <img src="https://github.com/Puzzlepart/prosjektportalen365/blob/main/assets/PP365%20Piktogram%20Flat%20DIGITAL.png" alt="Logo" width="119" height="119" />
</p> <p align="center">
  <b>Prosjektportalen for Microsoft 365 Bygg og Anlegg er en tilleggsmodul som installeres over en eksisterende installasjon av Prosjektportalen 365.</b></br>
  <sub><sub>
</p>

<br />


[![version](https://img.shields.io/badge/version-1.0.2-green.svg)](https://semver.org)

<details>
<summary>📖 Innholdsfortegnelse</summary>
<br />

[![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/cut.png)](#table-of-contents)

## ➤ Table of Contents

* [➤ Hva er Prosjektportalen for Office 365 Bygg og Anlegg?](#-hva-er-prosjektportalen-for-office-365-bygg-og-anlegg)
* [➤ Installering](#-installering)
	* [Installer med skriptet Install.ps1](#installer-med-skriptet-installps1)
	* [Eksempel](#eksempel)
	* [Konfigurer manuelt knytning mellom maler og standardinnhold](#konfigurer-manuelt-knytning-mellom-maler-og-standardinnhold)
* [➤ Oppgradering](#-oppgradering)
	* [Eksempel](#eksempel-1)
* [➤ Kontakt](#-kontakt)
* [➤ Maintainers](#-maintainers)
</details>


[![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/cut.png)](#hva-er-prosjektportalen-for-office-365-bygg-og-anlegg)

## ➤ Hva er Prosjektportalen for Office 365 Bygg og Anlegg?

Prosjektportalen for Office 365 Bygg og Anlegg er bygget av <a href="http://www.puzzlepart.com">Puzzlepart AS</a>. Det er en tilleggsmodul som installeres over en eksisterende installasjon av <a href="https://github.com/Puzzlepart/prosjektportalen365">Prosjektportalen for Office 365</a>.


[![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/cut.png)](#installering)

## ➤ Installering

Prosjektportalen 365 må være installert i miljøet du skal installere til. PP Bygg og Anlegg installeres som et tillegg til PP365. Installasjonen er dermed kort forklart

0. Last ned siste release-pakke fra [releases](https://github.com/Puzzlepart/prosjektportalen365-bygganlegg/releases)
1. Installer PP365 til en site, e.g. /sites/Prosjektportalenbyggoganlegg
2. Installer PP365 Bygg og Anlegg til samme site (se under)
3. Konfigurer manuelt knytning mellom maler og standardinnhold (se under)

### Installer med skriptet Install.ps1

For å kjøre PowerShell-skriptet må PnP Powershell brukes. Vi har ikke bundlet en egen versjon av PnP i denne pakken. For å installere kan du gjøre en av følgende

1. Først installere Prosjektportalen 365. Da vil automatisk PnP PowerShell lastes, og samme versjon kan brukes for å installere Bygg og anlegg
2. Installere PnP PowerShell selv. Det er versjonen SharePointPnPPowerShellOnline som er støttet av dette skriptet. Installer med følgende kommando: `Install-Module SharePointPnPPowerShellOnline`

Du kan velge om du vil ha med standardinnhold for Bygg og Anlegg med parameterene `IncludeAnlegg` og `IncludeBygg`.

### Eksempel

```PowerShell
.\Install.ps1 -Url "https://prosjektportalen.sharepoint.com/sites/Prosjektportalenbyggoganlegg" -UseWebLogin -IncludeBygg -IncludeAnlegg
```

### Konfigurer manuelt knytning mellom maler og standardinnhold

Gå til Innstillinger for området, Konfigurasjon av Prosjektportalen, deretter Prosjektmaler. For hver av malene Bygg og Anlegg, rediger elementene og velg standardinnhold: Fasesjekkliste, Planneroppgaver og Standarddokumenter (hhv. for Bygg og Anlegg).


[![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/cut.png)](#oppgradering)

## ➤ Oppgradering

Dersom PP365-instansen oppgraderes, så må også PP365 Bygg og anlegg oppgraderes. Dette gjøres ved å laste ned siste pakke fra [releases](https://github.com/Puzzlepart/prosjektportalen365-bygganlegg/releases). Deretter kjøres PowerShell-skriptet som før, men ta med -Upgrade switchen.

### Eksempel

```PowerShell
.\Install.ps1 -Url "https://prosjektportalen.sharepoint.com/sites/Prosjektportalenbyggoganlegg" -UseWebLogin -Upgrade -IncludeBygg -IncludeAnlegg
```


[![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/cut.png)](#kontakt)

## ➤ Kontakt

Har du spørsmål om Prosjektportalen for Office 365 - Bygg og anlegg, behov for bistand til installasjon av løsningen eller muligheter for videreutvikling og spesialtilpasninger, ta kontakt med <a href="mailto:prosjektportalen@puzzlepart.com">Prosjektportalen @ Puzzlepart</a>.

For tekniske og funksjonelle spørsmål, ta kontakt med <a href="mailto:jan.lindset@puzzlepart.com">Jan Lindset</a>. Vi gjør oppmerksom på at eventuell bistand vil være en fakturerbar tjeneste. 


[![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/cut.png)](#maintainers)

## ➤ Maintainers

Tarjei E. Ormestøyl (tarjeieo@puzzlepart.com)
