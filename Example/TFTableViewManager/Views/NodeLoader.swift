//
//  NodeLoader.swift
//  NodeLoader
//
//  Created by Melvin on 2018/8/21.
//  Copyright © 2018 Timeface. All rights reserved.
//

import Foundation
import UIKit




@objc public protocol NodeLoadable
{
    
    @objc optional func nl_visibleContentNodes()->[ASDisplayNode]
    @objc optional func nl_visibleContentViews()->[UIView]

}

@objc extension ASTableNode : NodeLoadable
{
    public func nl_visibleContentNodes()->[ASDisplayNode]
    {
        let nodesArray = NSMutableArray.init()
        for node in self.visibleNodes {
            for childNode in node.subnodes! {
                if !childNode.isLayerBacked {
                    nodesArray.add(childNode)
                }
            }
        }
        return nodesArray as! [ASDisplayNode]
    }
}

@objc extension UITableView : NodeLoadable
{
    public func nl_visibleContentViews()->[UIView]
    {
        return (self.visibleCells as NSArray).value(forKey: "contentView") as! [UIView]
    }
}

@objc extension ASDisplayNode
{
    public func showLoader(){
        self.isUserInteractionEnabled = false
        if self is ASTableNode{
            NodeLoader.addLoaderTo(self as! ASTableNode)
        }else if self is ASCollectionNode{
            NodeLoader.addLoaderTo(self as! ASCollectionNode)
        }else{
            NodeLoader.addLoaderToNodes([self])
        }
    }
    
    public func hideLoader(){
        self.isUserInteractionEnabled = true
        if self is ASTableNode{
            NodeLoader.removeLoaderFrom(self as! ASTableNode)
        }else if self is ASCollectionNode{
            NodeLoader.removeLoaderFrom(self as! ASCollectionNode)
        }else{
            NodeLoader.removeLoaderFromNodes([self])
        }
    }
}



@objc extension ASCollectionNode : NodeLoadable
{
    public func nl_visibleContentNodes()->[ASDisplayNode]
    {
        return (self.visibleNodes as NSArray).value(forKey: "contentNode") as! [ASDisplayNode]
    }
}



@objc extension UIColor {
    static func backgroundFadedGrey()->UIColor
    {
        return UIColor(red: (246.0/255.0), green: (247.0/255.0), blue: (248.0/255.0), alpha: 1)
    }
    
    static func gradientFirstStop()->UIColor
    {
        return  UIColor(red: (238.0/255.0), green: (238.0/255.0), blue: (238.0/255.0), alpha: 1.0)
    }
    
    static func gradientSecondStop()->UIColor
    {
        return UIColor(red: (221.0/255.0), green: (221.0/255.0), blue:(221.0/255.0) , alpha: 1.0);
    }
}

@objc extension UIView {
    func boundInside(_ superView: UIView){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics:nil, views:["subview":self]))
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics:nil, views:["subview":self]))
    }
}

extension CGFloat
{
    func doubleValue()->Double
    {
        return Double(self)
    }
}



@objc open class NodeLoader: NSObject
{
    //for asdiaplaynode
    static func addLoaderToNodes(_ nodes : [ASDisplayNode])
    {
        CATransaction.begin()
        nodes.forEach { $0.nl_addLoader() }
        CATransaction.commit()
    }
    
    static func removeLoaderFromNodes(_ nodes: [ASDisplayNode])
    {
        CATransaction.begin()
        nodes.forEach { $0.nl_removeLoader() }
        CATransaction.commit()
    }
    
    public static func addLoaderTo(_ list : NodeLoadable )
    {
        self.addLoaderToNodes(list.nl_visibleContentNodes!())
    }
    
    
    public static func removeLoaderFrom(_ list : NodeLoadable )
    {
        self.removeLoaderFromNodes(list.nl_visibleContentNodes!())
    }
    
    
    
    //for uiview
   
    
}

@objc class CutoutView : UIView
{
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(self.bounds)
        
