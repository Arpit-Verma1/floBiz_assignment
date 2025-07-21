import UIKit

class BottomUpPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let containerBounds = containerView.bounds
        return CGRect(x: 0, y: 0, width: containerBounds.width, height: containerBounds.height)
    }

    override func presentationTransitionWillBegin() {
        presentedView?.frame = frameOfPresentedViewInContainerView
        presentedView?.layer.cornerRadius = 20
        presentedView?.clipsToBounds = true
        presentedView?.transform = CGAffineTransform(translationX: 0, y: containerView!.bounds.height)
        containerView?.addSubview(presentedView!)
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut, animations: {
            self.presentedView?.transform = .identity
        }, completion: nil)
    }

    override func dismissalTransitionWillBegin() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.presentedView?.transform = CGAffineTransform(translationX: 0, y: self.containerView!.bounds.height)
        }, completion: { _ in
            self.presentedView?.removeFromSuperview()
        })
    }
} 