# DevLab

**DevLab** is an open-source collection of developer demos, tools, and best practices, bundled into an app. It helps explore mobile and web coding stacks through interactive examples.  

## 📱 Features & Navigation  

DevLab is organized into five main sections:  

### 🏠 Home  
- Featured, recent, or popular demos  
- Random "Demo of the Day"  
- Quick access to new additions  

### 🏗️ Technologies  
- Browse demos by frameworks and tools  
- **Apple Technologies**: Swift, SwiftUI, UIKit, CoreData, Combine, etc.  
- **Third-Party Frameworks**: AudioKit, Realm, RxSwift, etc.  
- **Hybrid & Web**: Flutter, React Native, Angular, Vue.js (via WebView)  
- **Other Languages**: Objective-C, C/C++  

### 🧪 Demos  
- Organized by **use cases** and real-world examples  
- Examples:  
  - **Networking**: API calls, WebSockets  
  - **UI/UX**: Animations, custom components  
  - **Concurrency**: Async/Await, GCD  
  - **Persistence**: CoreData, SwiftData, Realm  
  - **Accessibility**: VoiceOver, Dynamic Type  

### 📚 Practices  
- Focused on **design patterns & architectures**  
- Examples:  
  - **App Architectures**: MVC, MVVM, VIPER  
  - **Code Quality**: Unit Testing, TDD, CI/CD  
  - **Security**: Secure API keys, Biometric auth  
  - **Performance Optimization**  

### ⚙️ Settings  
- Feature flags for OS-specific demos (`@available`)  
- Platform filtering (iOS, macOS, iPadOS, etc.)  
- App preferences

## 📂 Project Structure

The project is organized into different modules to keep the codebase clean and scalable.

* **Demos** - Collection of technology demos
* **Modules** - Core app functionality  
* **Preview Content** - Sample data for SwiftUI previews  
* **UI Components** - Reusable UI components  
* **Resources** - Static assets like JSON, images, etc.  

### 🆕 Adding a New Demo

To add a new demo, follow these steps:

1. **Choose a category**
  * If a folder for the category (e.g., `SwiftUI`) already exists under `Demos/`, add the new demo there.
  * If not, create a new folder (e.g., `Demos/AudioKit/DemoName/`).
2. **Create the demo view**
  * Name your demo view following this pattern:
  ```
  <Category>_<DemoName>_DemoView.swift
  ```
3. **Update `Resources/technologies.json`**
  * Add an entry under the correct technology section:
  ```
  { "title": "Demo Title", "view": "<Category>_<DemoName>_DemoView.swift" }
  ```

## 📜 License  
This project is licensed under the **MIT License**.  

---

🚀 **DevLab** is continuously evolving—new demos and tools will be added over time!  
