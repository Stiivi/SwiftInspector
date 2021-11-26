//
//  DynamicThing.swift
//  Inspector
//


/// Core object of the model. It simulates an object with dynamic properties.
///
/// For now it is just a dummy wrapper for a dictionary. No validations, no
/// transformations.
///
class DynamicThing: Identifiable {
    var id: Int
    var properties: [String:String] = [:]

    subscript(key: String) -> String? {
        get { properties[key] }
        set(value) { properties[key] = value }
    }

    /// Create a DynamicThing with and `id` and with given `properties`.
    ///
    init(_ id: Int, _ properties: [String:String] = [:]) {
        self.id = id
        self.properties = properties
    }
}

/// Collection of things - as a concept, not a real collection. Think of it as
/// a filter description.
///
class DynamicFilter: Identifiable {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}