        for view in (self.superview?.subviews)! {
            
            if view != self {
                context?.setBlendMode(.clear);
                let rect = view.frame
                let clipPath: CGPath = UIBezierPath(roundedRect: rect, cornerRadius: view.layer.cornerRadius).cgPath
                context?.addPath(clipPath)
                context?.setFillColor(UIColor.clear.cgColor)
                context?.closePath()
                context?.fillPath()
            }
        }
    }
    
    
    override func layoutSubviews() {
        self.setNeedsDisplay()
//        (self.visibleNodes as NSArray)
        
//        (self.superview as ASDisplayNode)?.nl_getGradient()?.frame = (self.superview?.bounds)!
        self.superview?.nl_getGradient()?.frame = (self.superview?.bounds)!
        
    }
}

@objc class CutoutNode : ASDisplayNode
{
    let cutoutView = CutoutView()
    override init() {
        super.init()
        addSubnode(ASDisplayNode.init(viewBlock: { () -> UIView in
            return self.cutoutView
        }))
    }
    
    func updateLayout() {
        cutoutView.setNeedsDisplay()
//        cutoutView.boundInside((self.supernode?.view)!)
    }

//    override class func draw(_ bounds: CGRect, withParameters parameters: Any?, isCancelled isCancelledBlock: () -> Bool, isRasterizing: Bool){
//
//        super.draw(bounds, withParameters: parameters, isCancelled: isCancelledBlock, isRasterizing: isRasterizing)
//    }
}

// TODO :- Allow caller to tweak these

var cutoutHandle: UInt8         = 0
var gradientHandle: UInt8       = 0
var loaderDuration              = 0.85
var gradientWidth               = 0.17
var gradientFirstStop           = 0.1



@objc extension ASDisplayNode
{
    fileprivate func nl_getCutoutNode()->ASDisplayNode?
    {
        return objc_getAssociatedObject(self, &cutoutHandle) as! ASDisplayNode?
    }
    
    fileprivate func nl_setCutoutNode(_ aView : ASDisplayNode)
    {
        return objc_setAssociatedObject(self, &cutoutHandle, aView, .OBJC_ASSOCIATION_RETAIN)
    }
    
    fileprivate func nl_getGradient()->CAGradientLayer?
    {
        return objc_getAssociatedObject(self, &gradientHandle) as! CAGradientLayer?
    }
    
    fileprivate func nl_setGradient(_ aLayer : CAGradientLayer)
    {
        return objc_setAssociatedObject(self, &gradientHandle, aLayer, .OBJC_ASSOCIATION_RETAIN)
    }
    
    fileprivate func nl_addLoader()
    {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width , height: self.bounds.size.height)
        self.layer.insertSublayer(gradient, at:0)
        
        self.configureAndAddAnimationToGradient(gradient)
        self.addCutoutNode()
    }
    
    fileprivate func nl_removeLoader()
    {
        self.nl_getCutoutNode()?.removeFromSupernode()
        self.nl_getGradient()?.removeAllAnimations()
        self.nl_getGradient()?.removeFromSuperlayer()
        
        for node in self.subnodes! {
            node.alpha = 1
        }
    }
    
    
    func configureAndAddAnimationToGradient(_ gradient : CAGradientLayer)
    {
        gradient.startPoint = CGPoint(x: -1.0 + CGFloat(gradientWidth), y: 0)
        gradient.endPoint = CGPoint(x: 1.0 + CGFloat(gradientWidth), y: 0)
        
        gradient.colors = [
            UIColor.backgroundFadedGrey().cgColor,
            UIColor.gradientFirstStop().cgColor,
            UIColor.gradientSecondStop().cgColor,
            UIColor.gradientFirstStop().cgColor,
            UIColor.backgroundFadedGrey().cgColor
        ]
        
        let startLocations = [NSNumber(value: gradient.startPoint.x.doubleValue() as Double),NSNumber(value: gradient.startPoint.x.doubleValue() as Double),NSNumber(value: 0 as Double),NSNumber(value: gradientWidth as Double),NSNumber(value: 1 + gradientWidth as Double)]
        
        
        gradient.locations = startLocations
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = startLocations
        gradientAnimation.toValue = [NSNumber(value: 0 as Double),NSNumber(value: 1 as Double),NSNumber(value: 1 as Double),NSNumber(value: 1 + (gradientWidth - gradientFirstStop) as Double),NSNumber(value: 1 + gradientWidth as Double)]
        
        gradientAnimation.repeatCount = Float.infinity
        gradientAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientAnimation.isRemovedOnCompletion = false
        gradientAnimation.duration = loaderDuration
        gradient.add(gradientAnimation ,forKey:"locations")
        
        
        self.nl_setGradient(gradient)
        
    }
    
    fileprivate func addCutoutNode()
    {
        let cutoutnode = CutoutNode()
        cutoutnode.frame = self.bounds
        cutoutnode.backgroundColor = UIColor.clear
     
        self.addSubnode(cutoutnode)
        

        cutoutnode.updateLayout()
        
        for node in self.subnodes! {
            if node != cutoutnode {
                node.alpha = 0
            }
        }
        
        
        self.nl_setCutoutNode(cutoutnode)
    }
}

