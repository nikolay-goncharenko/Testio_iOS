# Testio - iOS Server Management App

<p align="left"> 
<img src="https://img.shields.io/badge/Platform-iOS-black?style=for-the-badge&logo=apple" />
<img src="https://img.shields.io/badge/Language-Swift-orange?style=for-the-badge&logo=swift" />
<img src="https://img.shields.io/badge/Framework-UIKit-blue?style=for-the-badge&logo=swift" />
<img src="https://img.shields.io/badge/UI_Layout-SnapKit-F5C518?style=for-the-badge" />
<img src="https://img.shields.io/badge/Architecture-MVVM--C-red?style=for-the-badge" />
<img src="https://img.shields.io/badge/Database-Realm-003366?style=for-the-badge&logo=realm" />
<img src="https://img.shields.io/badge/Network-Alamofire-F05138?style=for-the-badge&logo=alamofire&logoColor=white" />
<img src="https://img.shields.io/badge/Tests-XCTest-9cf?style=for-the-badge" />
</p>

**Testio** is an iOS mobile application developed as part of a technical task for **Nord Security**. The app provides secure user authorization and server list management with offline access capabilities.

## 📝 Project Overview

The application implements a flow consisting of two main screens: **Login** and **Server List**. The primary focus is on high-fidelity design reproduction, clean code, and modern architectural patterns.

### Key Features:

- **Authorization**: JWT token retrieval via a REST API.
- **Credential Storage**: Secure token storage implemented using **Keychain**. The app automatically skips the login screen on subsequent launches if a token exists.
- **Server List**: Data fetching from a protected endpoint with subsequent caching.
- **Persistent Layer**: Data synchronization with a local database for offline functionality.
- **Session Handling**: Automatic handling of `401 Unauthorized` errors with a fallback to the login screen.

## 🛠 Tech Stack

- **UI Framework**: UIKit (Programmatic UI).
- **Architecture**: **MVVM-C** (Model-View-ViewModel + Coordinator) for separation of navigation and business logic.
- **Networking**: **Alamofire** for REST API communication.
- **Database**: **Realm** for a reactive local persistence layer.
- **Layout**: **SnapKit** for declarative Auto Layout constraints.
- **Resources**: **R.swift** for type-safe access to fonts (SF Pro Text), images, and colors.
- **Security**: **Keychain** for secure authorization token storage.
- **Testing**: Unit tests powered by **XCTest** to verify ViewModel and Network layer logic.

## 🏗 Project Structure

The project is organized into functional layers following Clean Architecture principles:

```text
📁 Testio
 ├── 📁 Base          # Base protocols and classes for Coordinators and Modules
 ├── 📁 Coordinators  # Navigation logic (AppCoordinator, Router)
 ├── 📁 Data          # Repositories and data models (ServerListRepository)
 ├── 📁 Modules       # Feature modules (Sign In, Server List) with VMs and VCs
 ├── 📁 Network       # API Client, Endpoints, and Alamofire configuration
 ├── 📁 Storage       # Persistence layer (Keychain, Realm)
 ├── 📁 UI Components # Reusable UI elements (Buttons, Labels, TextFields)
 ├── 📁 Utils         # Helpers, extensions, and global imports
 └── 📁 Resources     # SF Pro Text fonts, Assets, and Info.plist
```

## 🚀 Installation & Setup

1. **Clone the repository**:

	```bash
	git clone https://github.com/nikolay-goncharenko/Testio_iOS.git
	```
2. **Environment Preparation**:
	- Ensure you have **Xcode 15+** installed.
	- Dependencies (SnapKit, R.swift, Alamofire, Realm) are managed via **Swift Package Manager (SPM)**.
	- Xcode will automatically resolve and download them upon opening `Testio.xcodeproj`.

3. **Build and Run**:
- Select a target simulator (e.g., iPhone 17 Pro).
- Press `Cmd + R` to build and launch.

### Test Credentials:

- **Username**: `tesonet`
- **Password**: `partyanimal`