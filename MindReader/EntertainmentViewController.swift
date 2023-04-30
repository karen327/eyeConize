//
//  EntertainmentViewController.swift
//  MindReader
//
//  Created by 曾思琦 on 2023/4/28.
//

import SwiftUI

class EntertainmentViewController: UIViewController {
    
    @IBOutlet weak var lifeButton: UIButton!
    
    @IBOutlet weak var entertainmentButton: UIButton!
    @IBOutlet weak var othersButton: UIButton!
    
    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var bookButton:UIButton!
    @IBOutlet weak var musicButton:UIButton!
    @IBOutlet weak var tiktokButton:UIButton!
    @IBOutlet weak var moodButton:UIButton!
    
    @IBOutlet weak var lifeButtonImage: UIImageView!
    @IBOutlet weak var entertainmentButtonImage: UIImageView!
    @IBOutlet weak var othersButtonImage: UIImageView!

    @IBAction func touchNavigationButton(_ sender: UIButton) {
        switch sender {
        case lifeButton:
            lifeButtonImage.image = UIImage(named: "life_green")
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                self.performSegue(withIdentifier: "goToLifeView", sender: nil)
            })
            break
        case entertainmentButton:
            entertainmentButtonImage.image = UIImage(named: "entertainment_green")
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: { [self] in
                self.entertainmentButtonImage.image = UIImage(named: "entertainment_white")
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
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
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
    }
    
    func styleButton(button: UIButton) {
        button.layer.cornerRadius = 10
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let message = userInfo["b"] as? String
            switch message{
            case "010":
                bookButton?.backgroundColor = UIColor.green;
                break;
                
            case "111":
                musicButton?.backgroundColor = UIColor.green
                performSegue(withIdentifier: "goToMusicView", sender: nil)
                break
                
            case "100":
                tiktokButton?.backgroundColor = UIColor.green
                break
                
            case "011":
                moodButton?.backgroundColor = UIColor.green
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
