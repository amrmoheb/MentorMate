//
//  AboutUs.swift
//  MentorMateIOSTask
//
//  Created by Mac on 11/24/21.
//

import SwiftUI

struct AboutUs: View {
    var body: some View {
        
        VStack {
            Text("For over 20 years, we’ve partnered with companies of all sizes and industries to solve their most complex business problems.")
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Spacer()
        }
    }
}

struct AboutUs_Previews: PreviewProvider {
    static var previews: some View {
        AboutUs()
    }
}
