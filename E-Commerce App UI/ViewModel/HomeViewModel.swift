//
//  HomeViewModel.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 09/12/2022.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .Wearable
    // products
    @Published var products: [Product] = [
        Product( type: .Wearable, title: "Apple watch", subTitle: "watch", price: "$333", productImage: "appleWatch1"),
        Product( type: .Wearable, title: "Apple watch", subTitle: "watch", price: "$232", productImage: "appleWatch2"),
        Product( type: .Wearable, title: "Apple watch", subTitle: "watch", price: "$422", productImage: "appleWatch3"),
        Product( type: .Wearable, title: "Apple watch", subTitle: "watch", price: "$455", productImage: "appleWatch4"),
        
        Product( type: .Phones, title: "Apple Phone", subTitle: "Phone", price: "$313", productImage: "iPhone 11"),
        Product( type: .Phones, title: "Apple Phone", subTitle: "Phone", price: "$332", productImage: "iPhone 12"),
        Product( type: .Phones, title: "Apple Phone", subTitle: "Phone", price: "$342", productImage: "iPhone 13"),
        Product( type: .Phones, title: "Apple Phone", subTitle: "Phone", price: "$495", productImage: "iPhone 14"),
        
        Product( type: .Laptops, title: "Apple Laptop", subTitle: "Laptop", price: "$332", productImage: "Macbook1"),
        Product( type: .Laptops, title: "Apple Laptop", subTitle: "Laptop", price: "$231", productImage: "Macbook2"),
        Product( type: .Laptops, title: "Apple Laptop", subTitle: "Laptop", price: "$129", productImage: "Macbook3"),
        Product( type: .Laptops, title: "Apple Laptop", subTitle: "Laptop", price: "$755", productImage: "Macbook4"),
        
        Product( type: .Tablets, title: "Apple tablet", subTitle: "tablet", price: "$303", productImage: "tablet1"),
        Product( type: .Tablets, title: "Apple tablet", subTitle: "tablet", price: "$232", productImage: "tablet2"),
        Product( type: .Tablets, title: "Apple tablet", subTitle: "tablet", price: "$922", productImage: "tablet3"),
        Product( type: .Tablets, title: "Apple tablet", subTitle: "tablet", price: "$555", productImage: "tablet4")
    ]
    // Filter products
    @Published var filteredProducts: [Product] = []
    // More products
    @Published var showMoreProductsOnType: Bool = false
    // Search
    @Published var searchText: String = ""
    @Published var searchActivate: Bool = false
    @Published var searchedProducts: [Product]?
    var searchCanclelable: AnyCancellable?
    // Init
    init() {
        filterProductByType()
        searchCanclelable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.filterProductBySearch()
                }else{
                    self.searchedProducts = nil
                }
            })
    }
    // Filter by type
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
    // Filter by searching
    func filterProductBySearch(){
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
                .lazy
                .filter { product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            DispatchQueue.main.async {
                self.searchedProducts = results.compactMap({product in
                    return product
                })
            }
        }
    }
}

