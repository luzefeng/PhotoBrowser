//
//  MainViewController.swift
//  PhotoBrowser
//
//  Created by lu on 15/10/10.
//  Copyright © 2015年 lu. All rights reserved.
//

import UIKit
import YYWebImage

class MainViewController: UIViewController, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDataSource{
    
    var collectionView: UICollectionView?
    let cellIdentifier = "Cell"
    //设置本地缩略图
    var localThumbImage = [NSURL(string: "1-1.jpg"), NSURL(string: "1-2.jpg"), NSURL(string: "1-3.jpg")]
    //展示本地图片
    var localImage = [NSURL(string: "2-1.jpg")!, NSURL(string: "2-2.jpg")!, NSURL(string: "2-3.jpg")!]
    
    //网络缩略图
    var remoteThumbImage = [NSURL(string: "http://img.1985t.com/uploads/previews/2015/08/0-KVoUKo.jpg"), NSURL(string: "http://img.1985t.com/uploads/previews/2015/08/0-dQCJkd.jpg"), NSURL(string: "http://imgs.gifxiu.net/upload/20150609/171753_3750.gif"), NSURL(string: "http://imgs.gifxiu.net/upload/20151104/210950_1093.gif")]
    
    //网络图片
    var remoteImage = [NSURL(string: "http://img.1985t.com/uploads/attaches/2015/08/45787-uWfw1o.jpg")!, NSURL(string: "http://img.1985t.com/uploads/attaches/2015/08/45770-iRuWwg.jpg")!, NSURL(string: "http://imgs.gifxiu.net/upload/20150609/171753_3750.gif")!, NSURL(string: "http://imgs.gifxiu.net/upload/20151104/210950_1093.gif")!]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // Do any additional setup after loading the view.
    }

    //设置展示collectionview
    func setupView(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.bounds.size.width/3, height: self.view.bounds.size.width/3/225*300)
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 40)
        let collectionViewFrame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height)
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView!.pagingEnabled = true
        collectionView!.directionalLockEnabled = true
        collectionView!.collectionViewLayout = layout
        collectionView!.delegate = self
        collectionView!.dataSource = self
        self.collectionView!.registerClass(PhotoBrowserCollectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        self.view.addSubview(collectionView!)
    }
    
    //点击查看大图
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var browser:PhotoBrowserView
        
        if indexPath.section == 0{
            //设置本地数据源
            browser = PhotoBrowserView.initWithPhotos(withUrlArray: self.localImage)
            //类型为本地
            browser.sourceType = SourceType.LOCAL
        }else{
            //网路数据源
            browser = PhotoBrowserView.initWithPhotos(withUrlArray: self.remoteImage)
            //类型为网络
            browser.sourceType = SourceType.REMOTE
        }
        
        //设置展示哪张图片
        browser.index = indexPath.row
        
        //显示
        browser.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return localThumbImage.count
        }else if section == 1{
            return remoteThumbImage.count
        }
        
        return 0
    }
    
    //左右间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    //    上下间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let placeHolder = UIImage(named: "placeholder.png")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! PhotoBrowserCollectionCell
        
        if indexPath.section == 0{
            let localUrl = localThumbImage[indexPath.row]
            cell.imageView.image = UIImage(named: (localUrl?.absoluteString)!)
        }
        
        if indexPath.section == 1{
            let remoteUrl = remoteThumbImage[indexPath.row]
            cell.imageView.yy_setImageWithURL(remoteUrl, placeholder: placeHolder, options: YYWebImageOptions.SetImageWithFadeAnimation, completion: { (image, _, _, _, _) -> Void in
                if image == nil{
                    return
                }
            })
        }
    
        return cell
    }
}
