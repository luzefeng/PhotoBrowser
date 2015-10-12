//
//  PhotoBrowserCell.swift
//  PhotoBrowser
//
//  Created by lu on 15/10/10.
//  Copyright © 2015年 lu. All rights reserved.
//

import UIKit

class PhotoBrowserCell: UICollectionViewCell, UIScrollViewDelegate {
    var imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        addSubview(imageView)
        
        imageView.frame = bounds
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
    }
}
