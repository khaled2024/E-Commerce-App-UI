//
//  MainPage.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 09/12/2022.
//

import SwiftUI
struct MainPage: View {
    @State var currentTap: Tap = .Home
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    @Namespace var animation
    // Hide Tap Bar
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTap){
                // Home Tap...
                Home(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tap.Home)
                // Liked Tap...
                LikedPage()
                    .environmentObject(sharedData)
                    .tag(Tap.Liked)
                ProfilePage()
                    .tag(Tap.Profile)
                CartPage()
                    .environmentObject(sharedData)
                    .tag(Tap.Cart)
            }
            // Custom Tab Bar
            HStack(spacing: 0) {
                ForEach(Tap.allCases,id: \.self) { tap in
                    Button {
                        currentTap = tap
                    } label: {
                        Image(tap.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                        // appling little shadow
                            .background(
                                Color("Purple")
                                    .opacity(0.07)
                                    .cornerRadius(8)
                                // blurring
                                    .blur(radius: 3)
                                // padding in shadow
                                    .padding(-7)
                                    .opacity(currentTap == tap ? 1 : 0)
                                
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTap == tap ? Color("Purple") : Color.black.opacity(0.3))
                    }
                }
            }
            .padding([.horizontal,.top])
            .padding(.bottom, 10)
            .background(Color("HomeColor")).ignoresSafeArea()
        }
        .background(Color("HomeColor").ignoresSafeArea())
        .overlay(
            ZStack{
                if let product = sharedData.detailProduct,sharedData.showDetailProduct{
                    ProductDetailView(product: product, animation: animation)
                        .environmentObject(sharedData)
                    // adding transitions...
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
// Making case Iterable
// enum tap cases
enum Tap: String, CaseIterable {
    case Home = "Home"
    case Liked = "Liked"
    case Profile = "Profile"
    case Cart = "Cart"
}
