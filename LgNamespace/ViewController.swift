//
//  ViewController.swift
//  LgNamespace
//
//  Created by Guang Lei on 2020/4/2.
//  Copyright © 2020 Guang Lei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = UIViewController()
        vc.view.backgroundColor = .cyan
        self.lg.present(vc, animated: true)
    }
}

