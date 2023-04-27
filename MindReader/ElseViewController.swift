//
//  ElseViewController.swift
//  MindReader
//
//  Created by mac on 2023/4/28.
//

import UIKit
class ElseViewController: UIViewController{
    
    var handler = SessionHandler()
    lazy var input = inputBlank(inputStack: inputStackView, inputContent: nil as String?, size: 1, maxLen: 260)
    lazy var historyInput = inputBlank(inputStack: historyInputStackView, inputContent: nil as String?, size: 0.5, maxLen: 260)
    
    
    @IBOutlet weak var lockButton: UIButton!
    
    
    @IBOutlet weak var naviBar: UIImageView!
    @IBOutlet weak var faceImage: UIImageView!
    @IBOutlet weak var historyInputStackView: UIStackView!
    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var shortcutButton: UIButton!
    @IBOutlet weak var acButton: UIButton!
    @IBOutlet weak var lightButton: UIButton!
    @IBAction func touchButton(_ sender: UIButton) {
        sender.backgroundColor = UIColor.green
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
        sender.backgroundColor = UIColor.white
        })

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("else did load.")
        
        faceImage.layer.cornerRadius = 20
        faceImage.backgroundColor = .white
        faceImage.contentMode = .scaleAspectFill
        faceImage.clipsToBounds = true

        handler.setupCamera()
        typeButton.layer.cornerRadius = 10
        shortcutButton.layer.cornerRadius = 10
        acButton.layer.cornerRadius = 10
        lightButton.layer.cornerRadius = 10
        lockButton.layer.cornerRadius = 10
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            self.naviBar.image = UIImage(named: "elseNavNormal")
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // 在当前视图控制器中移除上一个视图控制器
        if let navigationController = self.navigationController{
            print("navigationController exists.")
            if let previousVC = navigationController.viewControllers.dropLast().last {
                print("removing......")
                navigationController.popToViewController(previousVC, animated: true)
            }
        }


        let myNotificationName = Notification.Name("codeBri")
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: myNotificationName, object: nil)
        handler.session.startRunning()
        print(7777)
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
                    print("Decoding...")
                    switch messasge{
                        
                    case "..-":
                        touchButton(typeButton)
                        sendMessage(message: "进入文字消息撰写模式……")
                        break;
                    case "--.":
                        touchButton(shortcutButton)
                        sendMessage(message: "进入音乐模式……")
                        break
                    case "---":
                        touchButton(acButton)
                        sendMessage(message: "调节空调……")
                        break
                    case "-.-":
                        touchButton(lightButton)
                        sendMessage(message: "调节灯光……")
                        break
                    case "....":
                        break
                    case "..-.":
                        performSegue(withIdentifier: "goToLife", sender: self)
                        viewWillDisappear(false)
                        break
                    case ".-.-":
                        performSegue(withIdentifier: "goToEntertainment", sender: self)
                        viewWillDisappear(false)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alertController.dismiss(animated: true, completion: nil)
        }
        present(alertController, animated: true, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        print("Else will disappear.")
        NotificationCenter.default.removeObserver(self)
        handler.session.stopRunning()
    }
}
