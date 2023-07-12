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
                    StockCellView(processedStock: stock)
                    Divider()
                }
            }
            .padding()
        }
    }
}



//struct StockListView_Previews: PreviewProvider {
//    static var previews: some View {
//        StockListView(viewModel: processedStocks)
//    }
//}
