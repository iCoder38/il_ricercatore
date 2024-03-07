import Foundation
import Alamofire
//
//struct API {
//    
//    private static let decoder = JSONDecoder()
//    
//    static func getRequest<T: Decodable>(urlPath: String, model: T.Type, completed: @escaping(Result<T, AFError>)-> Void) {
//        
//        let request = BaseService.shared.generateRequest(url: urlPath, method: .get, body: nil)
//        
//        AF.request(request).validate().responseDecodable(of: model.self, decoder: decoder) { (response) in
//            
//            switch response.result {
//                
//            case .success(let result):
//                
//                completed(.success(result))
//                
//            case .failure(let error):
//                
//                completed(.failure(error))
//                
//            }
//        }
//    }
//}
//    
//class BaseService {
//    
//    public static let shared = BaseService()
//   
//    private var request = URLRequest(url: URL(string: application_base_url)!)
//    
//    private init() {}
//    
//    public func generateRequest(url: String, method: HTTPMethod, body: Data?) -> URLRequest {
//        
//        guard let formateUrl = URL(string: url) else {
//            fatalError("Invalid URL")
//        }
//        
//        request.url      = formateUrl
//        request.method   = method
//        
//        if let body_data = body {
//            request.httpBody = body_data
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        }
//        
//            
//        return request
//    }
//    
//    
//    
//    
//}
open class NetworkHelper {

    class var sharedManager: NetworkHelper {
        struct Static{
            static let instance: NetworkHelper = NetworkHelper()
        }
        return Static.instance
    }

    func request(_ method: HTTPMethod, _ URLString: String, parameters: [String : String]? = [:], headers: [String : String]? = [:], completion:@escaping (Any?) -> Void, failure: @escaping (Error?) -> Void) {

        let URL = "BASE_PATH" + "URLString"
        AF.request(URL, method: method, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in

                switch response.result {
                case .success:
                    //completion(response.result.value!)
                    print("=======================")
                    print("======= SUCCESS =======")
                    print("=======================")
                case .failure(let error):
                    failure(error)
                    
                    print("=======================")
                    print("======== FAIL =========")
                    print("=======================")
                    
                    return
                    
//                    guard error.localizedDescription == JSON_COULDNOT_SERIALISED else {
//                        return
//                    }

                }
        }
    }
}

