//
//  Inspector.swift
//  Inspector
//

import SwiftUI

/// Inspector for a selection of Dynamic Things. It can inspect multiple items
/// at once. At least, that is the intention.
///
/// This implementation simulates editing of a dynamic variable "name".
///
struct Inspector: View {
    /// Shared selection with the navigation view.
    ///
    @Binding var selection: Set<Int>
    
    /// Environment object that provides more details.
    ///
    @EnvironmentObject var env: AppEnvironment

    /// Inspector State for the a dynamic attribute. This inspector inspects
    /// only name of a DynamicThing.
    ///
    @State var name: String = ""

    var body: some View {
        //
        // Dynamic Property Binding Simulation
        // ===================================
        //
        // Create a binding for the dynamic property. We are creating the binding
        // manually to simulate that there might be some other method of to
        // fetch or change the property value.
        //
        // Another reason for this binding is that we are potentially
        // editing multiple values, depending on the selection. We would like
        // to set values of multiple items.
        //
        //
        let nameBinding = Binding<String>(
            get: {
                // Get all names of selected Things
                let names:[String] = selection.compactMap {
                    let thing = env.thing($0)
                    return thing?["name"]
                }
                
                // If all the names are the same, then use it as a field value
                //
                print("Getting a thing: \(names)")
                if Set(names).count == 1 {
                    return names.first!
                }
                else {
                    // There are multiple distinct values
                    return ""
                }
            },
            set: { text in
                // Get all the DynamicThing objects from the selection
                //
                // FIXME: This is called even on no value change:
                // Reproduce:
                //    1. Pick a collection
                //    2. Select multiple (more than one) items
                //    3a. Change selection in the same view (can be just one item)
                //    or 3b. Change navigation collection
                //    -> The previously selected items will be changed
                //
                let things = selection.compactMap { env.thing($0) }
                for thing in things {
                    print("Setting a thing to: \(text)")
                    thing["name"] = text
                }
            }
        )
        let selectedIds = selection.map {String($0)}.joined(separator: ",")
        VStack {
            Text("Selected: \(selectedIds)")
            Form {
                Section(header: Text("Properties")) {
                    TextField("Name", text: nameBinding)
                        .padding()
                    Spacer()
                }
            }
            Spacer()
        }
        .frame(maxHeight:.infinity)
    }
}
