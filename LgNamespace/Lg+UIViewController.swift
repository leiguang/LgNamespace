//
//  Lg+UIViewController.swift
//  LgNamespace
//
//  Created by Guang Lei on 2020/4/2.
//  Copyright © 2020 Guang Lei. All rights reserved.
//
import UIKit

extension LgWrapper where Base: UIViewController {
    func present(_ viewController: UIViewController, presentationStyle: UIModalPresentationStyle = .fullScreen, animated: Bool, completion: (() -> Void)? = nil) {
        if viewController.modalPresentationStyle == .pageSheet {
            viewController.modalPresentationStyle = presentationStyle
        }

        base.present(viewController, animated: animated, completion: completion)
    }
}

