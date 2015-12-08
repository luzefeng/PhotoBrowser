# PhotoBrowser
Swift 2.0 类似微信/微博的图片展示，可展示本地和网络图片，继承于UIView

开发环境:xcode7 Version 7.0.1 (7A1001) / ios9.0

使用框架:JGProgressHUD, YYWebImage

原来自己写的图片展示是用控制器来做的，改进了一下，用UIView来做。

类似于微博的图片展示效果
- 支持PNG/JPG/GIF/WEBP图
- 支持缓存
- 下载进度显示
- 支持手势缩放，双击缩放，单击退出
- 支持图片下载

现在开源出来，希望能能帮助到别人，代码有不尽如人意的地方，希望多多提意见。

##用法
```swift
把Browser文件夹拖到项目工程里
Podfile里添加
pod 'YYWebImage'
pod 'JGProgressHUD'

```
展示本地图片
```swift
//展示本地图片
var localImage = [NSURL(string: "2-1.jpg")!, NSURL(string: "2-2.jpg")!, NSURL(string: "2-3.jpg")!, NSURL(string: "2-4.jpg")!]
//设置本地数据源
browser = PhotoBrowserView.initWithPhotos(withUrlArray: self.localImage)
//类型为本地
browser.sourceType = SourceType.LOCAL
//设置展示的第一张图片
browser.index = indexPath.row
//显示
browser.show()
```
展示网络图片
```swift
//网络图片
var remoteImage = [NSURL(string: "http://img.1985t.com/uploads/attaches/2015/08/45787-uWfw1o.jpg")!, NSURL(string: "http://img.1985t.com/uploads/attaches/2015/08/45770-iRuWwg.jpg")!, NSURL(string: "http://img.1985t.com/uploads/attaches/2015/08/45543-jr0g0R.jpg")!, NSURL(string: "http://img.1985t.com/uploads/attaches/2015/08/45541-qd82Lh.jpg")!]
//网路数据源
browser = PhotoBrowserView.initWithPhotos(withUrlArray: self.remoteImage)
//类型为网络
browser.sourceType = SourceType.REMOTE
//设置展示的第一张图片
browser.index = indexPath.row
//显示
browser.show()
```

##预览
上面3张是本地图片，下面4张是网络图片，网络图片未缓存的显示进度条，已缓存的不会显示
![](https://github.com/luzefeng/PhotoBrowser/blob/master/preview.gif)

#License
MIT license. 
