//
//  PhotoBrowserView.swift
//  PhotoBrowser
//
//  Created by lu on 15/10/10.
//  Copyright © 2015年 lu. All rights reserved.
//

import UIKit

enum SourceType{
    case LOCAL
    case REMOTE
}

class PhotoBrowserView: UIView, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDataSource {

    var collectionView: UICollectionView?
    let cellIdentifier = "Cell"
    var photos = NSMutableOrderedSet()
    
    //显示当前页码
    var title: UILabel?
    //关闭按钮
    var close: UIButton?
    //下载按钮
    var downloadButton: UIButton?

    //数据源类型
    var sourceType: SourceType?
    
    let count = CGFloat(14)
    var heightUnit: CGFloat?
    var layout: UICollectionViewFlowLayout?
    
    //索引
    var index: Int?{
        didSet{
            title?.text = "\(index! + 1)/\(photos.count)"
            let indexPath = NSIndexPath(forRow: index!, inSection: 0)
            collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView(frame)
    }
    
    //初始化
    class func initWithPhotos(withUrlArray array: [AnyObject])-> PhotoBrowserView{
        let view = PhotoBrowserView(frame: (UIApplication.sharedApplication().keyWindow?.frame)!)
        view.photos.addObjectsFromArray(array)
        return view
    }
    
    //显示
    func show(){
        let window = UIApplication.sharedApplication().keyWindow
        window?.addSubview(self)
    }
    
    //设置页面ui
    func setupView(frame: CGRect){
        heightUnit = frame.height/self.count

        layout = UICollectionViewFlowLayout()
        layout!.itemSize = CGSize(width: frame.width, height: heightUnit!*(self.count - 2))
        layout!.scrollDirection = UICollectionViewScrollDirection.Horizontal
    
        collectionView = UICollectionView(frame: CGRect(x: 0, y: heightUnit!, width: frame.width, height: heightUnit!*(self.count - 2)), collectionViewLayout: layout!)
        collectionView!.pagingEnabled = true
        collectionView!.directionalLockEnabled = true

        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView!.showsHorizontalScrollIndicator = true
        collectionView!.indicatorStyle = UIScrollViewIndicatorStyle.White
        self.collectionView!.registerClass(PhotoBrowserCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.addSubview(collectionView!)
        
        addTitleLabel(frame)
        addCloseBtn(frame)
        addDownloadButton(frame)
    }
    
    //添加titleLabel
    func addTitleLabel(frame: CGRect){
        self.backgroundColor = UIColor.blackColor()
        title = UILabel(frame: CGRect(x: 0, y: 5.0, width: frame.width, height: heightUnit!))
        title?.textColor = UIColor.whiteColor()
        title?.textAlignment = NSTextAlignment.Center
        
        addSubview(title!)
    }
    //添加关闭按钮
    func addCloseBtn(frame: CGRect) {
        close = UIButton(frame: CGRect(x: 8, y: 5.0, width: 30, height: heightUnit!))
        close?.setImage(UIImage(named: "close"), forState: UIControlState.Normal)
        close?.addTarget(self, action: Selector("close:"), forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(close!)
    }

    //添加按钮
    func addDownloadButton(frame: CGRect){
        downloadButton = UIButton(frame: CGRect(x: frame.width/2 - 20, y: heightUnit!*(count - 1), width: 40, height: 35))
        let downloadImage = UIImage(named: "Download")
        let stretchableButtonImage = downloadImage?.stretchableImageWithLeftCapWidth(0, topCapHeight: 0)
        downloadButton!.setBackgroundImage(stretchableButtonImage, forState: UIControlState.Normal)
        downloadButton!.addTarget(self, action: "saveImage:", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(downloadButton!)
    }
    
    //保存图片
    func saveImage(sender: UIButton){
        let indexPath = collectionView!.indexPathsForVisibleItems().last!
        let cell = collectionView?.cellForItemAtIndexPath(indexPath) as! PhotoBrowserCell
        if cell.imageView.image == nil{
            print("image nil")
        }else{
            UIImageWriteToSavedPhotosAlbum(cell.imageView.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
        }
    }
    
    func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject?) {
        if error == nil{
            print("保存成功")
            showSuccessMsg("保存成功", interval: 0.5)
        }else{
            print("保存失败")
            showErrorMsg("保存失败", interval: 0.5)
        }
    }
    
    //判断当前页码
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int((floor(scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1) + 1
        title?.text = "\(page)/\(photos.count)"
        
    }
    //remove view
    func close(sender: UIButton) {
        self.removeFromSuperview()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    //左右间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    //    上下间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    //展示消息
    func showSuccessMsg(text: String, interval: Double){
        let hud = JGProgressHUD(style: JGProgressHUDStyle.Light)
        hud.textLabel.text = text
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.showInView(self, animated: true)
        hud.dismissAfterDelay(interval, animated: true)
    }
    
    func showErrorMsg(text: String, interval: Double){
        let hud = JGProgressHUD(style: JGProgressHUDStyle.Light)
        hud.textLabel.text = text
        hud.indicatorView = JGProgressHUDErrorIndicatorView()
        hud.showInView(self, animated: true)
        hud.dismissAfterDelay(interval, animated: true)
    }
    
    //设置每个cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! PhotoBrowserCell
        let url = photos.objectAtIndex(indexPath.row) as! NSURL
        let frame = cell.imageView.frame
        let percent: CGFloat = 0.8
        cell.imageView.frame = CGRect(x: frame.width*(1 - percent)/2, y: frame.height*(1 - percent)/2, width: frame.width*percent, height: frame.height*percent)
        if sourceType == SourceType.REMOTE{
            let loadingNotification = MBProgressHUD.showHUDAddedTo(self, animated: true)
            loadingNotification.mode = MBProgressHUDMode.Indeterminate
                            loadingNotification.labelText = "加载中..."
            cell.imageView.sd_setImageWithURL(url) { (image, _, _ , _ ) -> Void in
                MBProgressHUD.hideHUDForView(self, animated: false)
                if image == nil {
                    return
                }
                
                cell.imageView.image = image
            }
        }else{
            let image = UIImage(named: (url.absoluteString))
            
            cell.imageView.image = image
            
        }
        UIView.animateWithDuration(NSTimeInterval(0.5), animations: {
            () in
            cell.imageView.frame = frame
        })
         cell.scrollView.zoomScale = 1
        return cell
    }
}
