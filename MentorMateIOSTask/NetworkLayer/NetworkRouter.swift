

import Foundation

enum NetworkRouter
{  static let baseURLString = "https://api.foursquare.com/v3/places/nearby?limit=5"
 
  
    
    case GetNearByPlaces(String , String)
    

    func GetUrl() -> String {
  
        var relativePath = ""
        
        switch self {
        case .GetNearByPlaces(let lat , let lang):
            relativePath = "&ll=" + String(lat) + "," + String(lang)

        }
      
        return NetworkRouter.baseURLString + relativePath
    }
    
    func GetMethod() -> String {
        switch self {
       
        case .GetNearByPlaces :
             return "Get"
       
        }
    }

  
    
}