@objc extension UIView
{
    fileprivate func nl_getCutoutView()->UIView?
    {
        return objc_getAssociatedObject(self, &cutoutHandle) as! UIView?
    }
    
    fileprivate func nl_setCutoutView(_ aView : UIView)
    {
        return objc_setAssociatedObject(self, &cutoutHandle, aView, .OBJC_ASSOCIATION_RETAIN)
    }
    
    fileprivate func nl_getGradient()->CAGradientLayer?
    {
        return objc_getAssociatedObject(self, &gradientHandle) as! CAGradientLayer?
    }
    
    fileprivate func nl_setGradient(_ aLayer : CAGradientLayer)
    {
        return objc_setAssociatedObject(self, &gradientHandle, aLayer, .OBJC_ASSOCIATION_RETAIN)
    }
    
    fileprivate func nl_addLoader()
    {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width , height: self.bounds.size.height)
        self.layer.insertSublayer(gradient, at:0)
        
        self.configureAndAddAnimationToGradient(gradient)
        self.addCutoutView()
    }
    
    fileprivate func nl_removeLoader()
    {
        self.nl_getCutoutView()?.removeFromSuperview()
        self.nl_getGradient()?.removeAllAnimations()
        self.nl_getGradient()?.removeFromSuperlayer()
        
        for view in self.subviews {
            view.alpha = 1
        }
    }
    
    
    func configureAndAddAnimationToGradient(_ gradient : CAGradientLayer)
    {
        gradient.startPoint = CGPoint(x: -1.0 + CGFloat(gradientWidth), y: 0)
        gradient.endPoint = CGPoint(x: 1.0 + CGFloat(gradientWidth), y: 0)
        
        gradient.colors = [
            UIColor.backgroundFadedGrey().cgColor,
            UIColor.gradientFirstStop().cgColor,
            UIColor.gradientSecondStop().cgColor,
            UIColor.gradientFirstStop().cgColor,
            UIColor.backgroundFadedGrey().cgColor
        ]
        
        let startLocations = [NSNumber(value: gradient.startPoint.x.doubleValue() as Double),NSNumber(value: gradient.startPoint.x.doubleValue() as Double),NSNumber(value: 0 as Double),NSNumber(value: gradientWidth as Double),NSNumber(value: 1 + gradientWidth as Double)]
        
        
        gradient.locations = startLocations
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = startLocations
        gradientAnimation.toValue = [NSNumber(value: 0 as Double),NSNumber(value: 1 as Double),NSNumber(value: 1 as Double),NSNumber(value: 1 + (gradientWidth - gradientFirstStop) as Double),NSNumber(value: 1 + gradientWidth as Double)]
        
        gradientAnimation.repeatCount = Float.infinity
        gradientAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientAnimation.isRemovedOnCompletion = false
        gradientAnimation.duration = loaderDuration
        gradient.add(gradientAnimation ,forKey:"locations")
        
        
        self.nl_setGradient(gradient)
        
    }
    
    fileprivate func addCutoutView()
    {
        let cutout = CutoutView()
        cutout.frame = self.bounds
        cutout.backgroundColor = UIColor.clear
        
        self.addSubview(cutout)
        cutout.setNeedsDisplay()
        cutout.boundInside(self)
        
        for view in self.subviews {
            if view != cutout {
                view.alpha = 0
            }
        }
        self.nl_setCutoutView(cutout)
    }
}
