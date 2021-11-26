//
//  ContentView.swift
//  Inspector
//
//  Created by Stefan Urbanek on 2021/11/17.
//

import SwiftUI

/*
 
 View hierarchy:
 
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
 
 */


struct ContentView: View {
    @State var filterSelection: Int? = 1
    @State var selection = Set<Int>()
    @EnvironmentObject var env: AppEnvironment
    
    var body: some View {
        HStack {
            NavigationView {
                List(env.filters, selection: $filterSelection) { filter in
                    let things = env.things(in: filter)
                    let dest = ThingListView(things:things, selection: $selection)
                    NavigationLink(filter.name, destination: dest)
                }
            }
            .onChange(of: filterSelection) { _ in
                selection.removeAll()
            }
            
            // Inspector view: we inspect all Things that are selected
            //
            // --> THIS is what we are here for.
            //
            Inspector(selection: $selection)
                .frame(width: 250)
        }

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
