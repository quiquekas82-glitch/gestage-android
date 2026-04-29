# Recursos de iconos / Icon Resources

Coloca aquí los íconos de la app antes de compilar:

## Íconos requeridos
- `icon.png` — 1024x1024 px (icono principal)
- `splash.png` — 2732x2732 px (pantalla de carga)

Luego ejecuta:
```bash
npx @capacitor/assets generate --android
```

Esto generará automáticamente todos los tamaños en `android/app/src/main/res/mipmap-*/`
