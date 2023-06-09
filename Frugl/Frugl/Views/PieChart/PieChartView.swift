//
//  PieChartView.swift
//  Frugl
//
//  Created by Sebastian Guiscardo on 5/1/23.
//

import UIKit

struct Slice {
    var percent: CGFloat
    var color: UIColor
    var expenseName: String
}

class PieChartView: UIView {
    
    static let ANIMATION_DURATION: CGFloat = 1.4
    
    @IBOutlet var canvasView: UIView!
    
    // MARK: - Outlets Labels
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!
    @IBOutlet var label6: UILabel!
    @IBOutlet var label7: UILabel!
    @IBOutlet var label8: UILabel!
    @IBOutlet var label9: UILabel!
    @IBOutlet var label10: UILabel!
    @IBOutlet var label11: UILabel!
    @IBOutlet var label12: UILabel!
    @IBOutlet var label13: UILabel!
    @IBOutlet var label14: UILabel!
    @IBOutlet var label15: UILabel!
    @IBOutlet var label16: UILabel!
    @IBOutlet var label17: UILabel!
    @IBOutlet var label18: UILabel!
    @IBOutlet var label19: UILabel!
    @IBOutlet var label20: UILabel!
    @IBOutlet var label21: UILabel!
    
    // MARK: - Outlets X
    @IBOutlet var label1XConst: NSLayoutConstraint!
    @IBOutlet var label2XConst: NSLayoutConstraint!
    @IBOutlet var label3XConst: NSLayoutConstraint!
    @IBOutlet var label4XConst: NSLayoutConstraint!
    @IBOutlet var label5XConst: NSLayoutConstraint!
    @IBOutlet var label6XConst: NSLayoutConstraint!
    @IBOutlet var label7XConst: NSLayoutConstraint!
    @IBOutlet var label8XConst: NSLayoutConstraint!
    @IBOutlet var label9XConst: NSLayoutConstraint!
    @IBOutlet var label10XConst: NSLayoutConstraint!
    @IBOutlet var label11XConst: NSLayoutConstraint!
    @IBOutlet var label12XConst: NSLayoutConstraint!
    @IBOutlet var label13XConst: NSLayoutConstraint!
    @IBOutlet var label14XConst: NSLayoutConstraint!
    @IBOutlet var label15XConst: NSLayoutConstraint!
    @IBOutlet var label16XConst: NSLayoutConstraint!
    @IBOutlet var label17XConst: NSLayoutConstraint!
    @IBOutlet var label18XConst: NSLayoutConstraint!
    @IBOutlet var label19XConst: NSLayoutConstraint!
    @IBOutlet var label20XConst: NSLayoutConstraint!
    @IBOutlet var label21XConst: NSLayoutConstraint!
    
    // MARK: - Outlets Y
    @IBOutlet var label1YConst: NSLayoutConstraint!
    @IBOutlet var label2YConst: NSLayoutConstraint!
    @IBOutlet var label3YConst: NSLayoutConstraint!
    @IBOutlet var label4YConst: NSLayoutConstraint!
    @IBOutlet var label5YConst: NSLayoutConstraint!
    @IBOutlet var label6YConst: NSLayoutConstraint!
    @IBOutlet var label7YConst: NSLayoutConstraint!
    @IBOutlet var label8YConst: NSLayoutConstraint!
    @IBOutlet var label9YConst: NSLayoutConstraint!
    @IBOutlet var label10YConst: NSLayoutConstraint!
    @IBOutlet var label11YConst: NSLayoutConstraint!
    @IBOutlet var label12YConst: NSLayoutConstraint!
    @IBOutlet var label13YConst: NSLayoutConstraint!
    @IBOutlet var label14YConst: NSLayoutConstraint!
    @IBOutlet var label15YConst: NSLayoutConstraint!
    @IBOutlet var label16YConst: NSLayoutConstraint!
    @IBOutlet var label17YConst: NSLayoutConstraint!
    @IBOutlet var label18YConst: NSLayoutConstraint!
    @IBOutlet var label19YConst: NSLayoutConstraint!
    @IBOutlet var label20YConst: NSLayoutConstraint!
    @IBOutlet var label21YConst: NSLayoutConstraint!
    
