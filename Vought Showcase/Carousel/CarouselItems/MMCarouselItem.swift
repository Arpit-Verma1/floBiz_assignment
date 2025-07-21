//
//  MMCarouselItem.swift
//  Vought Showcase
//
//  Created for The Boys story viewer assignment
//

import UIKit

final class MMCarouselItem: CarouselItem {
    private var viewController: UIViewController?
    
    func getController() -> UIViewController {
        guard let viewController = viewController else {
            viewController = ImageViewController(imageName: "mm")
            return viewController!
        }
        return viewController
    }
} 