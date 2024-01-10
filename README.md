# Swift + MVVM

Welcome to the SwiftMVVMDemo repository! This sample app is designed to showcase various programming concepts, including SOLID principles, MVVM architecture, design patterns like singleton, and decorator, and the integration of modern Swift features. 

## Purpose

The primary goal of this repository is to provide a comprehensive understanding of essential programming principles and demonstrate their implementation within a Swift project. Through this demo, you'll explore:

- **SOLID Principles**: Learn about writing maintainable and scalable code by applying SOLID principles.
- **MVVM Architecture**: Understand the Model-View-ViewModel architecture and its implementation in Swift.
- **Design Patterns**: Explore various design patterns and their utilization in the context of this project.
- **UIKit and SwiftUI**: See how a single **ViewModel** can be utilized in both UIKit and SwiftUI environments.
- **Swift Concurrency**: Examples showcasing async-await usage for concurrency.
- **Combine Framework**: Understanding and using the Combine framework for reactive programming.
- **Unit Tests**: Learn about writing unit tests to ensure code quality and reliability.

## Contents

### MVVM
Demonstration of MVVM architecture in Swift along with additional components.

| Component   | Class                                                |
|-------------|----------------------------------------------------------|
| Model       | [Post](https://github.com/rushisangani/SwiftMVVMDemo/blob/main/SwiftMVVMDemo/Models/Post.swift)                                                     |
| View        | [PostListViewController](https://github.com/rushisangani/SwiftMVVMDemo/blob/main/SwiftMVVMDemo/Views/PostList/UIKit/PostListViewController.swift) (UIKit) <br>[PostListView](https://github.com/rushisangani/SwiftMVVMDemo/blob/main/SwiftMVVMDemo/Views/PostList/SwiftUI/PostListView.swift) (SwiftUI) |
| ViewModel   | [PostListViewModel](https://github.com/rushisangani/SwiftMVVMDemo/blob/main/SwiftMVVMDemo/Views/PostList/PostListViewModel.swift) (for business logic)              |
| Service     | [PostService](https://github.com/rushisangani/SwiftMVVMDemo/blob/main/SwiftMVVMDemo/Services/PhotoService.swift) (for connection to database or network)       |
| Coordinator | [PostCoordinator](https://github.com/rushisangani/SwiftMVVMDemo/blob/main/SwiftMVVMDemo/Views/PostList/UIKit/PostCoordinator.swift) (for routing)                             |


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
