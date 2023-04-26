//
//  CapsuleView.swift
//  MindReader
//
//  Created by 曾思琦 on 2023/4/26.
//

import SwiftUI

class CapsuleView: UIView {
    override func draw(_ rect: CGRect) {
        // 设置视图背景颜色
        self.backgroundColor = UIColor.blue

        let cornerRadius = min(rect.width, rect.height) / 2.0
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        UIColor.black.setFill()
        path.fill()
    }
}
