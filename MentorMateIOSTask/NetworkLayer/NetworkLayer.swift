

import Foundation
class NetworkLayer {
    
    
       var AnyModel :Any!
    typealias CompletionHandler = (Any?,Error?) -> Void
    init() {
        
    }
    //swicher
   func Request<T:Decodable>( ResponseModel: T.Type,RequestConfiq: NetworkRouter,completionHandler: @escaping  CompletionHandler)
    {
        switch RequestConfiq.GetMethod() {
       
      case "Get":
             GetRequest(Model: ResponseModel, RequestConfiq: RequestConfiq, completionHandler: completionHandler)
              print("Get Request Proceed")
        default:
            print("No Method setted")
        }
    }
    public  func GetRequest<T:Decodable>( Model: T.Type,RequestConfiq: NetworkRouter,completionHandler: @escaping  CompletionHandler)
      {
        
        let session = URLSession.shared
        let url = URL(string: RequestConfiq.GetUrl())!
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("fsq3eYy15n5ObbwglfMkBDLd2HXKYcjM1NyyiLlQSZcjp60=", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request , completionHandler: { data, response, error in
                    // Check the response
                    print(response)
                    
                    // Check if an error occured
                    if error != nil {
                        // HERE you can manage the error
                        print(error)
                        completionHandler(nil,MentorMateAppError.NetworkingError(message: "\(error)" ))

                        return
                    }

                    // Serialize the data into an object
              do{
                self.AnyModel =  try  JSONDecoder().decode(Model, from: data!)
                }
           catch{
                print("Error during JSON serialization: \(error.localizedDescription)")
            completionHandler(nil,MentorMateAppError.ParsingError(message: "\(error)" ))

                }
           
      
                 completionHandler(self.AnyModel,nil)
                    
                })
                task.resume()


     
 
    }
  
}
