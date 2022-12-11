//
//  ProfilePage.swift
//  E-Commerce App UI
//
//  Created by KhaleD HuSsien on 11/12/2022.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    Text("My Profile")
                        .font(.system(size: 28).bold())
                        .frame(maxWidth: .infinity,alignment: .leading)
                    VStack(spacing: 15){
                        Image("profileImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        Text("Khaled hussien")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        HStack(alignment: .top, spacing: 10){
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(Angle(degrees: 180))
                            Text("Address: El-manshat Elkobra\n El-Santa,Tanta\nEl-Garbia,Egypt")
                                .font(.system(size: 15))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.horizontal,.bottom])
                    .background(
                        Color.white
                            .cornerRadius(12)
                    )
                    .padding()
                    .padding(.top, 40)
                    // CustomNavigationLink
                    CustomNavigationLink(title: "Edit Profile") {
                        Text("")
                            .navigationTitle("Edit Profile")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeColor").ignoresSafeArea())
                    }
                    CustomNavigationLink(title: "Shopping address") {
                        Text("")
                            .navigationTitle("Shopping address")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeColor").ignoresSafeArea())
                    }
                    CustomNavigationLink(title: "Order history") {
                        Text("")
                            .navigationTitle("Order history")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeColor").ignoresSafeArea())
                    }
                    CustomNavigationLink(title: "Cards") {
                        Text("")
                            .navigationTitle("Cards")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeColor").ignoresSafeArea())
                    }
                    CustomNavigationLink(title: "Notifications") {
                        Text("")
                            .navigationTitle("Notifications")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeColor").ignoresSafeArea())
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 20)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("HomeColor")
                    .ignoresSafeArea()
            )
        }
    }
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String, @ViewBuilder content: @escaping ()-> Detail)-> some View{
        NavigationLink {
            content()
        } label: {
            HStack{
                Text(title)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
                Color.white
                    .cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top,10)
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
