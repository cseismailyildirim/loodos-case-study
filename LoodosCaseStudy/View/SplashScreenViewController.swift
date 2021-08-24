//
//  ViewController.swift
//  LoodosCaseStudy
//
//  Created by ismailyildirim on 21.08.2021.
//

import UIKit
import Firebase
import SwiftMessages

class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var labelCompanyName: UILabel!
    
    private var companyName: String = ""{
        didSet{
            self.labelCompanyName.text = companyName
        }
    }
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.companyName = self.remoteConfig.configValue(forKey: "companyName").stringValue ?? ""
        checkInternetConnection()
    }
    
    private func checkInternetConnection(){
        NetworkManager.shared.checkForReachability {
            self.fetchRemoteConfigs()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.performSegue(withIdentifier: "HomeViewController", sender: nil)
            }
        } onError: { (err) in
            self.showMessage(error: err)
        }
    }
    
    private func fetchRemoteConfigs(){
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                self.remoteConfig.activate {  changed, error in
                    if changed {
                        self.companyName = self.remoteConfig.configValue(forKey: "companyName").stringValue ?? ""
                    }
                }
            }
        }
    }
}

