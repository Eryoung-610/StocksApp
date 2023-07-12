//
//  StockDetailView.swift
//  StocksApp
//
//  Created by Eric Young on 7/11/23.
//

import SwiftUI

struct StockDetailView: View {
    
    let processedStock : ProcessedStock
    
    var body: some View {
        Text(processedStock.name)
    }
}

struct StockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(processedStock: ProcessedStock.mock)
    }
}
