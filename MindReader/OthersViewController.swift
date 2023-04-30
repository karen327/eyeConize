//
//  OthersViewController.swift
//  MindReader
//
//  Created by 曾思琦 on 2023/4/28.
//

import SwiftUI

class OthersViewController: UIViewController {
    
    @IBOutlet weak var lifeButton: UIButton!
    @IBOutlet weak var entertainmentButton: UIButton!
    @IBOutlet weak var othersButton: UIButton!
    
    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var textButton:UIButton!
    @IBOutlet weak var phraseButton:UIButton!
    @IBOutlet weak var airButton:UIButton!
    @IBOutlet weak var lightButton:UIButton!
    
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
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                self.performSegue(withIdentifier: "goToEntertainmentView", sender: nil)
            })
            break
        case othersButton:
            othersButtonImage.image = UIImage(named: "others_green")
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: { [self] in
                    self.othersButtonImage.image = UIImage(named: "others_white")
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
        
        textButton.layer.cornerRadius = 10
        phraseButton.layer.cornerRadius = 10
        airButton.layer.cornerRadius = 10
        lightButton.layer.cornerRadius = 10
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let message = userInfo["b"] as? String
            switch message{
            case "001":
                textButton?.backgroundColor = UIColor.green
                break;

            case "110":
                phraseButton?.backgroundColor = UIColor.green
                break

            case "111":
                airButton?.backgroundColor = UIColor.green
                break

            case "101":
                lightButton?.backgroundColor = UIColor.green
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

