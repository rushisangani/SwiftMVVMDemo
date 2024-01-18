# Swift + MVVM + Swift Package

Welcome to the SwiftMVVMDemo repository! This sample app is designed to showcase various programming concepts, including SOLID principles, MVVM architecture, design patterns like singleton, and observer, and the integration of modern Swift features.

## Purpose

The primary goal of this repository is to provide a comprehensive understanding of essential programming principles and demonstrate their implementation within a Swift project. Through this demo, you'll explore:

- **MVVM Architecture**: Understand the Model-View-ViewModel architecture and its implementation in Swift.
- **SOLID Principles**: Learn about writing maintainable and scalable code by applying SOLID principles.
- **Design Patterns**: Explore various design patterns and their utilization in the context of this project.
- **Swift Package**: Understand how you can create SwiftPackage and use it in your project.
- **UIKit and SwiftUI**: See how a single ViewModel can be utilized in both UIKit and SwiftUI frameworks.
- **Swift Concurrency**: Examples showcasing async-await usage for concurrency.
- **Combine Framework**: Understanding and using the Combine framework for reactive programming.
- **Unit Tests**: Learn about writing unit tests to ensure code quality and reliability.

---

## Contents

### MVVM + Routing through Coordinator

| MVVM  |                    Coordinator       |
|-------------|--------------------------------------------------------------------------------------------|
| ![MVVM](https://miro.medium.com/v2/resize:fit:1400/1*SWQ5UQ1XU8wSykwXnWpiNg.png)       | ![Coordinator](https://www.tpisoftware.com/tpu/File/onlineResource/articles/1110/titlePageImg.png)                                                  

| Component   | Class                                                                                      | Unit Test                                                              |
|-------------|--------------------------------------------------------------------------------------------|------------------------------------------------------------------------|
| Model       | [Post](./SwiftMVVMDemo/Models/Post.swift)                                                 | -                                                                        |
| View        | [PostListViewController](./SwiftMVVMDemo/Views/PostList/UIKit/PostListViewController.swift) (UIKit) <br> [PostListView](./SwiftMVVMDemo/Views/PostList/SwiftUI/PostListView.swift) (SwiftUI) | [PostListViewControllerTests](./SwiftMVVMDemoTests/PostTests/PostListViewControllerTests.swift) <br> [PostListViewTests](./SwiftMVVMDemoTests/PostTests/PostListViewTests.swift) |
| ViewModel `Business logic`  | [PostListViewModel](./SwiftMVVMDemo/Views/PostList/PostListViewModel.swift)       | [PostListViewModelTests](./SwiftMVVMDemoTests/PostTests/PostListViewModelTests.swift)                                                       |
| Service `Get data from DB or Network`   | [PostService](./SwiftMVVMDemo/Services/PostService.swift) | [PostServiceTests](./SwiftMVVMDemoTests/PostTests/PostServiceTests.swift)                                                       |
| Coordinator `Routing` | [PostCoordinator](./SwiftMVVMDemo/Views/PostList/UIKit/PostCoordinator.swift) | -                                                                        |

---

### SOLID Principles

| Principle                         | Meaning                                              | <sub>![Checkmark](https://img.shields.io/badge/-&#x2714;-green)</sub> Example                                               |
|-----------------------------------|------------------------------------------------------|-------------------------------------------------------------|
| S - Single Responsibility         | A class should have a single responsibility only.   | [APIRequestHandler](https://github.com/rushisangani/NetworkKit/blob/main/Sources/NetworkKit/APIRequestHandler.swift) class only handling network requests. <br><br> [APIResponseHandler](https://github.com/rushisangani/NetworkKit/blob/main/Sources/NetworkKit/APIResponseHandler.swift) class only for parsing network response.           |
| O - Open/Closed                   | The classes and functions should be open for extension and closed for internal modification. | Leveraging `generics` within the [NetworkHandler](https://github.com/rushisangani/NetworkKit/blob/main/Sources/NetworkKit/NetworkManager.swift) fetch functionality empowers us to execute a wide range of requests, not limited to posts alone. |
| L - Liskov Substitution           | The code should be maintainable and reusable; objects should be replaced with instances of their subclasses without altering the behavior.  LSP is closely related to `Polymorphism`  | Typecasting of [PostCoordinator](./SwiftMVVMDemo/Views/PostList/UIKit/PostCoordinator.swift) to [Coordinator](./SwiftMVVMDemo/Coordinator/AppCoordinator.swift) protocol or calling method of `viewDidLoad` on **UINavigationController** will call `UIViewController.viewDidLoad` |
| I - Interface Segregation         | A class should not be forced to implement interfaces that they do not use. | Breaking interfaces into smaller and more specific ones. |
| D - Dependency Inversion          | High-level modules should not depend on low-level modules; rather, both should depend on abstractions. | Using protocols in [NetworkManager](https://github.com/rushisangani/NetworkKit/blob/main/Sources/NetworkKit/NetworkManager.swift) and [PostService](./SwiftMVVMDemo/Services/PhotoService.swift) allow us to remove direct dependencies and improve testability and mocking of individual components. |


---

### Design Patterns

| Pattern    | Meaning    | <sub>![Checkmark](https://img.shields.io/badge/-&#x2714;-green)</sub> Example | Tests |
|------------|------------|--------------------|-------|
| Singleton  | The singleton pattern guarantees that only one instance of a class is instantiated. | [CacheManager](./SwiftMVVMDemo/Helpers/Image%20Downloading/CacheManager.swift) | [CacheManagerTests](./SwiftMVVMDemoTests/ImageDownloadingTests/CacheManagerTests.swift) |
| Observer   | The Observer pattern involves a subject maintaining a list of observers and automatically notifying them of any state changes, commonly used for implementing publish/subscribe systems. | [PhotoRowViewModel](./SwiftMVVMDemo/Views/Photos/PhotoRowViewModel.swift) uses `Combine` | [PhotoRowViewModelTests](./SwiftMVVMDemoTests/PhotosTests/PhotoRowViewModelTests.swift) |


---

### Other

| Feature                      | Description                                                                         | <sub>![Checkmark](https://img.shields.io/badge/-&#x2714;-green)</sub> Example                                                 |
|------------------------------|-------------------------------------------------------------------------------------|---------------------------------------------------------|
| UIKit + SwiftUI              | Provides examples showcasing the use of a single **ViewModel** in both UIKit and SwiftUI. | [PhotosViewModel](./SwiftMVVMDemo/Views/Photos/PhotosViewModel.swift) <br> [PhotosViewController](./SwiftMVVMDemo/Views/Photos/UIKit/PhotosViewController.swift) <br> [PhotosCustomAsyncImageView](./SwiftMVVMDemo/Views/Photos/SwiftUI/PhotosCustomAsyncImageView.swift)                  |
| Swift Package      | Create and distribute your own Swift Package and use it in your project.  | [NetworkKit](https://github.com/rushisangani/NetworkKit) |
| Async-Await Usage            | Shows how to use async-await for asynchronous operations.                             | [APIRequestHandler](https://github.com/rushisangani/NetworkKit/blob/main/Sources/NetworkKit/APIRequestHandler.swift) <br> [PostListViewModel](./SwiftMVVMDemo/Views/PostList/PostListViewModel.swift)                                |
| Combine Framework | Examples of using Combine for reactive programming.                         | [AsyncImageLoader](./SwiftMVVMDemo/Helpers/Image%20Downloading/AsyncImageLoader.swift)  <br> [PhotoRowViewModel](./SwiftMVVMDemo/Views/Photos/PhotoRowViewModel.swift)                       |
| Unit Tests                   | Comprehensive unit tests ensure code reliability and functionality.                  | [PostListViewControllerTests](./SwiftMVVMDemoTests/PostTests/PostListViewControllerTests.swift) <br> [APIRequestHandlerTests](https://github.com/rushisangani/NetworkKit/blob/main/Tests/NetworkKitTests/APIRequestHandlerTests.swift)  <br>  [PostServiceTests](./SwiftMVVMDemoTests/PostTests/PostServiceTests.swift)                                |


## Getting Started

To get started with this demo project, follow these steps:

1. **Clone the Repository**: Clone this repository to your local machine using `git clone https://github.com/rushisangani/SwiftMVVMDemo.git`.
2. **Explore the Code**: Dive into the codebase to explore the various concepts implemented.
3. **Run the Project**: Run the project in Xcode to see the sample app in action.
4. **Check Unit Tests**: Review the unit tests to understand how different functionalities are tested.

## Contribution

Contributions to enhance or expand this project are welcome! Feel free to submit issues, propose enhancements, or create pull requests to collaborate on improving this sample app further.

## Connect

Connect with me on [LinkedIn](https://www.linkedin.com/in/rushisangani/) or follow me on [Medium](https://medium.com/@rushisangani).
