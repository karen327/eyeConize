//
//  LifeViewController.swift
//  MindReader
//
//  Created by 曾思琦 on 2023/4/26.
//

import SwiftUI

class LifeViewController: UIViewController {
    
    @IBOutlet weak var lifeButton: UIButton!
    
    @IBOutlet weak var entertainmentButton: UIButton!
    @IBOutlet weak var othersButton: UIButton!
    
    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var callButton:UIButton!
    @IBOutlet weak var eCallButton:UIButton!
    @IBOutlet weak var toiletButton:UIButton!
    @IBOutlet weak var foodButton:UIButton!
    
    @IBOutlet weak var lifeButtonImage: UIImageView!
    @IBOutlet weak var entertainmentButtonImage: UIImageView!
    @IBOutlet weak var othersButtonImage: UIImageView!
    
    @IBAction func touchNavigationButton(_ sender: UIButton) {
        //let buttonName = String(describing: sender.self)

        switch sender {
        case lifeButton:
            lifeButtonImage.image = UIImage(named: "life_green")
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: { [self] in
                self.lifeButtonImage.image = UIImage(named: "life_white")
            })
            break
        case entertainmentButton:
            entertainmentButtonImage.image = UIImage(named: "entertainment_green")
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                self.performSegue(withIdentifier: "goToEntertainmentView", sender: nil)
            })
            break
        case othersButton:
            othersButtonImage.image = UIImage(named: "others_green")
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                self.performSegue(withIdentifier: "goToOthersView", sender: nil)
            })
            break
        default:
            break
        }
    }
    
    @IBAction func touchButton(_ sender: UIButton) {
        sender.backgroundColor = UIColor.green
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            sender.backgroundColor = UIColor.white
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TimeManager.shared.startTimer()
        
        addView(name: "dot")
        addView(name: "slash")
        addView(name: "cross")
        
        // 获取当前视图控制器中所有的 UIButton
        let buttons = view.subviews.filter { $0 is UIButton } as! [UIButton]
        
        // 为每个按钮应用样式
        buttons.forEach { button in
            styleButton(button: button)
        }
        
//        let lifeButtonImage = UIImage(named: "life_white.png")
//        lifeButton.setImage(lifeButtonImage, for: .normal)
//        lifeButton.imageView?.contentMode = .scaleAspectFit
//        lifeButton.clipsToBounds = true
//        lifeButton.backgroundColor = UIColor.clear
    }
    
    func styleButton(button: UIButton) {
        button.layer.cornerRadius = 10
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let message = userInfo["b"] as? String
            switch message{
            case "010":
                callButton?.backgroundColor = UIColor.green;
                let alertController = UIAlertController(title: "成功！", message: "已成功发出呼唤请求", preferredStyle: .alert)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    alertController.dismiss(animated: true, completion: nil)
                }
                present(alertController, animated: true, completion: nil)

                break;
                
            case "111":
                eCallButton?.backgroundColor = UIColor.green
                break
                
            case "100":
                toiletButton?.backgroundColor = UIColor.green
                break
                
            case "011":
                foodButton?.backgroundColor = UIColor.green
                performSegue(withIdentifier: "goToFoodView", sender: nil)
                break
            case .none: break
                
            case .some(_):break
            }
        }
    }

    func addView(name: String){
        let newImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        newImageView.image = UIImage(named: name)
        inputStackView.addArrangedSubview(newImageView)
        switch name{
        case "dot":
            newImageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
            newImageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
            break
        case "slash":
                newImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
                newImageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
            break
        case "cross":
                newImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
                newImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            break
        default:
        break
        }
    }
}
