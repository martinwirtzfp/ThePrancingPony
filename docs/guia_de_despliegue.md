# Guía de Despliegue
# The Prancing Pony

---

## Índice

1. [Requisitos previos](#requisitos-previos)
2. [Preparación del proyecto](#preparación-del-proyecto)
3. [Despliegue en Android](#despliegue-en-android)
4. [Despliegue en iOS](#despliegue-en-ios)
5. [Despliegue en Web](#despliegue-en-web)
6. [Despliegue en Windows](#despliegue-en-windows)
7. [Despliegue en Linux](#despliegue-en-linux)
8. [Despliegue en macOS](#despliegue-en-macos)
9. [Resolución de problemas](#resolución-de-problemas)

---

## Requisitos previos

### Software necesario

- Flutter SDK 3.9.2 o superior
- Dart SDK 3.9.2 o superior
- Git

### Herramientas por plataforma

**Android:**
- Android Studio
- Android SDK (API 21 o superior)
- Java Development Kit (JDK) 11 o superior

**iOS:**
- macOS (requerido)
- Xcode 14.0 o superior
- Cuenta de Apple Developer (para publicación)

**Web:**
- Navegador web moderno
- Servidor web (opcional, para producción)

**Windows:**
- Visual Studio 2022 con componentes de desarrollo de escritorio C++

**Linux:**
- Dependencias de desarrollo: `clang`, `cmake`, `ninja-build`, `pkg-config`, `libgtk-3-dev`

**macOS:**
- Xcode 14.0 o superior
- CocoaPods

---

## Preparación del proyecto

### 1. Clonar el repositorio

```bash
git clone https://github.com/martinwirtzfp/ThePrancingPony.git
cd ThePrancingPony
```

### 2. Instalar dependencias

```bash
flutter pub get
```

### 3. Verificar configuración

```bash
flutter doctor
```

Asegúrate de que no haya errores críticos marcados con [✗].

### 4. Probar en modo debug

```bash
flutter run
```

---

## Despliegue en Android

### Preparación

1. Abre el proyecto en Android Studio o VS Code
2. Conecta un dispositivo Android o inicia un emulador
3. Verifica que el dispositivo esté conectado:

```bash
flutter devices
```

### Compilación de debug (APK)

Para generar un APK de prueba:

```bash
flutter build apk --debug
```

El archivo se generará en: `build/app/outputs/flutter-apk/app-debug.apk`

### Compilación de release (APK)

Para producción, genera un APK firmado:

```bash
flutter build apk --release
```

El archivo se generará en: `build/app/outputs/flutter-apk/app-release.apk`

### Compilación de App Bundle (AAB)

Para subir a Google Play Store:

```bash
flutter build appbundle --release
```

El archivo se generará en: `build/app/outputs/bundle/release/app-release.aab`

### Instalación en dispositivo

```bash
flutter install
```

O manualmente:

```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Configuración de firma (para release)

1. Genera una keystore:

```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

2. Crea el archivo `android/key.properties`:

```properties
storePassword=<password>
keyPassword=<password>
keyAlias=upload
storeFile=<ruta-al-keystore>
```

3. Modifica `android/app/build.gradle` para usar la keystore.

---

## Despliegue en iOS

### Requisitos

- macOS
- Xcode instalado
- Cuenta de Apple Developer

### Preparación

1. Abre el proyecto iOS:

```bash
open ios/Runner.xcworkspace
```

2. En Xcode, configura el Bundle Identifier y el equipo de desarrollo

### Compilación de debug

```bash
flutter build ios --debug
```

### Compilación de release

```bash
flutter build ios --release
```

### Instalación en dispositivo

1. Conecta el iPhone/iPad
2. Selecciona el dispositivo en Xcode
3. Ejecuta:

```bash
flutter run --release
```

### Preparación para App Store

1. En Xcode, selecciona Product > Archive
2. Una vez creado el archivo, súbelo a App Store Connect
3. Completa la información en App Store Connect
4. Envía para revisión

---

## Despliegue en Web

### Compilación de debug

```bash
flutter run -d chrome
```

### Compilación de release

```bash
flutter build web --release
```

Los archivos se generarán en: `build/web/`

### Despliegue en servidor web

#### Servidor local

```bash
cd build/web
python -m http.server 8000
```

Accede en: `http://localhost:8000`

#### GitHub Pages

1. Crea una rama `gh-pages`:

```bash
git checkout -b gh-pages
```

2. Copia el contenido de `build/web` a la raíz
3. Sube los cambios:

```bash
git add .
git commit -m "Deploy to GitHub Pages"
git push origin gh-pages
```

4. Activa GitHub Pages en la configuración del repositorio

---

## Despliegue en Windows

### Compilación de debug

```bash
flutter run -d windows
```

### Compilación de release

```bash
flutter build windows --release
```

Los archivos se generarán en: `build/windows/runner/Release/`

### Distribución

1. Comprime la carpeta `Release` completa
2. Los usuarios deben ejecutar `tarea_4_1_interfaces.exe`

---

## Despliegue en Linux

### Instalación de dependencias

```bash
sudo apt-get update
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
```

### Compilación de debug

```bash
flutter run -d linux
```

### Compilación de release

```bash
flutter build linux --release
```

Los archivos se generarán en: `build/linux/x64/release/bundle/`

### Distribución

1. Comprime la carpeta `bundle` completa
2. Los usuarios deben ejecutar `tarea_4_1_interfaces`

---

## Despliegue en macOS

### Compilación de debug

```bash
flutter run -d macos
```

### Compilación de release

```bash
flutter build macos --release
```

Los archivos se generarán en: `build/macos/Build/Products/Release/`

### Distribución

1. La aplicación estará en formato `.app`
2. Comprime el archivo `.app` para distribuir
3. Los usuarios pueden arrastrar la app a la carpeta Aplicaciones

### Firma de código (para distribución fuera de Mac App Store)

```bash
codesign --deep --force --verify --verbose --sign "Developer ID Application: TU NOMBRE" build/macos/Build/Products/Release/tarea_4_1_interfaces.app
### Error: "Flutter SDK not found"

```bash
export PATH="$PATH:`pwd`/flutter/bin"
```

Añade esta línea a tu `.bashrc` o `.zshrc`.

### Error de dependencias en Android

```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### Error de CocoaPods en iOS

```bash
cd ios
pod deintegrate
pod install
cd ..
```

### Error al compilar en Web

Verifica que estés usando una versión compatible:

```bash
flutter channel stable
flutter upgrade
```

### Problemas de rendimiento en release

Asegúrate de compilar en modo release, no debug:
la versión estable:

```bash
flutter channel stable
flutter upgrade
```

### Problemas al compilar

Limpia el proyecto y vuelve a intentar:

```bash
flutter clean
flutter pub get
```

### Actualizar dependencias

```bash
flutter pub upgrade
```

### Analizar el proyecto

```bash
flutter analyze
```

### Ejecutar tests

```bash
flutter test
```

### Ver dispositivos disponibles

```bash
flutter devices
```

### Cambiar de canal de Flutter

```bash
flutter channel stable
flutter channel beta
flutter channel dev
```
