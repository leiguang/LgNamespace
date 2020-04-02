//
//  Lg.swift
//  LgNamespace
//
//  Created by Guang Lei on 2020/4/2.
//  Copyright © 2020 Guang Lei. All rights reserved.
//

public struct LgWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol LgCompatible {}

extension LgCompatible {
    public var lg: LgWrapper<Self> {
        get { return LgWrapper(self) }
        set {}
    }
}

import UIKit

/// Including:
/// - present(_:) with "UIModalPresentationStyle = .fullScreen"
extension UIViewController: LgCompatible {}


///// Including:
///// - pull to refresh
//extension UIScrollView: LgCompatible {}
