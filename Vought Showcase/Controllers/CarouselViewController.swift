//
//  CarouselViewController.swift
//  Vought Showcase
//
//  Created by Burhanuddin Rampurawala on 06/08/24.
//

import Foundation
import UIKit
import SnapKit


final class CarouselViewController: UIViewController {
    
    /// Container view for the carousel
    @IBOutlet private weak var containerView: UIView!
    
    private var progressBar: SegmentedProgressBar!

    /// Page view controller for carousel
    private var pageViewController: UIPageViewController?
    
    /// Carousel items
    private var items: [CarouselItem] = []
    
    /// Current item index
    private var currentItemIndex: Int = 0 {
        didSet {
            // Update progress bar if needed
        }
    }

    var shouldLoop: Bool = true

    /// Initializer
    /// - Parameter items: Carousel items
    public init(items: [CarouselItem], shouldLoop: Bool = true) {
        self.items = items
        self.shouldLoop = shouldLoop
        super.init(nibName: "CarouselViewController", bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFullScreen()
        setupProgressBar()
        initPageViewController()
        setupTapGestures()
        setupSwipeToDismiss()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            startStory()
    }

    private func setupFullScreen() {
        self.modalPresentationCapturesStatusBarAppearance = true
        self.setNeedsStatusBarAppearanceUpdate()
        self.view.backgroundColor = .red
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setupProgressBar() {
        progressBar = SegmentedProgressBar(numberOfSegments: items.count, duration: 3.0)
        progressBar.delegate = self
        progressBar.topColor = .white
        progressBar.bottomColor = .gray
        progressBar.backgroundColor = .clear
        
        
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(6)
        }
    
        view.bringSubviewToFront(progressBar)
    }

    private func setupTapGestures() {
        let leftTap = UITapGestureRecognizer(target: self, action: #selector(handleLeftTap))
        let rightTap = UITapGestureRecognizer(target: self, action: #selector(handleRightTap))
        let leftView = UIView()
        let rightView = UIView()
        leftView.backgroundColor = .clear
        rightView.backgroundColor = .clear
        view.addSubview(leftView)
        view.addSubview(rightView)
        leftView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.3)
        }
        rightView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.3)
        }
        leftView.addGestureRecognizer(leftTap)
        rightView.addGestureRecognizer(rightTap)
        // Ensure progress bar is always on top
        if let progressBar = self.progressBar {
            view.bringSubviewToFront(progressBar)
        }
    }

    private func setupSwipeToDismiss() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }

    @objc private func handleSwipeDown() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func handleLeftTap() {
        progressBar.rewind()
    }

    @objc private func handleRightTap() {
        progressBar.skip()
    }

    private func startStory() {
        progressBar.startAnimation()
    }

    /// Initialize page view controller
    private func initPageViewController() {

        // Create pageViewController
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal,
        options: nil)

        // Set up pageViewController
        pageViewController?.dataSource = nil // Disable swipe
        pageViewController?.delegate = self
        pageViewController?.setViewControllers(
            [getController(at: currentItemIndex)], direction: .forward, animated: true)

        guard let theController = pageViewController else {
            return
        }
        
        // Add pageViewController in container view
        add(asChildViewController: theController,
            containerView: containerView)
        // Ensure the pageViewController's view fills the containerView
        theController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            theController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            theController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            theController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            theController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

    /// Get controller at index
    /// - Parameter index: Index of the controller
    /// - Returns: UIViewController
    private func getController(at index: Int) -> UIViewController {
        return items[index].getController()
    }

}

// MARK: SegmentedProgressBarDelegate
extension CarouselViewController: SegmentedProgressBarDelegate {
    func segmentedProgressBarChangedIndex(index: Int) {
        let direction: UIPageViewController.NavigationDirection = index > currentItemIndex ? .forward : .reverse
        let controller = getController(at: index)
        pageViewController?.setViewControllers([controller], direction: direction, animated: true, completion: nil)
        currentItemIndex = index
    }
    func segmentedProgressBarFinished() {
        if shouldLoop {
            currentItemIndex = 0
            let controller = getController(at: 0)
            pageViewController?.setViewControllers([controller], direction: .forward, animated: true, completion: nil)
            progressBar.startAnimation()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: UIPageViewControllerDelegate methods
extension CarouselViewController: UIPageViewControllerDelegate {
    
    /// Page view controller did finish animating
    /// - Parameters:
    /// - pageViewController: UIPageViewController
    /// - finished: Bool
    /// - previousViewControllers: [UIViewController]
    /// - completed: Bool
    public func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = items.firstIndex(where: { $0.getController() == visibleViewController }){
                currentItemIndex = index
            }
        }
}
