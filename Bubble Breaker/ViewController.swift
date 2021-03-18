//
//  ViewController.swift
//  Bubble Breaker
//
//  Created by Oleg on 2/9/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let canvas = Canvas(frame: view.safeAreaLayoutGuide.layoutFrame)
        view.addSubview(canvas)
        canvas.translatesAutoresizingMaskIntoConstraints = false
        canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        canvas.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        canvas.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    
}


