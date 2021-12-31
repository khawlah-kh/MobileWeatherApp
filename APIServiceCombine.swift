//
//  APIServiceCombine.swift
//  WeatherApp3
//
//  Created by khawlah khalid on 19/12/2021.
//

import Foundation
import Combine

public class APIServiceCombine {
    
    public enum APIError : Error{

        case error(_ errorString:String)
        
    }
    
    public static let shared = APIServiceCombine()
    var cancellables = Set<AnyCancellable>()
    
    public func getJSON<T:Decodable>(urlString:String,
                                     
                                     dateDecodingStrategy:JSONDecoder.DateDecodingStrategy = .deferredToDate
                                     ,keyDecodingStrategy : JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
                                     
                                     ,completion:@escaping (Result<T,APIError>)->()){
        
        
        guard let url = URL(string: urlString ) else {
            
            completion(.failure(APIError.error(NSLocalizedString("Error:Invalid URL", comment: ""))))
            
            return
            
        }
        
        let request = URLRequest(url: url)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy=dateDecodingStrategy
        decoder.keyDecodingStrategy=keyDecodingStrategy
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map{$0.data}
            .decode(type: T.self, decoder: decoder)
            .receive(on:RunLoop.main)
            .sink { (taskCompletion) in
                switch taskCompletion {
                case .finished:
                    return
                case .failure(let decodingError):
                    completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)")))
                }
                
            } receiveValue: { (decodedData) in
                completion(.success(decodedData))
            }
            .store(in: &cancellables)
        
        
    }
    
    
}


