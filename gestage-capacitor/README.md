# GestAge v2.0 — Capacitor Android/iOS

**Calculadora de Edad Gestacional**  
Dr. Gabriel Castillo · Medicina Materno Fetal  
App ID: `com.gabrielcastillo.gestage`

---

## Nuevas funciones v2.0

| Función | Descripción |
|---------|-------------|
| 🍼 **Fecha de parto** | Registra la fecha y tipo de parto directamente en el formulario o desde la tarjeta de paciente |
| 👶 **Datos del recién nacido** | Peso, talla, Apgar 1'/5', sexo y notas neonatales |
| 🔒 **Bloqueo de SDG** | La edad gestacional se congela en la fecha del parto; no sigue avanzando |
| 🤰 **Nueva gestación** | Botón en tarjeta de paciente posparto para iniciar un nuevo embarazo con los mismos datos |
| 📤 **Exportar respaldo JSON** | Descarga `gestage_backup_YYYY-MM-DD.json` con todos los datos locales |
| 📥 **Importar respaldo JSON** | Fusiona pacientes desde un archivo JSON previo (sin duplicar por ID) |
| ⚠️ **Detección de duplicados** | Alerta al ingresar un nombre similar a una paciente ya registrada |

---

## Cómo probar la app (modo web)

```bash
# 1. Abrir directamente en el navegador
open src/index.html

# O con servidor local (recomendado para evitar CORS en iOS Safari)
npx serve src -l 3000
# → Abrir http://localhost:3000
```

**Flujo de prueba del parto:**
1. Registra una paciente con FUM o USG
2. En la tarjeta de la paciente, presiona "🍼 Registrar parto"
3. Ingresa fecha de parto y datos del recién nacido
4. Verifica que el badge de SDG cambia a "🍼 PARTO [fecha]"
5. Prueba "🤰 Nueva gestación" en la misma paciente

**Flujo de respaldo:**
1. En pestaña Pacientes → "📤 Exportar respaldo" → descarga JSON
2. "📥 Importar respaldo" → selecciona el JSON → verifica que se fusionan

---

## Estructura del proyecto

```
gestage-capacitor/
├── src/
│   ├── index.html          ← App completa (HTML único autocontenido)
│   ├── manifest.json       ← PWA manifest
│   ├── sw.js               ← Service Worker (cache offline)
│   └── assets/
│       ├── icons/          ← Coloca icon-192.png, icon-512.png
│       ├── fonts/
│       └── images/
├── android/                ← Proyecto Android (Capacitor)
├── resources/              ← Fuentes de iconos para generación
├── capacitor.config.json
├── package.json
└── README.md
```

---

## Comandos para compilar Android

### Prerrequisitos
- Node.js 18+
- Android Studio (con SDK 34 y NDK configurado)
- Java 17

### Instalación inicial

```bash
cd gestage-capacitor

# Instalar dependencias
npm install

# Agregar plataforma Android (solo primera vez)
npx cap add android
```

### Sincronizar y compilar

```bash
# Copiar src/ a la WebView de Android
npx cap sync android

# Abrir en Android Studio
npx cap open android

# En Android Studio: Build → Generate Signed Bundle/APK
```

### Compilar APK debug directamente

```bash
cd android
./gradlew assembleDebug
# APK generado en: android/app/build/outputs/apk/debug/app-debug.apk
```

### Compilar APK release

```bash
cd android
./gradlew assembleRelease
# Requiere keystore configurado en android/app/build.gradle
```

---

## Iconos

1. Coloca `resources/icon.png` (1024×1024 px) y `resources/splash.png` (2732×2732 px)
2. Ejecuta:
```bash
npx @capacitor/assets generate --android
```

---

## Datos clínicos

- **Fórmulas**: Sin cambios respecto a v1. Todos los cálculos ACOG preservados.
- **Storage**: `localStorage` clave `gestage_v4` (compatible con datos anteriores)
- **Migración**: La app migra automáticamente datos de `gestage_patients` (clave v1) si existen

---

## Riesgos pendientes

| Riesgo | Severidad | Mitigación |
|--------|-----------|------------|
| `localStorage` limitado a ~5MB | Media | Monitorear; implementar IndexedDB si crece |
| Importar JSON malformado puede crashear | Baja | Try/catch implementado, muestra error |
| Sin sincronización en la nube | Media | Considerar Capacitor Filesystem + servidor futuro |
| No hay autenticación | Media | App diseñada para uso personal/consultorio |
| Iconos placeholder (sin `.png` reales) | Baja | Agregar antes de publish en Play Store |
| Android Gradle depende de `node_modules/@capacitor` | Alta | Ejecutar `npm install` antes de `cap sync` |

---

*GestAge v2.0 · Dr. Gabriel Castillo MMF · 2026*
