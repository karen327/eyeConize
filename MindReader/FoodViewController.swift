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
