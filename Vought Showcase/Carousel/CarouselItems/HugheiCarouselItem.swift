//
//  HugheiCarouselItem.swift
//  Vought Showcase
//
//  Created for The Boys story viewer assignment
//

import UIKit

final class HugheiCarouselItem: CarouselItem {
    private var viewController: UIViewController?
    
    func getController() -> UIViewController {
        guard let viewController = viewController else {
            viewController = ImageViewController(imageName: "hughei")
            return viewController!
        }
        return viewController
    }
} 