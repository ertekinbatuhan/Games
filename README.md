# <p align="center">Games App</p>

## Features

- Access a full list of all available games.
- View in-depth details for each game, including descriptions, release dates, and more.
- Easily add games to your favorites for quick access.
- Perform searches across the entire game library or within your favorites for seamless navigation.


 ## Screenshots
![Screenshot 2024-09-29 at 09 16 36](https://github.com/user-attachments/assets/f45296c9-3183-4fd9-875b-ce460ecb6ce2)


## Technologies Used

- **Swift**
- **SwiftUI**
- **SwiftData**
- **MVVM**
- **Unit Testing**
- **Lottie**

 
## Tech Stack
- Xcode: Version 16
- Language: Swift 6.0
- Minimum iOS Version: 17.0
- Dependency Manager: SPM

 
## Architecture Used 
The Games App is built using the MVVM (Model-View-ViewModel) architectural pattern. This architecture helps to separate the business logic and data handling from the user interface, making the app more modular, testable, and maintainable.

- **Model**:Represents the data and business logic of the application. It is responsible for data operations, including fetching, storing, and managing application data. The Model communicates with external services or databases, ensuring that the app has the most current and accurate information.
- **View**: The user interface of the app, responsible for displaying data to users and handling user interactions. The View observes the ViewModel for changes in the data and updates the user interface accordingly, ensuring a responsive and dynamic experience.
- **ViewModel**:Acts as an intermediary between the Model and the View. It processes the data received from the Model and prepares it for display in the View. The ViewModel also handles user input, translating it into actions that affect the Model. This separation allows for better testing of business logic without the need for UI components, making it easier to ensure the app behaves as expected.

![Screenshot 2024-08-09 at 12 31 02](https://github.com/user-attachments/assets/f79044cc-7b40-4d2f-abc1-716dd6384964)

## Installation

1. Clone this repository:

```bash
git clone https://github.com/ertekinbatuhan/Games.git
```

2. Open the Project in Xcode:

```bash
cd Games
```

2. Open the project using Xcode:

```bash
open Games.xcodeproj
```
3. Add required dependencies using Swift Package Manager:
 - For Lottie, navigate to File > Add Packages in Xcode and enter:
```bash
https://github.com/airbnb/lottie-ios.git
```
4.	Set your API key in your project. You can place the following line in the appropriate file:
```bash
static let apiKey = ""

```
5. Run the application:
- Select your target device or simulator.
- Click the Run button (or use the shortcut Cmd + R) to build and run the application.


    
