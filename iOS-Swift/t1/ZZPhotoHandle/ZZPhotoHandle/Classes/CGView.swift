//
//  CGView.swift
//  ZZPhotoHandle
//
//  Created by kai on 17/3/24.
//  Copyright © 2017年 kai. All rights reserved.
//

import UIKit

class CGView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        let path = CGMutablePath()
        CGPathMoveToPoint(path, nil, 10, 30)
        CGPathAddLineToPoint(path, nil, 10, 100)
        
    }

}
