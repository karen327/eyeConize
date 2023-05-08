//
//  LifeViewController.swift
//  MindReader
//
//  Created by 曾思琦 on 2023/4/26.
//

import SwiftUI

class LifeViewController: UIViewController {
    
    
    var handler=SessionHandler()
    
    lazy var input = inputBlank(inputStack: inputStack, inputContent: nil as String?, size: 1, maxLen: 260)
    lazy var historyInput = inputBlank(inputStack: historyStackView, inputContent: nil as String?, size: 0.5, maxLen: 260)
    
    @IBOutlet weak var goToEntertainmentButton: UIButton!
    @IBOutlet weak var goToElseButton: UIButton!
    @IBOutlet weak var emergencyButton: UIButton!
    @IBOutlet weak var callButton:UIButton!
    @IBOutlet weak var toiletButton:UIButton!
    @IBOutlet weak var foodButton:UIButton!
    
    @IBOutlet weak var inputStack: UIStackView!
    @IBOutlet weak var historyStackView: UIStackView!
    @IBOutlet weak var faceImage: UIImageView!
    @IBOutlet weak var naviBar: UIImageView!
    @IBOutlet weak var lockButton: UIButton!
    
    @IBAction func touchButton(_ sender: UIButton) {
        switch sender{
        case foodButton:
            sender.backgroundColor = UIColor.green
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            sender.backgroundColor = UIColor.white
                self.performSegue(withIdentifier: "goToMeal", sender: self)
                self.viewWillDisappear(false)
            })
            break
        case emergencyButton:
            sendMessage(message: "已成功发出求救消息！")
                sender.backgroundColor = UIColor.green
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                sender.backgroundColor = UIColor.white
                })
            break
        case callButton:
            sendMessage(message: "已成功呼唤亲属！")
            
                sender.backgroundColor = UIColor.green
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                sender.backgroundColor = UIColor.white
                })
            break
        case toiletButton:
            sendMessage(message: "已成功发出消息：我要上厕所")
                sender.backgroundColor = UIColor.green
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                sender.backgroundColor = UIColor.white
                })
            break
        case goToEntertainmentButton:
            performSegue(withIdentifier: "goToEntertainment", sender: self)
            self.viewWillDisappear(false)
            break
        case goToElseButton:
            performSegue(withIdentifier: "goToElse", sender: self)
            self.viewWillDisappear(false)
            break
            
        default:
            break
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faceImage.layer.cornerRadius = 20
        faceImage.backgroundColor = .white
        faceImage.contentMode = .scaleAspectFill
        faceImage.clipsToBounds = true
        handler.setupCamera()

        emergencyButton.layer.cornerRadius = 10
        callButton.layer.cornerRadius = 10
        toiletButton.layer.cornerRadius = 10
        foodButton.layer.cornerRadius = 10
        lockButton.layer.cornerRadius = 10
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            self.naviBar.image = UIImage(named: "lifeNavNormal")
        })
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 在当前视图控制器中移除上一个视图控制器
        if let previousVC = navigationController?.viewControllers.dropLast().last {
            navigationController?.popToViewController(previousVC, animated: true)
        }

        let myNotificationName = Notification.Name("codeBri")
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: myNotificationName, object: nil)
        handler.session.startRunning()
        print(44444)
//        faceImage.image = UIImage(named: "clock1")
        self.handler.videoCaptureCompletionBlockMask = { originalImage in
                       DispatchQueue.main.async {
                           
                               self.faceImage.image = originalImage
                                                      }
                   }
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let messasge = userInfo["former_code"] as? String
            
            if let formerCode = userInfo["former_code"] as? String{
                input.genNewStack(newContent: formerCode)
                print(formerCode)
            }
            if let currentCode = userInfo["current_code"] as? String{
                historyInput.genNewStack(newContent: currentCode)
                print(currentCode)
            }
            
            if let decode = userInfo["decode"] as? Bool{
                
                if decode{
                    input.genNewStack(newContent: "")
                    print(self)
                    print("Decoding...")
                    switch messasge{
                        
                    case "-.-":
                        touchButton(callButton)
                        break;
                    case "--.":
                        touchButton(emergencyButton)
                        break
                    case "-..":
                        touchButton(toiletButton)
                        break
                    case ".--":
                        touchButton(foodButton)
                        break
                    case "....":
                        break
                    case ".-.-":
                        touchButton(goToEntertainmentButton)
                    case ".--.":
                        touchButton(goToElseButton)
                        break
                        
                    case .none: break
                        
                    case .some(_):break
                    }
                }
                
            }
            

        }
    }

    func sendMessage(message: String){
        let alertController = UIAlertController(title: "成功！", message: message, preferredStyle: .alert)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            alertController.dismiss(animated: true, completion: nil)
        }
        present(alertController, animated: true, completion: nil)
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        print("life vew will disappear.")
        NotificationCenter.default.removeObserver(self)
        handler.session.stopRunning()
    }
    
}
