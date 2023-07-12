//
//  ContentView.swift
//  StocksApp
//
//  Created by Eric Young on 7/10/23.
//

/*
 
 1. Create a stocks app that shows a list of stock symbols and prices for a set of stocks parsed from JSON endpoints.
 - 
 
 */

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = StockViewModel()
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    ChartView(viewModel: viewModel)
                    
                    StockListView(viewModel: viewModel)
                        .navigationTitle("Portfolio")
                        .navigationBarItems(
                            leading: Image(systemName: "person.crop.circle")
                                .imageScale(.large)
                                .foregroundColor(.primary),
                            trailing: Image(systemName: "magnifyingglass")
                                .imageScale(.large)
                                .foregroundColor(.primary)
                        )
                }
            }
        }
        .onAppear {
            viewModel.fetchStocks()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
