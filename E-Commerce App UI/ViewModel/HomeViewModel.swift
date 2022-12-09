//
//  HomeViewModel.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 09/12/2022.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .Wearable
    @Published var products: [Product] = [
        Product( type: .Wearable, title: "Apple watch", subTitle: "Apple", price: "$333", productImage: "appleWatch1"),
        Product( type: .Wearable, title: "Apple watch", subTitle: "Apple", price: "$232", productImage: "appleWatch2"),
        Product( type: .Wearable, title: "Apple watch", subTitle: "Apple", price: "$422", productImage: "appleWatch3"),
        Product( type: .Wearable, title: "Apple watch", subTitle: "Apple", price: "$455", productImage: "appleWatch4"),
        
        Product( type: .Phones, title: "Apple Phone", subTitle: "Apple", price: "$333", productImage: "iPhone 11"),
        Product( type: .Phones, title: "Apple Phone", subTitle: "Apple", price: "$232", productImage: "iPhone 12"),
        Product( type: .Phones, title: "Apple Phone", subTitle: "Apple", price: "$422", productImage: "iPhone 13"),
        Product( type: .Phones, title: "Apple Phone", subTitle: "Apple", price: "$455", productImage: "iPhone 14"),
        
        Product( type: .Laptops, title: "Apple Laptop", subTitle: "Apple", price: "$333", productImage: "Macbook1"),
        Product( type: .Laptops, title: "Apple Laptop", subTitle: "Apple", price: "$232", productImage: "Macbook2"),
        Product( type: .Laptops, title: "Apple Laptop", subTitle: "Apple", price: "$422", productImage: "Macbook3"),
        Product( type: .Laptops, title: "Apple Laptop", subTitle: "Apple", price: "$455", productImage: "Macbook4"),
        
        Product( type: .Tablets, title: "Apple tablet", subTitle: "Apple", price: "$333", productImage: "tablet1"),
        Product( type: .Tablets, title: "Apple tablet", subTitle: "Apple", price: "$232", productImage: "tablet2"),
        Product( type: .Tablets, title: "Apple tablet", subTitle: "Apple", price: "$422", productImage: "tablet3"),
        Product( type: .Tablets, title: "Apple tablet", subTitle: "Apple", price: "$455", productImage: "tablet4")
    ]
    // Filter products
    @Published var filteredProducts: [Product] = []
    //more products
    @Published var showMoreProductsOnType: Bool = false
    init() {
        filterProductByType()
    }
    func filterProductByType(){
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
                .lazy
                .filter { product in
                    return product.type == self.productType
                }
            // limiting result...
                .prefix(4)
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({product in
                    return product
                })
            }
        }
    }
}

