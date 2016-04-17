//
// Created by jiakai lian on 9/04/2016.
//

import Foundation

public class JKLAnimatedShapeView: UIView {
    private let animatedLayer: CAShapeLayer = CAShapeLayer()
    let animationkeyPath = "path"

    override public func layoutSubviews() {

        animatedLayer.path = UIBezierPath(rect: self.bounds).CGPath
        animatedLayer.fillColor = self.backgroundColor?.CGColor
    }

    override public func didMoveToWindow() {

        self.layer.insertSublayer(self.animatedLayer, atIndex: 0)
    }

    func animateToShape(animation: CAAnimation, completionBlock: (() -> Void)?) {

        CATransaction.begin();

        CATransaction.setCompletionBlock(completionBlock)
        animatedLayer.addAnimation(animation, forKey: nil)

        CATransaction.commit()
    }

    public func animateToShape(animation: JKLShapeAnimation, completionBlock: (() -> Void)?) {

        self.animateToShape(animation.animation(self.bounds), completionBlock: completionBlock)
    }
}


