//
//  segentControlProperties.swift
//  sampleCustomSegment
//
//  Created by uvGo on 02/08/16.
//  Copyright © 2016 Adodis. All rights reserved.
//

import UIKit

class ABSegmentProperties: NSObject {
    
    var selectedSegmentColor = UIColor()
    var unselectedSegmentColor = UIColor()
    var dividerColor = UIColor()
    var dividerWidth = CGFloat()
    var titleArray = NSArray()
    var selectedSegment:Int?
    
    var titleFont=UIFont()
    var titleColor=UIColor()
    
    
    func createSegmentContentProperties(rawSegmentProperty:ABSegmentProperties) -> NSDictionary {
        
        let contentProperties = [rawSegmentProperty.titleFont:ABSegmentConstants.titleFont,rawSegmentProperty.titleColor:ABSegmentConstants.titleColor] as [AnyHashable : String];
        return contentProperties as NSDictionary
        
    }
   
}


