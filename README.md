# IA interactive - Prueba Técnica iOS

Esta aplicación en **SwiftUI (MVVM)** permite descargar, visualizar y gestionar un catálogo de videojuegos desde la API pública de FreeToGame, usando **Realm** para almacenamiento local.

## 📱 Funcionalidades

- Descarga inicial desde: `https://www.freetogame.com/api/games`
- Búsqueda por nombre o categoría
- Deslizar hacia abajo para actualizar (Refreshable List)
- Vista de detalle del videojuego
- Edición de título y descripción
- Eliminación lógica 
- Persistencia local con Realm
- SwiftUI + MVVM + Repository

## 🛠 Requisitos

- Xcode 15+
- Swift 5.9+
- iOS 16+

## 📦 Instalación de dependencias

Usa **Swift Package Manager** para agregar:

### RealmSwift

```
https://github.com/realm/realm-swift
```

### SDWebImageSwiftUI

```
https://github.com/SDWebImage/SDWebImageSwiftUI
```

## 📂 Estructura del Proyecto

```
GamesApp/
├── GenericViews/
├── Models/
├── Modules/
   ├── Detail/
   ├── List/
   ├── Startup/
├── Repositories/
├── Services/
```

## ▶️ Ejecución

1. Abre el proyecto en Xcode.
2. Agrega las dependencias vía SPM.
3. Establece `StartupView` como la vista raíz en `GamesAppApp.swift`.
4. Ejecuta la app en el simulador.

## ✅ Bonus

- Soporte a multiples lenguajes 
- Arquitectura MVVM limpia
- Ejemplos de tests con XCTest

---

Desarrollado como parte de la prueba técnica de IA interactive
