//
//  Environment.swift
//  Inspector
//

import Foundation

class AppEnvironment: ObservableObject {
    @Published var allThings: [DynamicThing]
   
    /// Available simulated collections.
    ///
    /// That this property is here presented as a dynamic property is
    /// intentional. We are simulating that the value (content) is provided
    /// from elsewhere.
    ///
    var filters: [DynamicFilter] {
        // Pretend we are getting the content somewhere else.
        return [
            DynamicFilter(id: 1, name: "odd"),
            DynamicFilter(id: 2, name: "even"),
        ]
    }
    
    init() {
        allThings = [
            DynamicThing(1, ["name": "one", "number": "1"]),
            DynamicThing(2, ["name": "two", "number": "2"]),
            DynamicThing(3, ["name": "three", "number": "3"]),
            DynamicThing(4, ["name": "four", "number": "4"]),
            DynamicThing(5, ["name": "five", "number": "5"]),
        ]

    }
    
    /// Simulate different collections. We recognize "odd" and "even" based on
    /// the thing id. This decision is arbitrary, just to have more than one
    /// collection for this example.
    ///
    func things(in filter: DynamicFilter) -> [DynamicThing] {
        if filter.name == "odd" {
            return allThings.filter { $0.id % 2 != 0 }
        }
        else if filter.name == "even" {
            return allThings.filter { $0.id % 2 == 0 }
        }
        else {
            return allThings
        }
    }
    
    /// Get a thing by ID
    func thing(_ id: Int) -> DynamicThing? {
        return allThings.first { $0.id == id }
    }
}

