//
//  UIView+Extension.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/12/21.
//

import UIKit

extension UIView {
    func pinEdgesToSafeArea(of view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

    func pinEdges(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    func setAnchor(width: CGFloat, height: CGFloat) {
        self.setAnchor(top: nil,
                       left: nil,
                       bottom: nil,
                       right: nil,
                       paddingTop: 0,
                       paddingLeft: 0,
                       paddingBottom: 0,
                       paddingRight: 0,
                       width: width,
                       height: height)
    }
    
    func setAnchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?,
                   bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,
                   paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat,
                   paddingRight: CGFloat, width: CGFloat = 0, height: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top { self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true }
        
        if let left = left { self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true }
        
        if let bottom = bottom { self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true }
        
        if let right = right { self.rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true }
        
        if width != 0 { self.widthAnchor.constraint(equalToConstant: width).isActive = true }
        
        if height != 0 { self.heightAnchor.constraint(equalToConstant: height).isActive = true }
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) { return safeAreaLayoutGuide.topAnchor }
        
        return topAnchor
    }

    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) { return safeAreaLayoutGuide.leftAnchor }
        
        return leftAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) { return safeAreaLayoutGuide.bottomAnchor }
        
        return bottomAnchor
    }

    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) { return safeAreaLayoutGuide.rightAnchor }
        
        return rightAnchor
    }
}
