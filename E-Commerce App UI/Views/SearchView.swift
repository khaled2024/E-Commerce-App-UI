//
//  SearchView.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 10/12/2022.
//

import SwiftUI

struct SearchView: View {
    var animation: Namespace.ID
    @EnvironmentObject var homeData: HomeViewModel
    @EnvironmentObject var sharedData: SharedDataModel
    // activate TF
    @FocusState var startTF: Bool
    var body: some View {
        VStack(spacing: 0) {
            // search bar
            HStack(spacing: 20) {
                // close btn
                Button {
                    withAnimation {
                        homeData.searchActivate = false
                    }
                    homeData.searchText = ""
                    // resetting
                    sharedData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black.opacity(0.7))
                }
                // search bar
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    // TF
                    TextField("Search", text: $homeData.searchText)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                        .focused($startTF)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color("Purple") , lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing,20)
            }
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom, 10)
            // Showing result if searching...
            // else showing no result found if empty
            if let products = homeData.searchedProducts{
                if products.isEmpty{
                    // no result found...
                    VStack(spacing: 10) {
                        Image("NotFound")
                            .resizable()
                            .scaledToFit()
                            .padding(.top, 60)
                        Text("Item Not Found")
                            .font(.system(size: 22).bold())
                        Text("Try a more generic search term or try looking for alternative products.")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                    .padding()
                }else{
                    // Filter results
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0){
                            // found text...
                            Text("Found \(products.count) results")
                                .font(.system(size: 24).bold())
                                .padding(.vertical)
                            
                            // staggered grid...
                            StaggeredGrid(columns: 2, spacing: 20, list: products) { product in
                                // card view
                                ProductCardView(product: product)
                            }
                        }
                        .padding()
                    }
                }
            }else{
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .background(Color("HomeColor").ignoresSafeArea())
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
    }
    //MARK: - ViewBuilder
    @ViewBuilder
    func ProductCardView(product: Product)-> some View{
        VStack(spacing: 10) {
            // adding matched gemotry effect
            ZStack{
                if sharedData.showDetailProduct{
                    Image(product.productImage)
                        .resizable()
                        .scaledToFit()
                        .opacity(0)
                }else{
                    Image(product.productImage)
                        .resizable()
                        .scaledToFit()
                        .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
            }
            // moving image to top
                .offset(y: -50)
                .padding(.bottom, -50)
            Text(product.title)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            Text(product.subTitle)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            Text(product.price)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color("Purple"))
                .padding(.top, 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        .padding(.top, 50)
        // showing product detail when tapped
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
