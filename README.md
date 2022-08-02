# RestaurantApp
Single screen app that displays a list of restaurants fetched from remote JSON. Providing the means to select them as favourite.

## Requirements / dependencies
* Xcode
* CocoaPods 1.11.3

## Frameworks / APIs
* UIKit
* CoreData
* URLSession
* JSONDecoder / Codable
* Quick
* Nimble

## Technical Choices

### Architecture
The project was developed following the MVVM-C architectural pattern, just like regular MVVM, its purpose is to decouple UI / presentation logic from business logic. The "C" stands for Coordinator.

We have:
* Views (i.e: RestaurantListViewController): arrange the UI, display the different texts / images, listen to user actions, etc. 
* ViewModel (i.e: RestaurantListViewModel): is the intermediary between View and Model, receives actions from the View, interacts with the "Model" to update it and obtain data to present, transforming it before passing it back to the View through bindings (in this case in the form of closures). 
* Model: Contains the business logic required for the app to behave as it's intended.
* Coordinator: knows the different screens / flows for a particular part of the app, and is in charge of instantiating, configuring and presenting them.

### Storage
For the favourites feature, the storage choice was CoreData. Although it takes more time to setup than UserDefaults or FileManager, it was the best approach for this use case, as it enables the feature to be extended beyond toggling / querying one particular restaurant's favourite status.

The interaction with CoreData was wrapped inside an object called `CoreDataManager` that contains all data related to instantiation, performing updates (insert / deletes / updates) as well as querying.

### HTTP communication
The choice here was URLSession API combined with the Codable API, as It's flexible enough and easy to setup for the purpose of this particular use case.

### Testing
Quick / Nimble were used to unit test the solution, as they provide superior readability / maintainability when compared to XCTest.

## Build & Run
For the purpose of this challenge the only third-party SDKs were Quick & Nimble, for unit testing. This SDKs are managed with CocoaPods. To run the project follow this instructions:
1. Clone repo with:
```bash
$ git clone <repo-url>
```
2. Change to repo directory and run pod install command :
```bash
$ cd RestaurantApp && pod install
```
3. Open RestaurantApp.xcworkspace with Xcode
```bash
$ open -a Xcode RestaurantApp.xcworkspace
```
4. Select RestaurantApp scheme, select iOS device / simulator
5. Click "Start" / Cmd + R

## Tests
The project contains a couple of test classes to showcase Quick / Nimble usage with current implementation. To execute the entire test suite follow same instructions as above, except for last step, type `Cmd + U` instead to run the test bundle.