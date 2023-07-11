//
//  StockCellView.swift
//  StocksApp
//
//  Created by Eric Young on 7/11/23.
//

import SwiftUI


struct StockCellView: View {
    let processedStock: ProcessedStock
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(processedStock.ticker)
                    .font(.title2)
                Text(processedStock.name)
                    .font(.caption)
            }
            
            Spacer()
            
            Text("$" + String(format: "%.2f", processedStock.currentPrice))
                .font(.title2)
            
            Spacer()
            
            VStack(alignment: .trailing) {

                
                if let quantity = processedStock.quantity {
                    Text("\(quantity)")
                    Text("$\(String(format: "%.2f", processedStock.currentPrice * Double(quantity)))")
                }
            }
        }
        .padding()
    }
}


struct StockCellView_Previews: PreviewProvider {
    static var previews: some View {
        StockCellView(processedStock: ProcessedStock.mock)
    }
}
