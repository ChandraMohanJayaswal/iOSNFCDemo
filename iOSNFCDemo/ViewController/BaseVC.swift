//
//  BaseVC.swift
//  iOSNFCDemo
//
//  Created by Chandra Jayaswal on 29/08/2023.
//

import UIKit

class BaseVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func moveTagListVC(user: User) {
        let viewControllers = self.navigationController?.viewControllers
        if let viewControllers = viewControllers {
            for aVC in viewControllers {
                if aVC is NFCTagListVC {
                    self.navigationController?.popToViewController(aVC, animated: false)
                    return
                }
            }
        }
        
        let vc = NavigationHandler.initiateViewControllerWith(identifier: .NFCTagListVC, storyboardName: .Main) as! NFCTagListVC
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToLoginVC() {
        let viewControllers = self.navigationController?.viewControllers
        if let viewControllers = viewControllers {
            for aVC in viewControllers {
                if aVC is LoginVC {
                    self.navigationController?.popToViewController(aVC, animated: false)
                    return
                }
            }
        }
        let vc = NavigationHandler.initiateViewControllerWith(identifier: .LoginVC, storyboardName: .Main) as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func moveToTabBarController() {
        let storybaord = UIStoryboard(name: StoryboardNames.Main.rawValue, bundle: nil)
        let tabBarController = storybaord.instantiateViewController(withIdentifier: VCNames.TabBarController.rawValue) as! TabBarController
        self.navigationController?.pushViewController(tabBarController, animated: false)
    }

}
