//
//  File.swift
//  wk
//
//  Created by leaf on 2017/12/25.
//  Copyright © 2017年 leaf. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var width: Float {
        get {
    
            return Float(self.bounds.width)
        }
    }
    
    var height: Float {
        get {
            return Float(self.bounds.height)
        }
    }
    
    var centenX: Float {
        get {
            return Float(self.bounds.width/2.0)
        }
    }
    
    var centenY: Float {
        get {
            return Float(self.bounds.height/2.0)
        }
    }
    
    var maxX: Float {
        get {
            return Float(self.bounds.origin.x + self.bounds.size.width)
        }
    }
    
    var maxY: Float {
        get {
            return Float(self.bounds.origin.y + self.bounds.size.height)
        }
    }
    
    var minX: Float {
        get {
            return Float(self.bounds.origin.x)
        }
    }
    
    var minY: Float {
        get {
            return Float(self.bounds.origin.y)
        }
    }
    
    var mainScreenWidth: Float {
        get {
            return Float(UIScreen.main.bounds.size.width)
        }
    }
    
    var mainScreenHeight: Float {
        get {
            return Float(UIScreen.main.bounds.size.height)
        }
    }
}
