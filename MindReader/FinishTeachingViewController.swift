//
//  FinishTeachingViewController.swift
//  MindReader
//
//  Created by 曾思琦 on 2023/4/26.
//

import SwiftUI

class FinishTeachingViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Delay for 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            // Navigate to next page
            self.performSegue(withIdentifier: "goToLifeView", sender: self)
        }
    }
}
