# PhotoBrowser
Swift 2.0 类似微信/微博的图片展示，可展示本地和网络图片，继承于UIView

开发环境:xcode7 Version 7.0.1 (7A1001) / ios9.0

使用框架:SDWebImage, JGProgressHUD, MBProgressHUD

原来自己写的图片展示是用控制器来做的，改进了一下，用UIView来做。

类似于微博

现在开源出来，希望能能帮助到别人，代码有不尽如人意的地方，希望多多提意见。

##用法
展示本地图片
```swift
//设置本地数据源
browser = PhotoBrowserView.initWithPhotos(withUrlArray: self.localImage)
//类型为本地
browser.sourceType = SourceType.LOCAL
//设置展示哪张图片
browser.index = indexPath.row
//显示
browser.show()
```
展示网络图片
```swift
//网路数据源
browser = PhotoBrowserView.initWithPhotos(withUrlArray: self.remoteImage)
//类型为网络
browser.sourceType = SourceType.REMOTE
//设置展示哪张图片
browser.index = indexPath.row
//显示
browser.show()
```

##预览
![](https://github.com/luzefeng/PhotoBrowser/blob/master/preview.gif)
