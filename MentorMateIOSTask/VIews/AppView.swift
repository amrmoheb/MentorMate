//
//  AppView.swift
//  MentorMateIOSTask
//
//  Created by Mac on 11/24/21.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView{
            ClosestVenues().tabItem({
                Image("nearByPlaces")
                    .frame(width: 10, height: 10)
                Text("Closest Venues")
            })
            AboutUs().tabItem({
                Image("aboutUs-1")
                    .frame(width: 10, height: 10)
                Text("About us")
            })
        }.edgesIgnoringSafeArea(.top)
        .preferredColorScheme(.light)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
