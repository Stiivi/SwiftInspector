//
//  ThingListView.swift
//  Inspector
//

import SwiftUI

/// View for a list of Dynamic Things. Target view of a top-level navigation
/// view.
///
/// This might as well be a 2D canvas, not just a plain list view.
/// 
struct ThingListView: View {
    @State var things: [DynamicThing]
    @Binding var selection: Set<Int>
    
    var body: some View {
        List(selection: $selection) {
            ForEach($things) { thing in
                ThingView(thing: thing)
            }
        }
    }
}
