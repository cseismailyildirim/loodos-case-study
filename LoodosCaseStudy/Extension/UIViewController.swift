//
//  UIViewController.swift
//  LoodosCaseStudy
//
//  Created by ismailyildirim on 22.08.2021.
//

import Foundation
import SwiftMessages

extension UIViewController {
    func showMessage(error: String){
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.configureDropShadow()
        view.configureContent(title: "", body: error, iconText: "")
        view.iconImageView?.isHidden = true
        view.button?.isHidden = true
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        SwiftMessages.show(view: view)
    }
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
