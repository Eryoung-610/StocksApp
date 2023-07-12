//
//  ChartView.swift
//  StocksApp
//
//  Created by Eric Young on 7/11/23.
//

import SwiftUI
import Charts

struct MonthlyPortfolioTotal : Identifiable {
    let id = UUID()
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
    
    var data : [MonthlyPortfolioTotal] = [
        MonthlyPortfolioTotal(month: 1, portfolioTotal: 50000),
        MonthlyPortfolioTotal(month: 2, portfolioTotal: 65000),
        MonthlyPortfolioTotal(month: 3, portfolioTotal: 80000),
        MonthlyPortfolioTotal(month: 4, portfolioTotal: 85000),
        MonthlyPortfolioTotal(month: 5, portfolioTotal: 92500),
        MonthlyPortfolioTotal(month: 6, portfolioTotal: 100000),
        MonthlyPortfolioTotal(month: 7, portfolioTotal: 95000),
        MonthlyPortfolioTotal(month: 8, portfolioTotal: 115000),
        MonthlyPortfolioTotal(month: 9, portfolioTotal: 123000),
        MonthlyPortfolioTotal(month: 10, portfolioTotal: 185000),
        MonthlyPortfolioTotal(month: 11, portfolioTotal: 165000),
        MonthlyPortfolioTotal(month: 12, portfolioTotal: 140000)
    ]
    
    var body: some View {
        VStack{
            
            // Calculate the portfolio total based on stocks data
            Text("Portfolio Total: " + calculatePortfolioTotal().formatPriceToString())
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.semibold)
            
        
            Chart(data) {
                LineMark(
                    x: .value("Month", $0.date),
                    y: .value("Portfolio Total", $0.portfolioTotal)
                )
            }
            .chartPlotStyle { chartContent in
                chartContent
                    .frame(height:200)
                    .foregroundColor(.green)
                
            }
            
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
