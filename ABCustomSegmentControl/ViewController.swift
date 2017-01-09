//
//  ViewController.swift
//  customSegment
//
//  Created by G.Abhisek on 25/04/16.
//  Copyright © 2016 Adodis. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ABSegmentDelegate
{
    @IBOutlet weak var pagingCollectionView: UICollectionView!
    var segment:ABSegmentView? = nil
    
    //create Title Array & corresponding image Array to be displayed in the segments
    var TitleArray = ["Contacts","Name","Gallery","Audio","Video"]
    var sectionImageArray = [UIImage(named: "nameList"),UIImage(named: "photo"),UIImage(named: "nameList"),UIImage(named: "photo"),UIImage(named: "nameList"),UIImage(named: "photo")]
    
    let colorArray = NSMutableArray()
    let viewArray = NSMutableArray()
    var currentIndexPath:NSIndexPath!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //initially keep the first segment as selected
        
        let mySegmentProperties = ABSegmentProperties()
        mySegmentProperties.titleArray = TitleArray
        mySegmentProperties.unselectedSegmentColor = UIColor(red: 13/255, green: 15/255, blue: 85/255, alpha: 1)
        mySegmentProperties.selectedSegmentColor = UIColor(red: 37/255, green: 43/255, blue: 134/255, alpha: 1)
        mySegmentProperties.selectedSegment = 0
        
        mySegmentProperties.dividerWidth = 2.0
        mySegmentProperties.dividerColor = UIColor.redColor()
        mySegmentProperties.titleFont = UIFont(name:"HelveticaNeue-Bold", size: 16.0)!
        mySegmentProperties.titleColor = UIColor.redColor()
        let segment = ABSegmentView(frame: CGRectMake(0, 43, view.frame.width,50), collectionViewLayout: UICollectionViewLayout(), segmentProperties: mySegmentProperties)
        segment.ABDelegate = self
        self.segment=segment
        self.view.addSubview(segment)

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:CollectionView Data source
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return TitleArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
            let cell = pagingCollectionView.dequeueReusableCellWithReuseIdentifier("pagingCell", forIndexPath: indexPath) as! MyCVC
            
            
            //Add views as pages
            if indexPath.item == 0{
                let page1 = self.storyboard?.instantiateViewControllerWithIdentifier("VC1") as? VC1
                page1!.view.frame = cell.pagingView.bounds
                self.addChildViewController(page1!)
                cell.pagingView.addSubview(page1!.view)
                page1!.textLabel.text = TitleArray[0]
                page1!.didMoveToParentViewController(self)
                
            }
            if indexPath.item == 1
            {
                
                let page2 = self.storyboard?.instantiateViewControllerWithIdentifier("VC2")
                page2!.view.frame = cell.pagingView.bounds
                self.addChildViewController(page2!)
                cell.pagingView.addSubview(page2!.view)
                page2!.didMoveToParentViewController(self)
                
            }
            else if indexPath.item == 2
            {
                let Name_List2 = self.storyboard?.instantiateViewControllerWithIdentifier("VC1") as? VC1
                Name_List2!.view.frame = cell.pagingView.bounds
                self.addChildViewController(Name_List2!)
                cell.pagingView.addSubview(Name_List2!.view)
                Name_List2!.textLabel.text = TitleArray[2]
                Name_List2!.didMoveToParentViewController(self)
                
            }
            else if indexPath.item == 3
            {
                let page3 = self.storyboard?.instantiateViewControllerWithIdentifier("VC1") as? VC1
                page3!.view.frame = cell.pagingView.bounds
                self.addChildViewController(page3!)
                cell.pagingView.addSubview(page3!.view)
                page3!.textLabel.text = TitleArray[3]
                page3!.didMoveToParentViewController(self)
                
                
            }
            else if indexPath.item == 4
            {
                let page4 = self.storyboard?.instantiateViewControllerWithIdentifier("VC1") as? VC1
                page4!.view.frame = cell.pagingView.bounds
                self.addChildViewController(page4!)
                cell.pagingView.addSubview(page4!.view)
                page4!.textLabel.text = TitleArray[4]
                page4!.didMoveToParentViewController(self)
            }
            return cell
    }
    
    //MARK:CollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(pagingCollectionView.frame.width, pagingCollectionView.frame.height)
    }
    
    
    
    
    //MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        //here we check that if user changes/scrolls to different pages we change the segment collection view's current selected index.
        if scrollView == pagingCollectionView
        {
            //code to get the current visible page
            for cell in pagingCollectionView.visibleCells()  as! [MyCVC]{
                currentIndexPath = pagingCollectionView.indexPathForCell(cell)
            }
        }
        segment?.scrollToItemAtIndexPath(currentIndexPath, atScrollPosition: .CenteredHorizontally, animated: true)
        ABSegmentView.ABSegment(scrollToSegment: currentIndexPath.row, theSegmentIs:segment!)
    }
    
    
    //MARK:ABSegmentViewDelegate
    func ABSegment(segmentView: ABSegmentView, didSelectSegment segment: Int) {
        let indexPath = NSIndexPath(forItem: segment, inSection: 0)
        pagingCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
    }
    
}

