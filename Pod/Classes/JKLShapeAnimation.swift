//
// Created by jiakai lian on 17/04/2016.
//

import Foundation

public protocol JKLShapeAnimation {
    func animation(originalRect: CGRect!) -> CAAnimation
}


public struct JKLShapeAnimationRectToTrapezium: JKLShapeAnimation {

    let draggedDownLength:    CGFloat
    let maxDraggedDownLength: CGFloat
    let duration:             NSTimeInterval
    let delay:                NSTimeInterval
    let keyTimes:             Array<NSNumber>
    let animationkeyPath = "path"

    public init(draggedDownLength: CGFloat = 20.0,
                maxDraggedDownLength: CGFloat = 30.0,
                duration: NSTimeInterval = 0.3,
                delay: NSTimeInterval = 0.2,
                keyTimes: Array<NSNumber> = [0.0, 4.0 / 5.0, 1.0]) {
        self.draggedDownLength = draggedDownLength
        self.maxDraggedDownLength = maxDraggedDownLength
        self.duration = duration
        self.delay = delay
        self.keyTimes = keyTimes
    }

    public func animation(originalRect: CGRect!) -> CAAnimation {

        let animation = CAKeyframeAnimation(keyPath: self.animationkeyPath)

        animation.values = [beginShape(originalRect),
                            midShape(originalRect, draggedDownLength: self.maxDraggedDownLength),
                            endShape(originalRect, draggedDownLength: self.draggedDownLength)]
        animation.keyTimes = self.keyTimes

        animation.duration = self.duration
        animation.beginTime = CACurrentMediaTime() + self.delay
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false

        return animation
    }

    private func beginShape(rect: CGRect!) -> CGPath {

        return UIBezierPath(rect: rect).CGPath
    }

    private func endShape(rect: CGRect!, draggedDownLength: CGFloat!) -> CGPath {

        return trapeziumPath(rect, draggedDownLength: draggedDownLength)
    }

    private func midShape(rect: CGRect!, draggedDownLength: CGFloat!) -> CGPath {

        return trapeziumPath(rect, draggedDownLength: draggedDownLength)
    }

    private func trapeziumPath(rect: CGRect!, draggedDownLength: CGFloat!) -> CGPath {

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