//
//  StockListView.swift
//  StocksApp
//
//  Created by Eric Young on 7/11/23.
//

import SwiftUI

struct StockListView: View {
    @StateObject var viewModel = StockViewModel()
    
    var body: some View {
        List(viewModel.processedStocks) { stock in
            StockCellView(processedStock: stock)
        }
    }
}


//struct StockListView_Previews: PreviewProvider {
//    static var previews: some View {
//        StockListView(viewModel: processedStocks)
//    }
//}
