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
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor.white
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    ChartView(viewModel: viewModel)
                        .padding(.bottom,20)
                    
                    
                    KeyView()
                        .padding(.vertical,-10)
                    Divider()
                    
                    StockListView(viewModel: viewModel)
                        .navigationTitle("Portfolio")
                        .navigationBarItems(
                            leading: Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width:24,height:24)
                                .foregroundColor(.primary),
                            trailing: Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width:24,height:24)
                                .foregroundColor(.primary)
                        )
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
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
