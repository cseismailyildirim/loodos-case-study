//
//  HomeViewController.swift
//  LoodosCaseStudy
//
//  Created by ismailyildirim on 21.08.2021.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
  
    lazy var viewModel:IHomeViewModel = HomeViewModel()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonSearch: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        viewModel.delegate = self
       
        tableView.register(cellType: SearchItemCell.self)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
         
        self.hideKeyboardWhenTappedAround()
        self.searchBar.delegate = self

        buttonSearch.layer.cornerRadius = 5
        buttonSearch.contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewController" {
            if let vc = segue.destination as? DetailViewController {
                if let index = sender as? Int {
                    vc.item = viewModel.item(at: index)
                }
            }
        }
    }
    @IBAction func actionSearch(_ sender: Any) {
        view.endEditing(true)
        if searchBar.text != "" && searchBar.text != nil {
            Indicator.sharedInstance.showIndicator()
            self.viewModel.search(text: searchBar.text!)
        }
    }
}

extension HomeViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if searchBar.text != "" && searchBar.text != nil {
            Indicator.sharedInstance.showIndicator()
            self.viewModel.search(text: searchBar.text!)
        }
    }
}
extension HomeViewController: HomeViewModelDelegate {
    func onSuccess() {
        Indicator.sharedInstance.hideIndicator()
        tableView.reloadData() 
    }
    
    func onError(err: String) {
        Indicator.sharedInstance.hideIndicator()
        showMessage(error: err)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SearchItemCell.self, for: indexPath)
        cell.initialize(model: viewModel.item(at: indexPath.row))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Indicator.sharedInstance.showIndicator()
        self.performSegue(withIdentifier: "DetailViewController", sender: indexPath.row)
    }
    
}
