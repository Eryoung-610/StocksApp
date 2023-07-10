//
//  ContentView.swift
//  StocksApp
//
//  Created by Eric Young on 7/10/23.
//

/*
 
 1. Create a stocks appthat shows a list of stock symbols and prices for a set of stocks parsed from JSON endpoints.
 - 
 
 */

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
