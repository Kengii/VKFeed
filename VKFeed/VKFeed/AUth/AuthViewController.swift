//
//  AuthViewController.swift
//  VKFeed
//
//  Created by Владимир Данилович on 16.07.22.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = SceneDelegate.shared().authService
    }
    
    @IBAction func loginVK() {
        authService.wakeUpSession()
    }
}
