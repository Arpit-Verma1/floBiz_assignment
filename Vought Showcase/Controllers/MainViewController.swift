//
//  ViewController.swift
//  Vought Showcase
//
//  Created by Burhanuddin Rampurawala on 06/08/24.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Show the main carousel in the background
        initCarouselView()
        // Add the button to show the modal stories
        setupShowStoriesButton()
    }
    
    private func initCarouselView() {
        let carouselItemProvider = CarouselItemDataSourceProvider()
        let carouselViewController = CarouselViewController(items: carouselItemProvider.items(), shouldLoop: true)
        add(asChildViewController: carouselViewController, containerView: containerView)
    }
    
    private func setupShowStoriesButton() {
        let button = UIButton(type: .system)
        button.setTitle("Show Stories", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showStoriesTapped), for: .touchUpInside)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    @objc private func showStoriesTapped() {
        let carouselItemProvider = CarouselItemDataSourceProvider()
        let carouselViewController = CarouselViewController(items: carouselItemProvider.items(), shouldLoop: false)
        carouselViewController.modalPresentationStyle = .custom
        carouselViewController.transitioningDelegate = self
        present(carouselViewController, animated: true, completion: nil)
    }
}

// MARK: UIViewControllerTransitioningDelegate
extension MainViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BottomUpPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

