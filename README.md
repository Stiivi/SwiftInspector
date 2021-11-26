#  Inspector

This is an exercise, a simulation of a scenario. This application is a simplification.

Application works with lists of dynamic objects with dynamic properties.
Application allows user to inspect a selection of dynamic objects and edit
properties of the selected objects.

WARNING: This application is BROKEN, It does not work as intended. Serves as a
starter for a discussion.


This is a sample for a [question at Apple Developer Forums](https://developer.apple.com/forums/thread/695395).

# Problem Definition

**MODEL**

- The Model consists of Dynamic Things.
- Dynamic Things have dynamic properties
- Properties are not known to the application developer
  (they can be created externally, by a user)


**ENVIRONMENT**

- The environment contains multiple dynamic collections of Things, we 
  call them Filters
- The exact Filters are not known to the application developer


**TOP LEVEL VIEW**

- User can list Dynamic Things from a Filter
- There might be views of Dynamic Things that are described externally
  (not known to the app developer)
  

**SELECTION AND INSPECTOR**
  
- User can select one or multiple Dynamic Things in the list
- An Inspector displays properties of Things in the selection
- If multiple Things are selected, inspector displays values from 
  properties that have only one distinct value, otherwise displays
  an empty value
- User can use Inspector to change some properteis of selected Things
- User can change properties of one or more Things at once using Inspector


# View Hierarchy

```

 Window
   |
   +-- Content View (*>)
         |
         +-- Navigation View
         |     |
         |     +-- [sidebar] List of Thing Filters
         |     |
         |     +-- ThingListView(<*) – list of things, selectable, multiple
         |
         +-- Inspector(<*) – of selection in the above
 
 
 (*>) Selection – state, source of truth
 (<*) Selection - binding to


          Navigation         Inspector
 |<----------------------->|<--------->|

 +----------+--------------+-----------+
 | Filter 1 |**Thing 1*****| Selected: |
 | Filter 2 |  Thing 2     |  1,3      |
 | ....     |**Thing 3*****|           |
 |          | ...          | Name: ___ |
 +----------+--------------+-----------+
                 ^
                 |
                 +------- this can be 2D canvas, can be anything to present
                          a collection of selectable objects.
 
 
 Note: The ThingListView might as well be some kind of Canvas, or any other view,
       it does not have to be just a list view.
```

# Known Issues

## Issue #1: Binding `set` called on no change

Offending code location: Inspector.swift -> `class Inspector` -> `var body` -> `nameBinding` -> `set`

1. Pick a Filter (Thing collection)
2. Select multiple (more than one) items
3. One of (any):
    * Change selection to one item
    * Switch to another Filter

Result: All previously selected items will be changed.

Expected: No change happens.

What happened: `set` of a binding to a text filed is called on selection change.

# File Description

- InspectorApp.swift - regular SwiftUI app with an environment object. Nothing
  special here.
- DynamicThing.swift - definition of core model objects.
- Environment.swift - definition of the model
- ContentView.swift - definition of an application content view – NavigationView
  with Inspector
- ThingListView.swift - List of Things - target for the NavigationView. Uses
  multiple selection. 
- ThingView - view of a single thing in a list, simulating dynamic content/layout
- Inspector.swift - View of an inspector for Dynamic Things. Simulates editing
  of a dynamic variable of one or multiuple Things


# Authors

- Stefan Urbanek stefan.urbanek@gmail.com


# License

- MIT

