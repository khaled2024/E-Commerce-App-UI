//
//  Product.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 09/12/2022.
//

import SwiftUI
//Product model ex
struct Product: Identifiable,Hashable{
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subTitle: String
    var description: String = ""
    var price: String
    var productImage: String = ""
    var quantity: Int = 1
}
//Product types
enum ProductType:String , CaseIterable {
    case Wearable = "Wearable"
    case Laptops = "Laptops"
    case Phones = "Phones"
    case Tablets = "Tablets"
}
