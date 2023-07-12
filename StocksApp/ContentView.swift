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
            VStack {
                ScrollView {
                    VStack {
                        switch viewModel.state {
                        case .idle, .loading:
                            ProgressView("Loading")
                                .progressViewStyle(CircularProgressViewStyle())
                                .bold()
                                .font(.title)
                                .foregroundColor(.black)
                        case .loaded:
                            if viewModel.processedStocks.isEmpty {
                                EmptyView()
                            } else {
                                ChartView(viewModel: viewModel)
                                    .padding(.bottom, 20)
                                
                                KeyView()
                                    .padding(.vertical, -10)
                                Divider()
                                
                                StockListView(viewModel: viewModel)
                                    .navigationTitle("Portfolio")
                                    .navigationBarItems(
                                        leading: Button(action: {}) {
                                            Image(systemName: "person.crop.circle")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.primary)
                                        },
                                        trailing: Button(action: {}) {
                                            Image(systemName: "magnifyingglass")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.primary)
                                        }
                                    )
                            }
                        case .error:
                            ErrorView()
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .onAppear {
                    viewModel.fetchStocks()
                }
                
                // Bottom NavBar Here
                HStack {
                    Spacer()
                    VStack {
                        bottomNavBar(image: Image(systemName: "house")) {}
                        Text("Home")
                            .font(.caption)
                    }
                    VStack {
                        bottomNavBar(image: Image(systemName: "dollarsign.arrow.circlepath")) {}
                        Text("Transfer")
                            .font(.caption)
                    }
                    VStack {
                        bottomNavBar(image: Image(systemName: "arrow.left.arrow.right")) {}
                        Text("Trade")
                            .font(.caption)
                    }
                    VStack {
                        bottomNavBar(image: Image(systemName: "brain.head.profile")) {}
                        Text("Learn")
                            .font(.caption)
                    }
                    Spacer()
                }
                .padding()
                .frame(height: 60)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
            }
            .frame(maxHeight: .infinity)
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}


struct bottomNavBar: View {
    let image : Image
    let action : () -> Void
    var body : some View {
        Button(action: action, label : {
            image
                .frame(maxWidth: .infinity)
                .foregroundColor(.primary)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
