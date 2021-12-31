//
//  APIService.swift
//  WeatherApp3
//
//  Created by khawlah khalid on 09/12/2021.
//

import Foundation


public class APIService {
    
    public enum APIError : Error{
        
        
        case error(_ errorString:String)
        
    }
    
    public static let shared = APIService()
    
    public func getJSON<T:Decodable>(urlString:String,
                              
                              dateDecodingStrategy:JSONDecoder.DateDecodingStrategy = .deferredToDate
                              ,keyDecodingStrategy : JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
                              
                              ,completion:@escaping (Result<T,APIError>)->()){
        

        guard let url = URL(string: urlString ) else {
            
            completion(.failure(APIError.error(NSLocalizedString("Error:Invalid URL", comment: ""))))
            
            return

        }
        
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.error("Error: \(error.localizedDescription)")))
            }
            guard let data = data else {
                completion(.failure(.error(NSLocalizedString("Error Data is corrupt", comment: ""))))
                return
                
            }
            
            
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy=dateDecodingStrategy
            decoder.keyDecodingStrategy=keyDecodingStrategy
            do{
            let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
                return
            }
            catch let decodingError{
                
                completion(.failure(APIError.error("Error : \(decodingError.localizedDescription)")))
                return
                
            }
        }.resume()
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}
