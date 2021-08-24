//
//  HomeViewModel.swift
//  LoodosCaseStudy
//
//  Created by ismailyildirim on 21.08.2021.
//

import Foundation

protocol HomeViewModelDelegate {
    func onSuccess()
    func onError(err: String)
}
protocol IHomeViewModel {
    var delegate: HomeViewModelDelegate? { get set } 
    
    var numberOfItems: Int { get }
    func item(at index: Int) -> SearchItemModel
    
    func search(text: String)
}
class HomeViewModel: IHomeViewModel {
   
     
    private var dataSource: [SearchItemModel] = []
   
    var delegate: HomeViewModelDelegate?
    var isLoading: ((Bool)->())?
    
    var numberOfItems: Int {
        return dataSource.count
    }
    
    func item(at index: Int) -> SearchItemModel {
        return dataSource[index]
    }

    func search(text: String) {
        NetworkManager.shared.request(request: .search(text)) { (data: SearchResponseModel?) in
            if data?.Search != nil {
                self.dataSource = data!.Search!
                self.delegate?.onSuccess()
            }
        } onError: { (err) in
            self.delegate?.onError(err: "Hata olustu")
        }
    }
}
