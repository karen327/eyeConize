//
//  EntertainmentViewController.swift
//  MindReader
//
//  Created by mac on 2023/4/29.
//

import UIKit
class EntertainmentViewController:UIViewController{
    
    var handler = SessionHandler()
    lazy var input = inputBlank(inputStack: inputStack, inputContent: nil as String?, size: 1, maxLen: 260)
    lazy var historyInput = inputBlank(inputStack: historyInputStack, inputContent: nil as String?, size: 0.5, maxLen: 260)
    
    
    
    
    @IBOutlet weak var faceImage: UIImageView!
    
    @IBOutlet weak var inputStack: UIStackView!
    @IBOutlet weak var tiktokButton: UIButton!
    @IBOutlet weak var novelButton:UIButton!
    @IBOutlet weak var moodButton:UIButton!
    @IBOutlet weak var musicButton:UIButton!
    
    @IBOutlet weak var historyInputStack: UIStackView!
    @IBOutlet weak var naviBar: UIImageView!
    @IBOutlet weak var lockButton: UIButton!
    
    @IBAction func touchButton(_ sender: UIButton) {
        switch sender{
        case musicButton:
            
            sender.backgroundColor = UIColor.green
            DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            sender.backgroundColor = UIColor.white
                self.performSegue(withIdentifier: "goToLife", sender: self)
                self.viewWillDisappear(false)
            })
            break
        default:
            break
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("entertainment did load.")
        // 在当前视图控制器中移除上一个视图控制器
        if let previousVC = navigationController?.viewControllers.dropLast().last {
            navigationController?.popToViewController(previousVC, animated: true)
        }

        faceImage.layer.cornerRadius = 20
        faceImage.backgroundColor = .white
        faceImage.contentMode = .scaleAspectFill
        faceImage.clipsToBounds = true

        handler.setupCamera()
        tiktokButton.layer.cornerRadius = 10
        novelButton.layer.cornerRadius = 10
        moodButton.layer.cornerRadius = 10
        musicButton.layer.cornerRadius = 10
        lockButton.layer.cornerRadius = 10
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            self.naviBar.image = UIImage(named: "entertainmentNavNormal")
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let myNotificationName = Notification.Name("codeBri")
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: myNotificationName, object: nil)
        super.viewWillAppear(animated)
        handler.session.startRunning()
        print(11111)
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
                        
                    case ".-.":
                        touchButton(novelButton)
                        sendMessage(message: "进入小说阅读模式……")
                        break;
                    case "---":
                        touchButton(musicButton)
                        sendMessage(message: "进入音乐模式……")
                        break
                    case "-..":
                        touchButton(tiktokButton)
                        sendMessage(message: "进入抖音……")
                        break
                    case ".--":
                        touchButton(moodButton)
                        sendMessage(message: "进入心情模式……")
                        break
                    case "....":
                        break
                    case "..-.":
                        performSegue(withIdentifier: "goToLife", sender: self)
                        viewWillDisappear(false)
                    case ".--.":
                        performSegue(withIdentifier: "goToElse", sender: self)
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
        print("entertainment will disappear")
        
        NotificationCenter.default.removeObserver(self)
        handler.session.stopRunning()
    }
}
