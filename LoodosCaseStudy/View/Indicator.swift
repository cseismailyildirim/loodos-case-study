//
//  Indicator.swift
//  LoodosCaseStudy
//
//  Created by ismailyildirim on 24.08.2021.
//

import Foundation
import UIKit

public class Indicator {

    public static let sharedInstance = Indicator()
    var blurImg = UIImageView()
    var indicator = UIActivityIndicatorView()

    private init()
    {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.8
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.center = blurImg.center
        indicator.startAnimating()
        indicator.color = .blue
    }

    func showIndicator(){
        DispatchQueue.main.async( execute: {
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(self.blurImg)
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(self.indicator)
        })
    }
    func hideIndicator(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.blurImg.removeFromSuperview()
            self.indicator.removeFromSuperview()
        }
    }
}
