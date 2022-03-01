# SwiftUI & CoreData with MVVM Architecture

Demo project using SwiftUI and Core Data implemented with MVVM. 

⚠️ *This is still a work in progress, and as such, cannot be recommended for production* ⚠️ 

## Introduction

As SwiftUI grows in maturity, it has started to show itself in more and more production apps. But just like Swift's beginnings, its immaturity starts to show when trying to adapt it to more robust applications. One such situation is when SwiftUI is used in concert with Core Data.

On the surface, SwiftUI seems to play extremely well with Core Data. Things like `@Environment` and `@FetchRequest` make wiring up a Core Data stack quick and easy until an attempt to decouple into MVVM or other popular design patterns, at which point the cracks start to show. 

This demo project is an attempt to create an MVVM architecture while preserving the ease of use of Core Data in SwiftUI. The main points to tackle are:

 - [ ] Creating a true view model for the logic of the view 
 - [ ] CRUD operations at logical points with work on main Managed Object Context
 - [ ] Works with all Core Data relationships (one-to-one, one-to-many, many-to-many)
 - [ ] Maintaining preview functionality
 - [ ] Testable Code

This project also contains a rudimentary, yet fully fleshed out, UI to better expose any flaws that may arise.

## Core Concepts

**Model**
Core Data Entities work as the Model component of MVVM. These have been extended to include some conveniences, like unwrapped variables, but more importantly include:

 - Static function that returns fetch request for the specific entity type
 - Static function that returns an mock of the Entity

Allowing the model generate the fetch is a negotiable location as it could be equally (or more) logical to add it to the View Model layer. The mock factory is a priority here as it generates usable entities for Previews and Unit Tests. 

**View Model**

The View Model can be used for multiple views. In the case of the demo, View Models conform to usage protocols. This encourages forethought in regard to how a View Model will be used and limits exposure to unnecessary scopes. 

**View**

Probably the most obvious component when working with SwiftUI. There is a State wrapped View Model variable that assigned on initialization of the View. 

Though the architecture of MVVM  has the View as a dumb component, when implementing Core Data. An environment variable of the view context and a fetch request (using `@FetchRequest`) are required to maintain the conveniences and optimizations that the publishers bring to SwiftUI. Abstracting them to the View Model loses some of those optimizations, so in this demo, they are being left in place.

## Implementation


## To Dos

 - [ ] Creating a true view model for the logic of the view 
 - [x] CRUD operations at logical points with work on main Managed Object Context
 - [x] Works with all Core Data relationships (one-to-one, one-to-many, many-to-many)
 - [ ] Maintaining preview functionality
 - [ ] Testable Code
