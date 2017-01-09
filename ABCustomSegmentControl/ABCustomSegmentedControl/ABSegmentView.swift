//
//  ABSegmentView.swift
//  sampleCustomSegment
//
//  Created by uvGo on 02/08/16.
//  Copyright © 2016 Adodis. All rights reserved.
//

import UIKit

@objc protocol ABSegmentDelegate: class {
    @objc optional func ABSegment(segmentView: ABSegmentView,didSelectSegment segment: Int)
}

class ABSegmentView: UICollectionView,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    let colorArray = NSMutableArray()
    var customSegmentProperties = ABSegmentProperties()
    weak var ABDelegate:ABSegmentDelegate?
    
    /**
     init method for segmentView
     
     - parameter frame:             frame to be set
     - parameter layout:            layout to be set for the sgment view
     - parameter segmentProperties: properties of all segments
     
     */
    
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout,segmentProperties: ABSegmentProperties) {
        
        let segmentLayout = UICollectionViewFlowLayout()
        segmentLayout.minimumInteritemSpacing = 0
        segmentLayout.scrollDirection = .horizontal
        segmentLayout.minimumLineSpacing =  segmentProperties.dividerWidth
        
        super.init(frame: frame, collectionViewLayout: segmentLayout)
        self.dataSource = self
        self.delegate = self
        self.bounces = false
        
        self.showsHorizontalScrollIndicator=false
        
        customSegmentProperties = segmentProperties
        createSegProperties()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK:CollectionView data source methods.
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return customSegmentProperties.titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath as IndexPath) as! ABSegmentCell
        cell.backgroundColor = colorArray[indexPath.row] as? UIColor
        cell.textLabel.text = customSegmentProperties.titleArray[indexPath.row] as? String
        cell.configureCell(cellContentProperties: ABSegmentProperties().createSegmentContentProperties(rawSegmentProperty: customSegmentProperties))
        return cell
        
    }
    
    //MARK:CollectionView delegate methods.
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//        
//        return CGSize(width: (self.frame.width)/3, height: self.frame.height)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var entity = customSegmentProperties.titleArray[indexPath.row]
        var width: CGFloat = self.getWidthOfText(entity.servicename) + kCellContentPadding
        var itemSize = CGSize(width: width, height: CGFloat(self.segmentCllctnView.frame.size.height))
        return itemSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if ABDelegate != nil{
            ABDelegate?.ABSegment!(segmentView: self, didSelectSegment: indexPath.row)
        }
        //when user selects any particular segment we change the color accordingly
        changeArrayColor(index: indexPath.row)
    }
    
    /**
     Perform Scroll movement to appropriate position
     
     - parameter segment:      segment count
     - parameter theSegmentIs: the psrticular segment instance that is being used
     */
    class func ABSegment(scrollToSegment segment:Int, theSegmentIs:ABSegmentView){
        let indexPath = NSIndexPath(item: segment, section: 0)
        theSegmentIs.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    //MARK:Helper method
    
    /**
     This function is for creating all the properties related to the UI of the segment view.
     */
    func createSegProperties(){
        
        self.register(ABSegmentCell.self, forCellWithReuseIdentifier: "myCell")
        self.backgroundColor = customSegmentProperties.dividerColor
        changeArrayColor(index: customSegmentProperties.selectedSegment!)
        
    }
    
    /**
     //initial properties . these properties are variable i.e changing in run time of the app(eg. on selecting the cell we change these properties of the cell) and so needs to be stored in an array so in dequeing there wouyld be no problem. as dequeing reusable cell makes the old properties reappear
     
     - parameter index: it is the selected segment's index
     */
    func changeArrayColor(index:NSInteger)
    {
        colorArray.removeAllObjects()
        
        for i in 0 ..< customSegmentProperties.titleArray.count
        {
            if i == index{
                colorArray[i] = customSegmentProperties.unselectedSegmentColor
            }else{
                colorArray.insert(customSegmentProperties.selectedSegmentColor, at: i)
            }
        }
        self.reloadData()
    }

    
    func getWidthOfText(_ text: String) -> CGFloat {
        var frameSize = CGSize(width: CGFloat(300), height: CGFloat(50))
        var font = UIFont.systemFont(ofSize: CGFloat(12))
        var idealFrame = text.boundingRect(with: frameSize, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return idealFrame.size.width
    }
}
