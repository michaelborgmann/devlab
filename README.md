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

## 🆕 Adding a New Demo (Apple Ecosystem)

To add a new demo, follow these steps:

1️⃣ **Choose a Category**
* If a folder for the category (e.g., `SwiftUI`) already exists under `Demos/`, add the new demo there.
* If not, create a new folder following this pattern:

    ```
    Demos/<Category>/<DemoName>/
    ```
    
    Example: `Demos/AudioKit/MyNewDemo/`

2️⃣ **Create the Demo View**
* Name your demo view using this convention:

    ```
     <Category>_<DemoName>_Demo.swift
    ```
    
    Example: `SwiftUI_Button_Demo.swift`
  
* Implement the demo view conforming to the `DemoProtocol`.
  
3️⃣ **Implement the Required Protocols**
* **Define the Demo Structure**
** Create a struct that conforms to `DemoProtocol`:

    ```
    struct MyNewDemo: DemoProtocol {
      var title = "My New Demo"
      var infoFileName = "MyNewDemo_Info"
      var demos: [any DemoPage.Type] = [MyNewDemoPageView.self]
    }
    ```
    
*    **Create the Demo Page**
** Implement a `DemoPage` for your demo:

    ```
    struct MyNewDemoPageView: DemoPage {
        @Binding var viewModel: DemoViewModel
        let id: UUID
        
        var body: some View {
            VStack {
                Text("Welcome to My New Demo")
            }
            .onAppear {
                viewModel.subtitle = "My New Demo"
            }
        }
    }
    ```
    
4️⃣ Update `Resources/technologies.json`
* Add an entry under the appropriate technology section:

    ```
    { "title": "Demo Title", "view": "<Category>_<DemoName>_Demo.swift" }
    ```
    
    Example:
    
    ```
    { "title": "SwiftUI Button Demo", "view": "SwiftUI_Button_Demo.swift" }
    ```
    
5️⃣ Test Your Demo
* Run the app and verify that your demo appears in the appropriate category.
* Ensure the demo works as expected and follows UI/UX guidelines.

## 🌐 Web Demos

Web demos are maintained in their own repositories and integrated into **DevLab** as submodules.

* **[Angular Demos](https://github.com/hacknthrash/angular-demos)** → [Live Demo](https://hacknthrash.github.io/angular-demos/)
* **[React Demos](https://github.com/hacknthrash/react-demos)** → [Live Demo](https://hacknthrash.github.io/react-demos/)
* **[Vue.js Demos](https://github.com/hacknthrash/vuejs-demos)** → [Live Demo](https://hacknthrash.github.io/vuejs-demos/)

### 📌 Add a New Web Framework

1. **Create a new GitHub repository**\
   Example: `https://github.com/hacknthrash/NEW_FRAMEWORK-demos`
2. **Add it as a submodule in DevLab**
```
$ git submodule add https://github.com/hacknthrash/NEW_FRAMEWORK-demos.git Web/NEW_FRAMEWORK
```
3. **Commit and push the submodule changes**
```
$ git add .gitmodules
$ git add Web/NEW_FRAMEWORK
$ git commit -m "Add submodule for NEW_FRAMEWORK demos"
$ git push
```

### 🔄 Make Changes in a Submodule

When working directly inside a submodule repository:

```
$ git commit -am "Commit message in submodule"
$ git push
```

### 📥 Pull Changes for Submodules

To update all submodules:

```
$ git submodule update --remote --merge
```

To update a specific submodule:

```
$ git submodule update --remote Web/NEW_FRAMEWORK
```

### 🚀 Deploy a Web Framework

🔹 **Angular Deployment (using [`angular-cli-ghpages`](https://www.npmjs.com/package/angular-cli-ghpages))**

```
$ ng add angular-cli-ghpages
$ ng deploy --base-href=/angular-demos/
```

🔹 **React & Vue Deployment (using [`gh-pages`](https://www.npmjs.com/package/gh-pages))**

1. Install `gh-pages`:
```
$ npm install gh-pages --save-dev
```
2. Add these lines to `package.json` under "`scripts`":
```
"scripts": {
  "predeploy": "npm run build",
  "deploy": "gh-pages -d dist"
}
```
3. In `vite.config.js`, set the base path:
```
base: "/NEW_FRAMEWORK-demos/",
```
4. Deploy
```
npm run deploy
```

## 📜 License

This project is licensed under the **MIT License**.

---

🚀 **DevLab** is continuously evolving—new demos and tools will be added over time!

