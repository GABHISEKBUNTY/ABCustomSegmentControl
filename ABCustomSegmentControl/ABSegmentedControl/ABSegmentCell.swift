//
//  ABSegmentCell.swift
//  sampleCustomSegment
//
//  Created by uvGo on 12/08/16.
//  Copyright © 2016 Adodis. All rights reserved.
//

import UIKit

class ABSegmentCell: UICollectionViewCell {
    
    var textLabel: UILabel!
    var logoPresent=false

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width-10, height: self.frame.height-10))
//        textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        textLabel.textAlignment = .center
        contentView.addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(cellContentProperties:NSDictionary){
//        print(cellContentProperties)
//        textLabel.font = cellContentProperties[ABSegmentConstants.titleFont] as! UIFont
        textLabel.font = UIFont(name:"HelveticaNeue", size: 15.0)!
        textLabel.textColor = UIColor.white

        //UIFont(name:"HelveticaNeue-Bold", size: 16.0)!
    }
}
