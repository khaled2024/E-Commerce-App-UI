//
//  SharedDataModel.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 12/12/2022.
//

import SwiftUI

class SharedDataModel: ObservableObject {
  // details product data...
    @Published var detailProduct: Product?
    @Published var showDetailProduct: Bool = false
    @Published var fromSearchPage: Bool = false
    // liked products...
    @Published var likedProducts: [Product] = []
    // basket products...
    @Published var cartProducts: [Product] = []
    // calculating total price...
    func getTotalPrice()-> String{
        var total: Int = 0
            // first replace $ with an empty string to can calculate the Integer string
        cartProducts.forEach { product in
            let price = product.price.replacingOccurrences(of: "$", with: "")as NSString
            let quentity = product.quantity
            let priceTotal = quentity * price.integerValue
            total += priceTotal
        }
        return "$\(total)"
    }
}
