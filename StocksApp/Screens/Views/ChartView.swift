//
//  ChartView.swift
//  StocksApp
//
//  Created by Eric Young on 7/11/23.
//

import SwiftUI
import Charts

struct MonthlyPortfolioTotal {
    var date: Date
    var portfolioTotal: Double

    init(month: Int, portfolioTotal: Double) {
        let calendar = Calendar.autoupdatingCurrent
        self.date = calendar.date(from: DateComponents(year: 2023, month: month))!
        self.portfolioTotal = portfolioTotal
    }
}


struct ChartView: View {
    @ObservedObject var viewModel: StockViewModel
    
    var body: some View {
        VStack{
            
            // Calculate the portfolio total based on stocks data
            Text("Portfolio Total: " + calculatePortfolioTotal().formatPrice())
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.semibold)
            
        
        }
        .padding(.horizontal)
    }

    
    func calculatePortfolioTotal() -> Double {
        let total = viewModel.processedStocks.reduce(0) { $0 + ($1.currentPrice * Double($1.quantity ?? 0)) }
        return total
    }
}

//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView()
//    }
//}
