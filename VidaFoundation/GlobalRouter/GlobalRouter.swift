//
//  GlobalRouter.swift
//  VidaFoundation
//
//  Created by Alexandre Laurin on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation
import UIKit

public var SharedGlobalRouter: Router {
    struct Singleton {
        static let instance = GlobalRouter()
    }
    return Singleton.instance
}

public protocol Router {

    // Register consumers for URLs
    func registerRendererClass(_ consumer: AnyClass, URLPath: String)

    func rendererForURLPath(_ URLPath: String) -> UIViewController?

}

class GlobalRouter: Router {

    fileprivate var rendererURLMap = [String: AnyClass]() // URL -> rendererClass

    func registerRendererClass(_ rendererClass: AnyClass, URLPath: String) {
        rendererURLMap[URLPath] = rendererClass
    }

    func rendererForURLPath(_ URLPath: String) -> UIViewController? {
        guard let rendererClass = rendererURLMap[URLPath] as? UIViewController.Type else {
            errorLog("Unable find renderer for URL: \(URLPath)")
            return nil
        }

        return rendererClass.init()
    }
}
