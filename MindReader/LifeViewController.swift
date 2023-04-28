//
//  LifeViewController.swift
//  MindReader
//
//  Created by 曾思琦 on 2023/4/26.
//

import SwiftUI

class LifeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myNotificationName = Notification.Name("blinkMessage")
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: myNotificationName, object: nil)

    }
    
    @IBOutlet weak var callButton:UIStackView?
    @IBOutlet weak var toiletButton:UIStackView?
    @IBOutlet weak var foodButton:UIStackView?
    
    
    
    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let messasge = userInfo["b"] as? String
            switch messasge{
            case "001":
                callButton?.backgroundColor = UIColor.green;
                let alertController = UIAlertController(title: "成功！", message: "已成功发出呼唤请求", preferredStyle: .alert)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    alertController.dismiss(animated: true, completion: nil)
                }
                present(alertController, animated: true, completion: nil)

                break;
            case "1001":
                toiletButton?.backgroundColor = UIColor.green
                
                break
            case "0010":
                foodButton?.backgroundColor = UIColor.green
                performSegue(withIdentifier: "foodSegue", sender: nil)
                break
            case .none: break
                
            case .some(_):break
            }
        }
    }

    

    
}
