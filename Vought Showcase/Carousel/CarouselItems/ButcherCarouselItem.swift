//
//  ButcherCarouselItem.swift
//  Vought Showcase
//
//  Created for The Boys story viewer assignment
//

import UIKit

final class ButcherCarouselItem: CarouselItem {
    private var viewController: UIViewController?
    
    func getController() -> UIViewController {
        guard let viewController = viewController else {
            viewController = ImageViewController(imageName: "butcher")
            return viewController!
        }
        return viewController
    }
} 