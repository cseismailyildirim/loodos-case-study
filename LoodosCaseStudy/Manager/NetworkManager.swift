//
//  NetworkManager.swift
//  BaseProject
//
//  Created by ismailyildirim on 21.08.2021.
//

import Foundation
import Alamofire

protocol INetworkManager {
    func request<ResponseT: Codable>(request: RequestType, onSuccess: @escaping ((ResponseT?) -> Void), onError: @escaping ((String) -> Void))
    func checkForReachability(onSuccess: @escaping(() -> Void), onError: @escaping ((String) -> Void))
}

class NetworkManager: INetworkManager {
   static var shared = NetworkManager()
    
    private var configuration: URLSessionConfiguration =  URLSessionConfiguration.default

    private init() {
        configuration.timeoutIntervalForRequest = TimeInterval(40)
        configuration.timeoutIntervalForResource = TimeInterval(40)
    }

    func request<ResponseT: Codable>(request: RequestType, onSuccess: @escaping ((ResponseT?) -> Void), onError: @escaping ((String) -> Void)) {
        AF.request(request.endpoint, method: request.method, parameters: request.request, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data, let json = try? JSONDecoder().decode(ResponseT.self, from: data) {
                    onSuccess(json)
                    return
                } else {
                    onError("json parse error")
                }
            case .failure:
                onError("Generic error")
            }
            
        }
    }
    
    let networkReachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")

    func checkForReachability(onSuccess: @escaping(() -> Void), onError: @escaping ((String) -> Void)) {
        networkReachabilityManager?.startListening(onUpdatePerforming: { (status) in
            print("Network Status: \(status)")
            switch status {
            case .unknown:
                 onError("Lütfen internet bağlantınızı kontrol edin")
            case .notReachable:
                onError("Lütfen internet bağlantınızı kontrol edin")
            case .reachable(_):
                onSuccess()
            }
        })
    }
    
}
