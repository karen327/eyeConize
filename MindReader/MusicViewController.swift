//
//  MusicViewController.swift
//  MindReader
//
//  Created by 曾思琦 on 2023/4/26.
//

import UIKit

class MusicViewController: UIViewController {
    
    @IBOutlet weak var inputStackView: UIStackView!
    
    @IBOutlet weak var lastSongButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var nextSongButton: UIButton!
    
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
        
        lastSongButton.layer.cornerRadius = 10
        pauseButton.layer.cornerRadius = 10
        nextSongButton.layer.cornerRadius = 10
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
