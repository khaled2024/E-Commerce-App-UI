//
//  Home.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 09/12/2022.
//

import SwiftUI

struct Home: View {
    @StateObject var HomeData: HomeViewModel = HomeViewModel()
    @Namespace var animation
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15){
                // search bar
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    TextField("Search", text: .constant(""))
                        .disabled(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color.gray , lineWidth: 0.8)
                )
                .frame(width: getRect().width/1.6)
                .padding(.horizontal, 25)
                // Text(Title)
                Text("Order online\ncollect in store")
                    .font(.system(size: 28).bold())
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                // products Tap...
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18){
                        ForEach(ProductType.allCases, id: \.self) { type in
                            productTypeView(type: type)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top,28)
                // Products page
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 25) {
                        ForEach(HomeData.filteredProducts) { product in
                            // product card view
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom)
                    .padding(.top, 80)
                }
                // button see more products
                Button {
                    HomeData.showMoreProductsOnType.toggle()
                } label: {
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("see more")
                    }
                    .font(.system(size: 15).bold())
                    .foregroundColor(Color("Purple"))
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
                .padding(.trailing)
                .padding(.top, 10)
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.gray.opacity(0.1))
        .onChange(of: HomeData.productType) { newValue in
            HomeData.filterProductByType()
        }
        .sheet(isPresented: $HomeData.showMoreProductsOnType) {
            MoreProductView()
        }
    }
    //MARK: - ViewBuilder
    @ViewBuilder
    func productTypeView(type: ProductType)-> some View{
        Button {
            withAnimation {
                HomeData.productType = type
            }
        } label: {
            Text(type.rawValue)
                .font(.system(size: 15))
                .fontWeight(.semibold)
            // change color base on current product type...
                .foregroundColor(HomeData.productType == type ? Color("Purple") : .gray)
                .padding(.bottom, 10)
            // adding indecator
                .overlay(
                    ZStack{
                        if HomeData.productType == type {
                            Capsule()
                                .fill(Color("Purple"))
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        }else{
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                        .padding(.horizontal, -5)
                    ,alignment: .bottom)
        }
    }
    @ViewBuilder
    func ProductCardView(product: Product)-> some View{
        VStack(spacing: 10) {
            Image(product.productImage)
                .resizable()
                .scaledToFit()
                .frame(width: getRect().width / 2.5, height: getRect().height / 4)
            // moving image to top
                .offset(y: -80)
                .padding(.bottom, -80)
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
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
