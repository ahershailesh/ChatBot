# MerPay Assignment

## Problem Statement

Using one of the two hypothetical scenarios below, please write a simple GitHub Direct Messaging app.
[Complete Document](SKILL_TEST.en.md).

## Solution

#### Screenshots

| User Listing Screen | Chat Screen | No Data | Error  |
|---------------------|-------------|---------|--------|
|![](Screenshots/User-Listing.png) | ![](Screenshots/Chat.png) | ![](Screenshots/Empty-Screen.png) | ![](Screenshots/Error.png) |

#### Features
1. Lists GitHub users fetched from network.
2. Pagination for infininte scrolling.
4. Users are sorted by recent chats.
5. Chatting data is saved across application launches.
6. Image caching is implemented for the user profile picture.

#### Chosen Scenario

B. Design and implement an app as a long term project
You are tech-lead of an iOS team with 5 members, who is planning on developing a new iOS app. It will be a long term project, with both development and maintenance being handled within the team. Before starting development with your team members, you are going to design the app and as the tech lead, implement the main fundamental functionalities.

#### Why I chose it
I find myself capable enough to manage a product starting from scratch and marinating it for long time. I can design and develop an application foundation fairly by considering long term on going process of application development.

## App Architecture
I used VIPER architecture to support main functionalities.

### VIPER
I used VIPER for User Listing and Chat screens. Controllers render ViewModels on the screen. Interactor handles API requests for user listing, while  Presenters manages communication between Controller and Interactor. Router is responsible for the navigation between screens.

### Directory Structure

```
├── MerPayAssignment
│   ├── MerPayAssignment.xcodeproj
│   ├── Chat
│   │   ├── ChatView
│   │   ├── CoreDataModels
│   ├── Generic
│   ├── HeaderView
│   ├── Helper
│   ├── LocalStorage.xcdatamodeld
│   ├── Resources
│   │   ├── Assets.xcassets
│   │   └── LaunchScreen.storyboard
│   └── UserListing
│
└── MerPayAssignmentTests
```

|           Directory               |             Contents            |
|-----------------------------------|---------------------------------|
|`Chat`                             | Chat Screen related files       |
|`Chat/ChatView`                    | Chat View files                 |
|`Chat/CoreDataModels`              | Chat core data files            |
|`Generic`                          | General purpose classes.        |
|`HeaderView`                       | Chat screen header view         |
|`Helper`                           | Base classes                    |
|`LocalStorage.xcdatamodeld`        | Core Data                       |
|`Resources/Assets.xcassets`        | Icons                           |
|`Resources/LaunchScreen.storyboard`| LaunchScreen                    |
|`UserListing`                      | User Listing Views              |
-----------------------------------------------------------------------

## Known Issues
* User profile pictures flicker when scrolled very fast.
* Pagination is not smooth.
