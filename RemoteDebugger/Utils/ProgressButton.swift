//
//  ProgressButton.swift
//  RemoteDebugger
//
//  Created by Yogev Barber on 04/05/2020.
//  Copyright © 2020 Yogev Barber. All rights reserved.
//

import Cocoa

class ProgressButton: NSButton {
    
    private let progressBarMask = NSView()
    private let progressBar = CALayer()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(progressBarMask)
        progressBarMask.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressBarMask.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -0.7),
            progressBarMask.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.7),
            progressBarMask.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            progressBarMask.heightAnchor.constraint(equalToConstant: 2)
        ])
        progressBarMask.wantsLayer = true
        progressBarMask.layer?.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        progressBarMask.layer?.cornerRadius = 4
        progressBarMask.newBackgroundColor = NSColor.clear
        progressBarMask.layer?.masksToBounds = true
        
        progressBarMask.layer?.addSublayer(progressBar)
        progressBar.frame = CGRect(origin: progressBarMask.bounds.origin, size: CGSize(width: 0.0, height: 2))
        progressBar.backgroundColor = NSColor(named: "loading")?.cgColor
    }
    
    
    
    func updateProgress(progress: CGFloat) {
        progressBar.frame = CGRect(origin: progressBarMask.bounds.origin, size: CGSize(width: progressBarMask.frame.size.width * progress, height: 2))
    }
    
    func showProgress() {
        progressBar.frame = CGRect(origin: progressBarMask.bounds.origin, size: CGSize(width: 0, height: 2))
        progressBar.setNeedsLayout()
        progressBar.isHidden = false
    }
    
    func stopProgress() {
        progressBar.isHidden = true
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        layer?.masksToBounds = true
    }
    
    
}


extension NSView {

    var newBackgroundColor: NSColor? {
        get {
            if let colorRef = self.layer?.backgroundColor {
                return NSColor(cgColor: colorRef)
            } else {
                return nil
            }
        }
        set {
            self.wantsLayer = true
            self.layer?.backgroundColor = newValue?.cgColor
        }
    }
}
