//
//  TimeViewController.swift
//  MindReader
//
//  Created by 曾思琦 on 2023/4/25.
//

import UIKit

class TimeViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    func updateTime() {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current // 使用用户的本地时区
        formatter.dateFormat = "HH:mm" // 设置时间格式
        let timeString = formatter.string(from: Date())
        timeLabel.text = timeString // 更新Label的文本
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 定期更新Label的文本
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateTime()
        }
        timer.fire() // 立即更新一次Label的文本
    }
}

