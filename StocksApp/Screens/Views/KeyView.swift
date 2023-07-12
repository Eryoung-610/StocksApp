//
//  KeyView.swift
//  StocksApp
//
//  Created by Eric Young on 7/11/23.
//

import SwiftUI

struct KeyView: View {
    var body: some View {
        HStack{
            Text("Stock")
                .opacity(0.6)
            
            Spacer()
            
            Text("Cur. Price")
                .opacity(0.6)
            
            Spacer()
            
            Text("Qty, Mkt Val")
                .opacity(0.6)
        }
        .padding(.horizontal)
        .frame(height:30)
    }
}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        KeyView()
    }
}
