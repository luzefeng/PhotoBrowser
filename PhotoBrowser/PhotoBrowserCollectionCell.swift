//
//  PhotoBrowserCollectionCell.swift
//  PhotoBrowser
//
//  Created by sue on 15/11/26.
//  Copyright © 2015年 lu. All rights reserved.
//

import UIKit

class PhotoBrowserCollectionCell: UICollectionViewCell {
    var imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        self.addSubview(imageView)
        imageView.frame = bounds
        imageView.clipsToBounds = true
    }

}
