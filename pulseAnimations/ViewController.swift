//
//  ViewController.swift
//  pulseAnimations
//
//  Created by Grace Njoroge on 07/01/2019.
//  Copyright © 2019 Incentro Africa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var appleImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "location")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    var pulseLayersArray = [CAShapeLayer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
   
        view.addSubview(containerView)
        containerView.addSubview(appleImage)
        
        //hides navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        //constraints for image view
        containerView.layer.cornerRadius = containerView.frame.size.width/2.0
        
        //appleImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        appleImage.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        appleImage.heightAnchor.constraint(equalToConstant: 49).isActive = true
        appleImage.widthAnchor.constraint(equalToConstant: 38).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        //create pulse
        createPulse()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.animatePulse(index: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                self.animatePulse(index: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.animatePulse(index: 2)
                })
            })
        })

        
    }
    
    func createPulse() {
        for _ in 0...2 {
            let circularPath = UIBezierPath(arcCenter: .zero, radius: UIScreen.main.bounds.size.width/2.0, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
            let pulseLayer = CAShapeLayer()
            pulseLayer.path = circularPath.cgPath
            pulseLayer.lineWidth = 2.0
            pulseLayer.fillColor = UIColor.clear.cgColor
            pulseLayer.lineCap = CAShapeLayerLineCap.round
            //the numbers(19 & 24.5) are from height and width of location icon divided by 2
            pulseLayer.position = CGPoint(x: appleImage.frame.origin.x + 19, y: appleImage.frame.origin.y + 24.5)
            containerView.layer.addSublayer(pulseLayer)
            pulseLayersArray.append(pulseLayer)
        }
    }

    func animatePulse(index: Int) {
        
        pulseLayersArray[index].strokeColor = UIColor.white.cgColor
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 2.0
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 0.9
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayersArray[index].add(scaleAnimation, forKey: "scale")
        
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.duration = 2.0
        opacityAnimation.fromValue = 0.9
        opacityAnimation.toValue = 0.0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayersArray[index].add(opacityAnimation, forKey: "opacity")
        
        
        
    }
    
    


}

