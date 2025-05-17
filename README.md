# Proiect de testare mobile (iOS)

Proiectul conține teste automate pentru o aplicație iOS folosind două variante:

- **XCUITest** (iOS, Swift)
- **Appium** (cross-platform, WebDriverIO + TypeScript)

---

## Prerechizite

### ✅ Pentru testele scrise în XCUITest

- macOS
- Xcode (`xcode-select --install`)
- Simulator iOS (ex: iPhone 15, iOS 17.4+)

### ✅ Pentru testele Appium

- [Node.js](https://nodejs.org) (v16+)
- Appium (v2+)
- Xcode + Simulator iOS (pentru rularea în iOS)

---

## 🔧 Instalare Prerechizite 

### 1. Instalează XCode și Simulatoarele iOS
    https://developer.apple.com/documentation/safari-developer-tools/installing-xcode-and-simulators

### 2. Instalează Node.js

    https://nodejs.org/en/download

### 3. Instalează Appium

    https://appium.io/docs/en/2.2/quickstart/install/

### 4. Instalează driverul XCUITest pentru Appium

    appium driver install xcuitest

## Rularea testelor

### XCUITest
1. Deschide proiectul în Xcode.
2. Selectează simulatorul dorit (ex: iPhone 15).    
Apasă Cmd + U sau mergi la Product > Test.  
Sau rulează din terminal:   
```bash 
xcodebuild test \
-scheme YourAppScheme \
-destination 'platform=iOS Simulator,name=iPhone 15,OS=17.4'
```

### Appium

1. Construiește aplicația din XCode - Build    
2. Configurează calea către .app în wdio.conf.ts
```bash
'appium:app': '/Users/<user>/Library/Developer/Xcode/DerivedData/<AppName>/Build/Products/Debug-iphonesimulator/YourApp.app'
```
3. Ruleaza
``` bash
appium
```
4. Ruleaza testele
``` bash
npx wdio run wdio.conf.ts
```

## Framework review

### XCUITest

| Avantaje    | Dezavantaje   |
| -------- | ------- |
| Curbă de învățare ușoară dacă deja dezvolți iOS Swift | Trebuie verificat fiecare element din graph tree să corespundă cu cel din teste (Text, Scroll, Button, etc.)    |
| Pasul de instalare este ușor, inexistent pentru cei ce dezvolta deja cu Swift |   Fiecare fișier testat trebuie verificat să aparțină și targetului de XCUITest   |
| Documentația este disponibilă și generoasă    |   Lansarea unei suite de teste dureaza cate 10 secunde   |
| Standardul pentru iOS    |  Unele schimbări de state sunt rapide și nu sunt mereu detectate (Loading)  |
| |  Unele simulări de gesturi nu sunt oferite "out of the box" de către framework și e nevoie de metode pentru a fi simulate  |
| |  Webview-urile sunt greu de testat spre imposibil  |
| |  Elementele de accesibilitate sunt foarte instabile, mai ales în SwiftUI și sunt greu de detectat |
| |  Limitat la testele pentru platforma iOS |

### Appium

| Avantaje    | Dezavantaje   |
| -------- | ------- |
| Sintaxa testelor este mai ușoară și prezintă unele metode "built-in" |  Prea dificil de instalat (multe pachete, multe dependințe) |
| Disponibil în mai multe limbaje de programare (Python, Java, Javascript) | Greu de atașat la un simulator (necesită cunoștințe și despre proiect) |
|  Poate testa atât iOS cât și Android  |  Timp de execuție inferior testelor native  |
| Mai ușor de detectat identificatorii de accessibilitate mulțumită metodelor generice de detectare  |
