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


