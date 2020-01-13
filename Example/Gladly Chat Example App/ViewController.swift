//
//  ViewController.swift
//  Gladly Chat Example App
//
//  Copyright © 2019 Gladly. All rights reserved.
//

import UIKit
import GladlySidekick

class ViewController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.text = "Chat SDK version: " + Gladly.version
    }

    @IBAction func showChat(_ sender: Any) {
        do {
            try Gladly.showChat()
        } catch {
            print("something went wrong when calling showChat: \(error)")
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        Gladly.logout()
    }
}

