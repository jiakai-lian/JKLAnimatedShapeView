//
//  JKLAnimatedViewTrapeziumExtension.swift
//  Pods
//
//  Created by jiakai lian on 9/04/2016.
//
//

import Foundation

extension JKLAnimatedShapeView {

    public func animateToTrapeziumShape(draggedDownLength: CGFloat = 20.0,
                                        maxDraggedDownLength: CGFloat = 30.0,
                                        duration: NSTimeInterval = 0.25,
                                        delay: NSTimeInterval = 0.2,
                                        completionBlock: (() -> Void)?) {

        let animation = CAKeyframeAnimation(keyPath: animationkeyPath)

        animation.values = [beginShape(self.bounds),
                            midShape(self.bounds, draggedDownLength: maxDraggedDownLength),
                            endShape(self.bounds, draggedDownLength: draggedDownLength)]
        animation.keyTimes = [0, 4 / 5, 1]

        animation.duration = duration
        animation.beginTime = CACurrentMediaTime() + delay
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        animateToShape(animation, completionBlock: completionBlock)
    }

    private func beginShape(rect: CGRect) -> CGPath {

        return UIBezierPath(rect: rect).CGPath
    }

    private func endShape(rect: CGRect, draggedDownLength: CGFloat) -> CGPath {

        return trapeziumPath(rect, draggedDownLength: draggedDownLength)
    }

    private func midShape(rect: CGRect, draggedDownLength: CGFloat) -> CGPath {

        return trapeziumPath(rect, draggedDownLength: draggedDownLength)
    }

    private func trapeziumPath(rect: CGRect, draggedDownLength: CGFloat) -> CGPath {

        let path = CGPathCreateMutable()

        CGPathMoveToPoint(path, nil, rect.origin.x, rect.origin.y)
        CGPathAddLineToPoint(path, nil, rect.origin.x + rect.size.width, rect.origin.y)
        CGPathAddLineToPoint(path, nil, rect.origin.x + rect.size.width,
                             rect.origin.y + rect.size.height + draggedDownLength)
        CGPathAddLineToPoint(path, nil, rect.origin.x, rect.origin.y + rect.size.height)
        CGPathCloseSubpath(path)
        return path
    }
}
