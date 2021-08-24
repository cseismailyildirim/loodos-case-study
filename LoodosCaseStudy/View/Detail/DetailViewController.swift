//
//  DetailViewController.swift
//  LoodosCaseStudy
//
//  Created by ismailyildirim on 21.08.2021.
//

import Foundation
import UIKit
import FirebaseAnalytics

class DetailViewController: UIViewController {

    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPlot: UILabel!
    
    
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelRatingTitle: UILabel!
    
    @IBOutlet weak var labelGenreTitle: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    
    @IBOutlet weak var labelRuntimeTitle: UILabel!
    @IBOutlet weak var labelRuntime: UILabel!
    
    @IBOutlet weak var labelYearTitle: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    
    @IBOutlet weak var labelDirectorTitle: UILabel!
    @IBOutlet weak var labelDirector: UILabel!
    
    @IBOutlet weak var labelWriterTitle: UILabel!
    @IBOutlet weak var labelWriter: UILabel!
    
    @IBOutlet weak var labelLanguageTitle: UILabel!
    @IBOutlet weak var labelLanguage: UILabel!
    
    
    lazy var viewModel: IDetailViewModel = DetailViewModel()
    var item: SearchItemModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Detail"
        configureView()
        
        viewModel.delegate = self
        viewModel.fetchDetails(imdbID: item?.imdbID ?? "")
    }
    
    private func configureView(){
        labelTitle.numberOfLines = 0
        labelPlot.numberOfLines = 0
        
        labelRatingTitle.text = "Rating :"
        labelRating.numberOfLines = 0
        
        labelGenreTitle.text = "Genre :"
        labelGenre.numberOfLines = 0
        
        labelRuntimeTitle.text = "Runtime :"
        labelRuntime.numberOfLines = 0
        
        labelYearTitle.text = "Year :"
        labelYear.numberOfLines = 0
        
        labelDirectorTitle.text = "Director :"
        labelDirector.numberOfLines = 0
        
        labelWriterTitle.text = "Writer :"
        labelWriter.numberOfLines = 0
        
        labelLanguageTitle.text = "Language :"
        labelLanguage.numberOfLines = 0
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func onSuccess(dataSource: DetailResponseModel) {
        if let url = URL(string: dataSource.Poster ?? "") {
            imageViewPoster.af.setImage(withURL: url)
        }else{
            imageViewPoster.image = nil
        }
        labelTitle.text = dataSource.Title
        labelRating.text = dataSource.imdbRating
        labelPlot.text = dataSource.Plot
        labelGenre.text = dataSource.Genre
        labelRuntime.text = dataSource.Runtime
        labelYear.text = dataSource.Year
        labelDirector.text = dataSource.Director
        labelWriter.text = dataSource.Writer
        labelLanguage.text = dataSource.Language
        
         
        Analytics.logEvent("detail", parameters: [
            "Title": dataSource.Title ?? "",
            "Year": dataSource.Year ?? "",
            "Director": dataSource.Director ?? "",
            "Language": dataSource.Language ?? ""
        ])
        Indicator.sharedInstance.hideIndicator()
    }
    
    func onError(err: String) {
        Indicator.sharedInstance.hideIndicator()
       showMessage(error: err)
    }
    
    
}