    // MARK: - Properties
    var slices: [Slice]?
    var sliceIndex: Int = 0
    var currentPercent: CGFloat = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let view: UIView = Bundle.main.loadNibNamed("PieChartView", owner: self, options: nil)!.first as! UIView
        addSubview(view)
    }
    
    override func draw(_ rect: CGRect) {
        subviews[0].frame = bounds
    }

    func getDuration(_ slice: Slice) -> CFTimeInterval {
        return CFTimeInterval(slice.percent / 1.0 * PieChartView.ANIMATION_DURATION)
    }

    func percentToRadian(_ percent: CGFloat) -> CGFloat {
        //Because angle starts wtih X positive axis, add 270 degrees to rotate it to Y positive axis.
        var angle = 270 + percent * 360
        if angle >= 360 {
            angle -= 360
        }
        return angle * CGFloat.pi / 180.0
    }

    func addSlice(_ slice: Slice) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = getDuration(slice)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.delegate = self
        
        let canvasWidth = canvasView.frame.width
        let path = UIBezierPath(arcCenter: canvasView.center,
                                radius: canvasWidth * 4 / 8, //changed from 3/8
                                startAngle: percentToRadian(currentPercent),
                                endAngle: percentToRadian(currentPercent + slice.percent),
                                clockwise: true)
        
        let sliceLayer = CAShapeLayer()
        sliceLayer.path = path.cgPath
        sliceLayer.fillColor = nil
        sliceLayer.strokeColor = slice.color.cgColor
        sliceLayer.lineWidth = canvasWidth * 2 / 8
        sliceLayer.strokeEnd = 1
        sliceLayer.add(animation, forKey: animation.keyPath)
        
        canvasView.layer.addSublayer(sliceLayer)
    }
    
    func getLabelCenter(_ fromPercent: CGFloat, _ toPercent: CGFloat) -> CGPoint {
        let radius = canvasView.frame.width * 4 / 8
        let labelAngle = percentToRadian((toPercent - fromPercent) / 2 + fromPercent)
        let path = UIBezierPath(arcCenter: canvasView.center,
                                radius: radius,
                                startAngle: labelAngle,
                                endAngle: labelAngle,
                                clockwise: true)
        path.close()
        return path.currentPoint
    }
    
    func addLabel(_ slice: Slice) {
        let center = canvasView.center
        let labelCenter = getLabelCenter(currentPercent, currentPercent + slice.percent)
        let xConst = [label1XConst, label2XConst, label3XConst, label4XConst, label5XConst, label6XConst, label7XConst, label8XConst, label9XConst, label10XConst, label11XConst, label12XConst, label13XConst, label14XConst, label15XConst, label16XConst, label17XConst, label18XConst, label19XConst, label20XConst, label21XConst][sliceIndex]
        
        let yConst = [label1YConst, label2YConst, label3YConst, label4YConst, label5YConst, label6YConst, label7YConst, label8YConst, label9YConst, label10YConst, label11YConst, label12YConst, label13YConst, label14YConst, label15YConst, label16YConst, label17YConst, label18YConst, label19YConst, label20YConst, label21YConst][sliceIndex]
        xConst?.constant = labelCenter.x - center.x
        yConst?.constant = labelCenter.y - center.y
        canvasView.superview?.setNeedsUpdateConstraints()
        canvasView.superview?.layoutIfNeeded()
        
        let label = [label1, label2, label3, label4, label5, label6, label7, label8, label9, label10, label11, label12, label13, label14, label15, label16, label17, label18, label19, label20, label21][sliceIndex]
        label?.isHidden = false //changed from true
        label?.text = String(format: "%d%%", Int(slice.percent * 100))
    }
    
    func animateChart() {
        resetLabels()
        sliceIndex = 0
        currentPercent = 0.0
        canvasView.layer.sublayers = nil

        if slices != nil && slices!.count > 0 {
            let firstSlice = slices![0]
            addSlice(firstSlice)
            addLabel(firstSlice)
        }
    }
    
    func resetLabels() {
        label1.text = nil
        label2.text = nil
        label3.text = nil
        label4.text = nil
        label5.text = nil
        label6.text = nil
        label7.text = nil
        label8.text = nil
        label9.text = nil
        label10.text = nil
        label11.text = nil
        label12.text = nil
        label13.text = nil
        label14.text = nil
        label15.text = nil
        label16.text = nil
        label17.text = nil
        label18.text = nil
        label19.text = nil
        label20.text = nil
        label21.text = nil
    }
}

extension PieChartView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            currentPercent += slices![sliceIndex].percent
            sliceIndex += 1
            if sliceIndex < slices!.count {
                let nextSlice = slices![sliceIndex]
                addLabel(nextSlice)
                addSlice(nextSlice)
            } else {
                //After animation is done, display all labels. Can be animated.
                for label in [label1, label2, label3, label4, label5, label6, label7, label8, label9, label10, label11, label12, label13, label14, label15, label16, label17, label18, label19, label20, label21] {
                    label?.isHidden = false
                }
            }
        }
    }
}
