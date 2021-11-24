//
//  ClosestVenuesViewModel.swift
//  MentorMateIOSTask
//
//  Created by Mac on 11/24/21.
//

import Foundation
import CoreLocation
import CoreData
class ClosestVenuesViewModel: NSObject, ObservableObject {
    let manager = CLLocationManager()

     var location: CLLocationCoordinate2D?{
        didSet {
            self.GetClosestVenues(lat: "\(location?.latitude ?? 0.0)" , lang: "\(location?.longitude ?? 0.0)")
        }
    }
    var networkManger = NetworkLayer()
   // var lat = "41.8781"
   // var lang = "-87.6298"
    @Published var closestVenues = [closestVenuesResultsViewModel]()
    @Published var isLoading = true
    var CachedVenues = [CachedVenueViewModel]()

    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        self.StartScaningNearByVenues()
       // self.getCachedVeneus()

    }
    func StartScaningNearByVenues()  {
        requestLocation()
    }
    func GetClosestVenues(lat : String, lang: String ) {
        isLoading = true
        networkManger.Request(ResponseModel: ClosestVenuesResponse.self, RequestConfiq: NetworkRouter.GetNearByPlaces(lat , lang), completionHandler:   {
                              respose,error in
            if let response = respose {
            let closestVenuesResponse = respose as! ClosestVenuesResponse
          
            var id = 0
            if let results = closestVenuesResponse.results
            {
                CoreDataManager.shared.deleteAllVenuesData()
                for venue in results
                {
                    var resultVM = closestVenuesResultsViewModel()
                    resultVM.name = venue.name
                    id += 1
                    resultVM.id = id
                    DispatchQueue.main.async {
                        self.closestVenues.append(resultVM)
                        self.AddVenueToCach(name : resultVM.name ?? "no name")
                    }
                    
                }
            }
            }else
            {
                
                DispatchQueue.main.async {
                self.getCachedVeneus()
                }
            }
            self.isLoading = false
                      })
    }
    
   

  
   
}
extension ClosestVenuesViewModel: CLLocationManagerDelegate
{
    
    func requestLocation() {
        manager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
            if status == .authorizedWhenInUse
            {
                self.StartScaningNearByVenues()
                
            }
        }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        location = locations.first?.coordinate
    }
        
}
extension ClosestVenuesViewModel
{
    func getCachedVeneus() {
        
        let veneus = CoreDataManager.shared.getCachedVenues()
 
            self.CachedVenues = veneus.map(CachedVenueViewModel.init)
   
        print("CachedVenues =" + String(CachedVenues.count))
        var id = 0

        for venue in CachedVenues {
            
            var closestVenue = closestVenuesResultsViewModel()
            id += 1
            closestVenue.id = id
            closestVenue.name = venue.name
        self.closestVenues.append(closestVenue)

            
        }
    }
    func AddVenueToCach(name : String) {
        
        let venue = Venue(context: CoreDataManager.shared.persistentContainer.viewContext)
        venue.name = name
       
        
        CoreDataManager.shared.save()
    }
}
class closestVenuesResultsViewModel {
    var id = 0
    var name : String?
}
struct CachedVenueViewModel {
    
    let venue: Venue
    
    var id: NSManagedObjectID {
        return venue.objectID
    }
    
    var name: String {
        return venue.name ?? ""
    }
}
