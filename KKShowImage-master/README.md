KKShowImage
===========

An simple iOS image viewer that does it all: double tap to zoom,pin to zoom,tap to show ,dismiss etc.

Use
--------

![image](screen/01.png) ![image](screen/02.png)


- single tap to show
- single tap to dismiss
- double tap to Zoom
- pin GestureRecognizer to Zoom
- pan GestureRecognizer to Move


example
---------

使用类方法 `+ (void)showImage:(UIImage *)image`

```objective-c
//查看图片Action
- (void)showIMAGESSS
{
    [KKShowImage showImage:[UIImage imageNamed:@"test2.png"]];

}
```


使用View 


```objective-c

	//添加的view在消失自动从父视图remove
    KKShowImage *show = [KKShowImage new];
    show.image = [UIImage imageNamed:@"test2.png"];
    [self.view addSubview:show];
```