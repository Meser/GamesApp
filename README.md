# iOS Technical Test

This application built with **SwiftUI (MVVM)** allows you to download, view, and manage a video game catalog from the public FreeToGame API, using **Realm** for local storage.

##  Note: The branch `swiftDataExample` contains the same project but based on SwiftData 🚨🚨🚨

## 📱 Features

- Initial download from: `https://www.freetogame.com/api/games`
- Search by name or category
- Pull to refresh (Refreshable List)
- Game detail view
- Edit title and description
- Logical deletion
- Local persistence with Realm
- SwiftUI + MVVM + Repository pattern

## 🛠 Requirements

- Xcode 15+
- Swift 5.9+
- iOS 16+

## 📦 Dependency Installation

Use **Swift Package Manager** to add:

### RealmSwift

```
https://github.com/realm/realm-swift
```

### SDWebImageSwiftUI

```
https://github.com/SDWebImage/SDWebImageSwiftUI
```

## 📂 Project Structure

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
├── Utilities/
```

## ▶️ Running the App

1. Open the project in Xcode.
2. Add the dependencies via SPM.
3. Set `StartupView` as the root view in `GamesAppApp.swift`.
4. Run the app on the simulator.

## ✅ Bonus

- Multi-language support  
- Clean MVVM architecture  
- Example unit tests with XCTest

---

Developed as part of an iOS technical test.
