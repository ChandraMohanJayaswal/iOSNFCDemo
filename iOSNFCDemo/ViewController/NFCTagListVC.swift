//
//  NFCTagListVC.swift
//  iOSNFCDemo
//
//  Created by Chandra Jayaswal on 29/08/2023.
//

import UIKit

class NFCTagListVC: BaseVC {
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("UserName: \(self.user?.userName ?? "")")
        print("Password: \(self.user?.password ?? "")")
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.moveToLoginVC()
    }
}
