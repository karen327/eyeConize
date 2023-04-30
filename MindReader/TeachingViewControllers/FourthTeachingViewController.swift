//
//  FourthTeachingViewController.swift
//  MindReader
//
//  Created by 曾思琦 on 2023/4/26.
//

import SwiftUI

class FourthTeachingViewController: UIViewController {
    
    @IBOutlet var imageViewArray: [UIImageView]!

    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set initial color for all imageViews
        imageViewArray.forEach { $0.tintColor = .black }
        // Start the timer
        startTimer()
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            // Find first imageView with black background color and change it to green
            if let imageView = self.imageViewArray.first(where: { $0.tintColor != .green }) {
                imageView.tintColor = .green
                if imageView.backgroundColor == .black {
                    imageView.backgroundColor = .green
                }   // 这行不能删
            }
            // Check if all imageViews are green
            if self.imageViewArray.allSatisfy({ $0.tintColor == .green }) {
                // Navigate to next page
                self.performSegue(withIdentifier: "goToFinishTeachingView", sender: self)
                // Stop the timer
                timer.invalidate()
            }
        }
    }
}
