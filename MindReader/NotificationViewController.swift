//
//  NotificationViewController.swift
//  MindReader
//
//  Created by 曾思琦 on 2023/4/26.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    @IBAction func touchButton(_ sender: UIButton) {
        sender.backgroundColor = UIColor.green
        DispatchQueue.main.asyncAfter(deadline: .now()+0.7, execute: {
            sender.backgroundColor = UIColor.white
        })
        // 发送数据的代码
        // 显示发送成功的弹窗
        let alert = UIAlertController(title: "发送成功", message: nil, preferredStyle: .alert)
        present(alert, animated: true)

        // 2秒后隐藏弹窗
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            alert.dismiss(animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        TimeManager.shared.startTimer()
        
        acceptButton.layer.cornerRadius = 10
        rejectButton.layer.cornerRadius = 10
    }
}
