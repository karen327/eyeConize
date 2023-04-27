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
    
    @IBOutlet weak var fruitButton: UIButton!
    
    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var drinkButton: UIButton!
    @IBOutlet weak var mealButton: UIButton!
    @IBOutlet weak var milkButton: UIButton!
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
        
        fruitButton.layer.cornerRadius = 10
        drinkButton.layer.cornerRadius = 10
        mealButton.layer.cornerRadius = 10
        milkButton.layer.cornerRadius = 10
        

        
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
