//
//  ThingView.swift
//  Inspector
//

import SwiftUI

/// A view for dynamic things – the properties are not known. What is displayed
/// can be provided by the user. Since this is out of scope of this exercise
/// we put few properties here "pseud-statically".
///
struct ThingView: View {
    @Binding var thing: DynamicThing
    
    var body: some View {
        VStack {
            // For the sake of this exercise we assume the existence
            // of the two properties: `name` and `number`. However, this
            // view might query some user created model from which
            // rendering information will be fetched.
            //
            // Get the thing name from a dynamic property.
            //
            Text(thing["name"] ?? "(no name)")
                .font(Font.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top, .leading, .trailing])
            
            // Similar here as above.
            Text(thing["number"] ?? "(no number)")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
