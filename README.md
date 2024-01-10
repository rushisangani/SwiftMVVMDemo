# Swift + MVVM

Welcome to the SwiftMVVMDemo repository! This sample app is designed to showcase various programming concepts, including SOLID principles, MVVM architecture, design patterns like singleton, and decorator, and the integration of modern Swift features. 

## Purpose

The primary goal of this repository is to provide a comprehensive understanding of essential programming principles and demonstrate their implementation within a Swift project. Through this demo, you'll explore:

- **MVVM Architecture**: Understand the Model-View-ViewModel architecture and its implementation in Swift.
- **SOLID Principles**: Learn about writing maintainable and scalable code by applying SOLID principles.
- **Design Patterns**: Explore various design patterns and their utilization in the context of this project.
- **UIKit and SwiftUI**: See how a single **ViewModel** can be utilized in both UIKit and SwiftUI environments.
- **Swift Concurrency**: Examples showcasing async-await usage for concurrency.
- **Combine Framework**: Understanding and using the Combine framework for reactive programming.
- **Unit Tests**: Learn about writing unit tests to ensure code quality and reliability.

## Contents

### Implementation of MVVM

| Component   | Class                                                                                      | Unit Test                                                              |
|-------------|--------------------------------------------------------------------------------------------|------------------------------------------------------------------------|
| Model       | [Post](./SwiftMVVMDemo/Models/Post.swift)                                                 | -                                                                        |
| View        | [PostListViewController (UIKit)](./SwiftMVVMDemo/Views/PostList/UIKit/PostListViewController.swift) <br> [PostListView (SwiftUI)](./SwiftMVVMDemo/Views/PostList/SwiftUI/PostListView.swift) | [PostListViewControllerTests](./SwiftMVVMDemoTests/PostTests/PostListViewControllerTests.swift) <br> [PostListViewTests](./SwiftMVVMDemoTests/PostTests/PostListViewTests.swift) |
| ViewModel   | [PostListViewModel (for business logic)](./SwiftMVVMDemo/Views/PostList/PostListViewModel.swift)       | [PostListViewModelTests](./SwiftMVVMDemoTests/PostTests/PostListViewModelTests.swift)                                                       |
| Service     | [PostService (for connection to database or network)](./SwiftMVVMDemo/Services/PhotoService.swift) | [PostServiceTests](./SwiftMVVMDemoTests/PostTests/PostServiceTests.swift)                                                       |
| Coordinator | [PostCoordinator (for routing)](./SwiftMVVMDemo/Views/PostList/UIKit/PostCoordinator.swift) | -                                                                        |

### Implementation of SOLID Principles

| Principle        | Meaning                                              | Example                                                     |
|------------------|------------------------------------------------------|-------------------------------------------------------------|
| S - Single Responsibility Principle | A class should have single responsibility only.        | A `User` class handling only user authentication.           |
| O - Open/Closed Principle           | The classes, and functions, should be open for extension and closed for internal modification | Using inheritance to add new functionality without altering existing code. |
| L - Liskov Substitution Principle   | The code should be maintainable and reusable, Objects should be replaced with instances of their subclasses without altering the behavior. The subclass should be able to override the methods of the base class without changing the functionality of the base class. | A subclass should be usable in place of its parent class. |
| I - Interface Segregation Principle | A class should not be forced to implement interfaces that they do not use. | Breaking interfaces into smaller and more specific ones. |
| D - Dependency Inversion Principle  | High-level modules should not depend on low-level modules; rather, both should depend on abstractions. | Using interfaces to decouple high-level and low-level modules. |


- **Implementation of MVVM**: Demonstrates the practical application of the MVVM architecture in Swift.
- **Examples of Singleton**: Explains how the Singleton design pattern can be utilized effectively.
- **UIKit and SwiftUI Usage**: Provides examples showcasing the use of a single ViewModel in both UIKit and SwiftUI.
- **Async-Await Usage**: Shows how to use async-await for asynchronous operations.
- **Combine Framework Integration**: Includes examples of using Combine for reactive programming.
- **Unit Tests**: Comprehensive unit tests ensuring code reliability and functionality.

## Getting Started

To get started with this demo project, follow these steps:

1. **Clone the Repository**: Clone this repository to your local machine using `git clone https://github.com/rushisangani/SwiftMVVMDemo.git`.
2. **Explore the Code**: Dive into the codebase to explore the various concepts implemented.
3. **Run the Project**: Run the project in Xcode to see the sample app in action.
4. **Check Unit Tests**: Review the unit tests to understand how different functionalities are tested.

## Contribution

Contributions to enhance or expand this project are welcome! Feel free to submit issues, propose enhancements, or create pull requests to collaborate on improving this sample app further.

## License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, or distribute this code for both personal and commercial purposes. Refer to the License file for more details.
