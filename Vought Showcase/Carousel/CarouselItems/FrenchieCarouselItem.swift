//
//  FrenchieCarouselItem.swift
//  Vought Showcase
//
//  Created for The Boys story viewer assignment
//

import UIKit

final class FrenchieCarouselItem: CarouselItem {
    private var viewController: UIViewController?
    
    func getController() -> UIViewController {
        guard let viewController = viewController else {
            viewController = ImageViewController(imageName: "frenchie")
            return viewController!
        }
        return viewController
    }
} 