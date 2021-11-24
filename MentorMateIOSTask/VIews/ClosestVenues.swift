//
//  closestVenues.swift
//  MentorMateIOSTask
//
//  Created by Mac on 11/24/21.
//

import SwiftUI


struct ClosestVenues: View {
  @StateObject  var ClosestVenuesVM = ClosestVenuesViewModel()
   
    var body: some View {
        
        ZStack {
            
            List(ClosestVenuesVM.closestVenues, id: \.id) { venueName in
                Text(venueName.name ?? "")
            }
            Spacer()
            if (ClosestVenuesVM.isLoading)
            {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                .scaleEffect(2.0)
                
            }
           // Spacer()
        }
        
    }
}

struct ClosestVenues_Previews: PreviewProvider {
    static var previews: some View {
        ClosestVenues()
    }
}
