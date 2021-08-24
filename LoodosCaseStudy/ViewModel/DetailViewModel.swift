//
//  DetailViewModel.swift
//  LoodosCaseStudy
//
//  Created by ismailyildirim on 21.08.2021.
//

import Foundation

protocol DetailViewModelDelegate {
    func onSuccess(dataSource: DetailResponseModel)
    func onError(err: String)
}

protocol IDetailViewModel {
    var delegate: DetailViewModelDelegate? { get set }
    
    func fetchDetails(imdbID: String)
    
}
class DetailViewModel: IDetailViewModel {
 
    var delegate: DetailViewModelDelegate?
   
    
    func fetchDetails(imdbID: String) {
        NetworkManager.shared.request(request: .detail(imdbID)) { (data: DetailResponseModel?) in
            if data != nil {
                self.delegate?.onSuccess(dataSource: data!)
            }
        } onError: { (err) in
            self.delegate?.onError(err: "Bir hata olustu")
        }
    }
}
