//
//  StockListView.swift
//  StocksApp
//
//  Created by Eric Young on 7/11/23.
//

import SwiftUI

struct StockListView: View {
    @ObservedObject var viewModel: StockViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.processedStocks) { stock in
                    NavigationLink(destination: StockDetailView(processedStock: stock)) {
                        StockCellView(processedStock: stock)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                    }
                    Divider()
                }
            }
        }
    }
}
