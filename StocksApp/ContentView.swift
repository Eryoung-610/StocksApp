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

//struct ContentView: View {
//
//    @StateObject var viewModel = StockViewModel()
//
//    init() {
//        UINavigationBar.appearance().backgroundColor = UIColor.white
//        UINavigationBar.appearance().shadowImage = UIImage()
//    }
//
//    var body: some View {
//
//        NavigationView {
//
//
//                ScrollView {
//                    VStack {
//                        ChartView(viewModel: viewModel)
//                            .padding(.bottom,20)
//
//
//                        KeyView()
//                            .padding(.vertical,-10)
//                        Divider()
//
//                        StockListView(viewModel: viewModel)
//                            .navigationTitle("Portfolio")
//                            .navigationBarItems(
//                                leading: Image(systemName: "person.crop.circle")
//                                    .resizable()
//                                    .frame(width:24,height:24)
//                                    .foregroundColor(.primary),
//                                trailing: Image(systemName: "magnifyingglass")
//                                    .resizable()
//                                    .frame(width:24,height:24)
//                                    .foregroundColor(.primary)
//                            )
//
////                        //                    Bottom NavBar Here
////                        HStack {
////                            VStack {
////                                bottomNavBar(image: Image(systemName: "house")) {}
////                                //                                .frame(width:16, height: 16)
////                                Text("Home")
////                                    .font(.caption)
////                            }
////                            VStack {
////                                bottomNavBar(image: Image(systemName: "dollarsign.arrow.circlepath")) {}
////                                //                                .frame(width:16, height:16)
////                                Text("Transfer")
////                                    .font(.caption)
////                            }
////                            VStack {
////                                bottomNavBar(image: Image(systemName: "arrow.left.arrow.right")) {}
////                                //                                .frame(width:16, height: 16)
////                                Text("Trade")
////                                    .font(.caption)
////                            }
////                            VStack {
////                                bottomNavBar(image: Image(systemName:"brain.head.profile")) {}
////                                //                                .frame(width: 16, height: 16)
////                                Text("Learn")
////                                    .font(.caption)
////                            }
////                        }
////                        .padding()
////                        .background(.ultraThinMaterial)
////                        .clipShape(Capsule())
////                        .padding(.horizontal)
////                        //                    .shadow(color : .black.opacity(0.15), radius: 8, x : 2, y: 6)
////                        .frame(maxHeight: .infinity, alignment: .bottom)
////
//                }
//            }
//        }
//        .onAppear {
//            viewModel.fetchStocks()
//        }
//        .overlay(
//                    VStack {
//                        Spacer()
//                        HStack {
//                            Spacer()
//                            // Bottom NavBar Here
//                            HStack {
//                                VStack {
//                                    bottomNavBar(image: Image(systemName: "house")) {}
//                                    Text("Home")
//                                        .font(.caption)
//                                }
//                                VStack {
//                                    bottomNavBar(image: Image(systemName: "dollarsign.arrow.circlepath")) {}
//                                    Text("Transfer")
//                                        .font(.caption)
//                                }
//                                VStack {
//                                    bottomNavBar(image: Image(systemName: "arrow.left.arrow.right")) {}
//                                    Text("Trade")
//                                        .font(.caption)
//                                }
//                                VStack {
//                                    bottomNavBar(image: Image(systemName: "brain.head.profile")) {}
//                                    Text("Learn")
//                                        .font(.caption)
//                                }
//                            }
//                            .padding()
//                            .background(.ultraThinMaterial)
//                            .clipShape(Capsule())
//                            .padding(.horizontal)
//                        }
//                    }
//                    .padding(.bottom, 16) // Add some spacing between the bottom navigation bar and the screen edge
//                    .frame(maxWidth: .infinity)
//                    .background(Color.white.ignoresSafeArea(.all, edges: .bottom)) // Set the background color behind the bottom navigation bar
//                )
//    }
//}

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
                    
                }
                
                // Bottom NavBar Here
                HStack {
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
                }
                .frame(minHeight:60)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchStocks()
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
