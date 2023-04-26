//
//  TimeLabel.swift
//  MindReader
//
//  Created by 曾思琦 on 2023/4/25.
//

import UIKit

class TimeLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 添加监听器，更新Label的文本
        TimeManager.shared.addListener {
            let currentTime = TimeManager.shared.currentTime()
            DispatchQueue.main.async {
                self.text = currentTime
            }
        }
    }
    
    deinit {
        TimeManager.shared.removeListener(listener: self.updateTime)
    }

    private func updateTime() {
        let currentTime = TimeManager.shared.currentTime()
        DispatchQueue.main.async {
            self.text = currentTime
        }
    }
}
