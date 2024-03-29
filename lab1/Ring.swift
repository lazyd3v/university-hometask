//
//  Ring.swift
//  lab1
//
//  Created by Roman Faizullin on 16/10/2016.
//  Copyright © 2016 Roman Faizullin. All rights reserved.
//

import AppKit

fileprivate struct ringDefaults {
    static let r1:CGFloat = 25.0
    static let r2:CGFloat = 20.0
}

class Ring: Figure {
    var layer = CAShapeLayer()
    var center: CGPoint = CGPoint() {
        didSet {
            layer.position = CGPoint(x: center.x - outerRadius, y: center.y - outerRadius)
        }
    }
    var outerRadius: CGFloat = 0.0 {
        didSet {
            redrawRing()
        }
    }
    var innerRadius: CGFloat = 0.0 {
        didSet {
            redrawRing()
        }
    }
    
    init () {
        innerRadius = ringDefaults.r1
        outerRadius = ringDefaults.r2
        
        let frameWidth = outerRadius * 2
        let frameHeight = frameWidth
        let zeroPoint = generatePoint(frameWidth, frameHeight)
        
        layer.frame = CGRect(x: zeroPoint.x, y: zeroPoint.y, width: frameWidth, height: frameHeight)
        layer.lineWidth = 3.0
        layer.fillColor = nil
        layer.path = CGPath(ellipseIn: layer.frame, transform: nil)
        layer.isHidden = true
        
        center = CGPoint(x: zeroPoint.x + outerRadius, y: zeroPoint.y + outerRadius)
        
        setRandomColor()
    }
    
    convenience init (x: CGFloat, y: CGFloat, visible: Bool) {
        self.init()
        layer.isHidden = !visible
        
        innerRadius = ringDefaults.r1
        outerRadius = ringDefaults.r2
        let frameWidth = outerRadius * 2
        let frameHeight = frameWidth
        
        layer.frame = CGRect(x: x, y: y, width: frameWidth, height: frameHeight)
        layer.path = CGPath(ellipseIn: layer.frame, transform: nil)
    }
    
    func setRandomColor () {
        layer.fillColor = nil
        layer.strokeColor = self.generateRandomColor()
    }
    
    func show () {
        layer.isHidden = false
    }
    
    private func redrawRing () {
        layer.frame.size = CGSize(width: outerRadius * 2, height: outerRadius * 2)
        layer.path = CGPath(ellipseIn: layer.frame, transform: nil)
        layer.lineWidth = outerRadius - innerRadius
    }
}

extension Ring: FigureUtils {}
