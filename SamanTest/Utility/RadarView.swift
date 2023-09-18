//
//  RadarView.swift
//  SamanTest
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import UIKit

@IBDesignable
public class RadarView: UIView {
    
    /// The circle's fill color
    @IBInspectable
    public var circleFillColor: UIColor = .red {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// The circle's border (stroke) color
    @IBInspectable
    public var circleBorderColor: UIColor = .red {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// The center point color
    @IBInspectable
    public var centerPointColor: UIColor = .red {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// The radius line color
    @IBInspectable
    public var radiusLineColor: UIColor = .red {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    private var circleShape: CAShapeLayer?
    private var radiusLineShape: CAShapeLayer?
    private var centerPoint: CGPoint {
        return CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
    }
    
    // MARK: - UIView
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // Big Circle
        let circleSize = min(self.bounds.width, self.bounds.height)
        let borderWidth: CGFloat = 1
        let circlePath = UIBezierPath.circlePathWithCenter(center: self.centerPoint, diameter: circleSize - 2*borderWidth, borderWidth: borderWidth)
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        circleShape.fillColor = self.circleFillColor.withAlphaComponent(0.0).cgColor
        circleShape.strokeColor = self.circleBorderColor.cgColor
        self.layer.addSublayer(circleShape)
        self.circleShape = circleShape
        
        // Center point circle
        let centerPointPath = UIBezierPath.circlePathWithCenter(center: self.centerPoint, diameter: 4, borderWidth: 0)
        let pointShape = CAShapeLayer()
        pointShape.path = centerPointPath.cgPath
        pointShape.fillColor = self.centerPointColor.cgColor
        circleShape.addSublayer(pointShape)
        
        // Radius line
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: circleSize/2, y: circleSize/2))
        linePath.addLine(to: CGPoint(x: circleSize/2, y: 0))
        
        let radiusLineShape = CAShapeLayer()
        radiusLineShape.frame = CGRect(x: self.centerPoint.x-circleSize/2, y: 0, width: circleSize, height: circleSize)
        radiusLineShape.path = linePath.cgPath
        radiusLineShape.strokeColor = self.radiusLineColor.cgColor
        radiusLineShape.lineWidth = 1
        circleShape.addSublayer(radiusLineShape)
        self.radiusLineShape = radiusLineShape
        
        // Radius line animation
        let circleAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        circleAnimation.fromValue =  0
        circleAnimation.toValue = 2 * Double.pi
        circleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        circleAnimation.duration = 2
        circleAnimation.repeatCount = Float.infinity
        circleAnimation.isRemovedOnCompletion = false
        radiusLineShape.add(circleAnimation, forKey: nil)
        
    }

}

// MARK: - Extension

extension UIBezierPath {
    class func circlePathWithCenter(center: CGPoint, diameter: CGFloat, borderWidth: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(arcCenter: center, radius: diameter/2, startAngle: 0, endAngle: 2*CGFloat(Double.pi), clockwise: true)
        path.lineWidth = borderWidth
        return path
    }
}

extension CGFloat {
    static func random(lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
}

