//
//  HomeVC.swift
//  iOSNFCDemo
//
//  Created by Chandra Jayaswal on 29/08/2023.
//

import UIKit

class HomeVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSignOutAction(_ sender: Any) {
        self.moveToLoginVC()
    }
    
}
