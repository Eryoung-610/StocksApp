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
                    .font(.title3)
                
                Text(processedStock.name)
                    .font(.caption)
                    .lineLimit(nil)
                    .minimumScaleFactor(0.5)
                    .frame(maxWidth: 80, alignment: .leading)
            }

            
            Spacer()
            
            Text("$" + String(format: "%.2f", processedStock.currentPrice))
                .font(.title3)
                .frame(maxWidth:110, alignment: .leading)

            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("\(processedStock.quantity ?? 0)")
                Text("$\(String(format: "%.2f", processedStock.currentPrice * Double(processedStock.quantity ?? 0)))")
            }
            .frame(minWidth: 80)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}




struct StockCellView_Previews: PreviewProvider {
    static var previews: some View {
        StockCellView(processedStock: ProcessedStock.mock)
    }
}
