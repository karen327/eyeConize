//
//  TimeManager.swift
//  MindReader
//
//  Created by 曾思琦 on 2023/4/25.
//

import Foundation

class TimeManager {
    static let shared = TimeManager() // 单例实例
    
    private var timer: Timer? // 定时器实例
    
    // 添加一个监听器数组
    private var listeners: [() -> Void] = []
    
    // 获取当前时间的方法
    func currentTime() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: Date())
        return timeString
    }
    
    // 添加一个监听器
    func addListener(listener: @escaping () -> Void) {
        listeners.append(listener)
    }

    func removeListener(listener: @escaping () -> Void) {
        if let index = listeners.firstIndex(where: { $0() == listener() }) {
            listeners.remove(at: index)
        }
    }
    
    // 启动定时器并通知监听器
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.notifyListeners()
        }
        timer?.fire()
    }
    
    // 停止定时器
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // 通知所有监听器更新时间
    private func notifyListeners() {
        for listener in listeners {
            listener()
        }
    }
}
