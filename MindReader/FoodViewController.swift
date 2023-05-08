//
//  FoodViewController.swift
//  MindReader
//
//  Created by 曾思琦 on 2023/4/26.
//

import UIKit

class FoodViewController: UIViewController {
    
    //图片里面有点：dot  横：slash 加号：cross
    //点的高度和宽度是15
    
    
    
    var handler = SessionHandler()
    
    lazy var input = inputBlank(inputStack: inputStackView, inputContent: nil as String?, size: 1, maxLen: 260)
    lazy var historyInput = inputBlank(inputStack: historyInputStackView, inputContent: nil as String?, size: 0.5, maxLen: 260)
    @IBOutlet weak var fruitButton: UIButton!
    
    @IBOutlet weak var faceImage: UIImageView!
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var historyInputStackView: UIStackView!
    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var drinkButton: UIButton!
    @IBOutlet weak var mealButton: UIButton!
    @IBOutlet weak var milkButton: UIButton!
    @IBAction func back(_ sender: UIButton) {
        
            sender.backgroundColor = UIColor.green
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                sender.backgroundColor = UIColor.clear
            })
    }
    @IBAction func touchButton(_ sender: UIButton) {
        switch sender{
        case fruitButton:
            sendMessage(message: "已成功发出消息：我想要吃水果。")
            break
        case mealButton:
            sendMessage(message: "已成功发出消息：我想要吃正餐。")
            break
        case drinkButton:
            sendMessage(message: "已成功发出消息：我想要喝水")
            break
        case milkButton:
            sendMessage(message: "已成功发出消息：我想要喝牛奶")
            break
        default:
            break
        }
        sender.backgroundColor = UIColor.green
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
        sender.backgroundColor = UIColor.white
            self.performSegue(withIdentifier: "goBackToLife", sender: self)
            self.viewWillDisappear(false)
        })

    }
    
    
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
        faceImage.layer.cornerRadius = 20
        faceImage.backgroundColor = .white
        faceImage.contentMode = .scaleAspectFill
        faceImage.clipsToBounds = true
        handler.setupCamera()
        fruitButton.layer.cornerRadius = 10
        mealButton.layer.cornerRadius = 10
        drinkButton.layer.cornerRadius = 10
        milkButton.layer.cornerRadius = 10
        goBackButton.layer.cornerRadius = 10
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
        print(22222)
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
                        
                    case "..-.":
                        touchButton(fruitButton)
                        break;
                    case "-..":
                        touchButton(mealButton)
                        break
                    case ".-.":
                        touchButton(drinkButton)
                        break
                    case "---":
                        touchButton(milkButton)
                        break
                    case "....":
                        touchButton(goBackButton)
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
            print("segue performed")
            

        }
        present(alertController, animated: true, completion: nil)
        
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)
        handler.session.stopRunning()
    }
    
    
}
