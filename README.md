
> 对于之前使用的UIWebView,由于性能方面一直被吐槽，所以苹果官方现在推出一款性能极佳的WebKit库来代替UIWebView，WKWebView使用的内存是原来的1/3甚至1/4，WKWebView是现代WebKit API 在iOS8和OS X Yosemite应用中的核心部分。它代替了UIKit中的UIWebView和AppKit 中的WebView，提供了统一的跨双平台 API。
自诩拥有60fps滚动刷新率、内置手势、高效的app和web信息交换通道、和 Safari相同的JavaScript引擎，所以必须学习一下

<!-- more-->


## 初始化

### initWithFrame:configuration:

``` swift
init(frame frame: CGRect,
 configuration configuration: WKWebViewConfiguration)
```

``` objc
- (instancetype)initWithFrame:(CGRect)frame
 con          figuration:(WKWebViewConfiguration *)configuration
``

**  这个方法可以自定义WKWebViewConfiguration。并初始化复制指定的配置。 如果你不想配置相关参数，可以使用initwithframe：初始默认配置实例方法。 **



## 属性介绍

* configuration：浏览器配置（只读）

``` swift
@NSCopying var configuration: WKWebViewConfiguration { get }
```

``` objc
@property(nonatomic, readonly, copy) WKWebViewConfiguration *configuration
```

* scrollview: 滚动视图（只读）

``` swift
var scrollView: UIScrollView { get }
```

``` objc
@property(nonatomic, readonly, strong) UIScrollView *scrollView
```
 
* title:页面的标题(只读)）

``` swift
var title: String? { get }
```

``` objc
@property(nonatomic, readonly, copy) NSString *title
```

* URL:当前页面的URL(只读)

``` swift
@NSCopying var URL: NSURL? { get }
```

``` objc
@property(nonatomic, readonly, copy) NSURL *URL
```


* customUserAgent：用户设置的代理信息，没有为nil（9.0 and later）

``` swift
var customUserAgent: String?
```

``` objc
@property(nonatomic, copy) NSString *customUserAgent
```


* ertificateChain:当前已提交的导航的证书链的对象数组。（只读）（9.0 and later）

``` swift
var certificateChain: [AnyObject] { get }
```

``` objc
@property(nonatomic, readonly, copy) NSArray *certificateChain
```

* navigationDelegate：浏览器导航代理

``` swift
weak var navigationDelegate: WKNavigationDelegate?
```

``` objc
@property(nonatomic, weak) id< WKNavigationDelegate > navigationDelegate
```

* UIDelegate：浏览器用户界面代理

``` swift
weak var UIDelegate: WKUIDelegate?
```

``` objc
@property(nonatomic, weak) id< WKUIDelegate > UIDelegate
```


## 加载内容

* estimatedProgress：加载的进度值，从0到1

``` swift
var estimatedProgress: Double { get }
```

``` objc
@property(nonatomic, readonly) double estimatedProgress
```


* hasOnlySecureContent：是否安全加密加载页面（只读）

``` swift
var hasOnlySecureContent: Bool { get }
```

``` objc
@property(nonatomic, readonly) BOOL hasOnlySecureContent
```


* 加载HTML字符串

``` swift
func loadHTMLString(_ string: String,
 baseURL baseURL: NSURL?) -> WKNavigation?
```

``` objc
- (WKNavigation *)loadHTMLString:(NSString *)string
 baseURL:(NSURL *)baseURL
```

**  Parameters
 string HTML内容字符串
 baseURL：解析HTML内容字符串里面的网址 **


* loading：是否正在加载中（只读）

``` swift
var loading: Bool { get }
```

``` objc
@property(nonatomic, readonly, getter=isLoading) BOOL loading
```

* reload：重新加载页面方法

``` swift
func reload() -> WKNavigation?
```

``` objc
 - (WKNavigation *)reload
```

* reloadFromOrigin重新载入当前页面，进行端到端的验证使用缓存验证条件

``` swift
func reloadFromOrigin() -> WKNavigation?
```

``` objc
- (WKNavigation *)reloadFromOrigin
```


* stopLoading在当前页面停止所有的加载

``` swift
func stopLoading()
```

``` objc
- (void)stopLoading
```


* loadData:MIMEType:characterEncodingName:baseURL:加载数据

``` swift
func loadData(_ data: NSData,
 MIMEType MIMEType: String,
 characterEncodingName characterEncodingName: String,
 baseURL baseURL: NSURL) -> WKNavigation?
```

``` objc
- (WKNavigation *)loadData:(NSData *)data
 MIMEType:(NSString *)MIMEType
 characterEncodingName:(NSString *)characterEncodingName
 baseURL:(NSURL *)baseURL
```

** data: 网页转换的数据
 MIMEType
 {
 application/msexcel
 application/mshelp	
 application/mspowerpoint
 application/msword	
 application/octet-stream
 application/pdf
 application/post 
 application/rtf	
 application/x-httpd-php
 }
characterEncodingName ：编码类型
baseURL：用于解析文档中的相对网址的网址。 **


* loadFileURL:allowingReadAccessToURL:加载导航到所请求的文件系统上的文件的URL

``` swift
func loadFileURL(_ URL: NSURL,
 allowingReadAccessToURL readAccessURL: NSURL) -> WKNavigation?
```

``` objc
 (WKNavigation *)loadFileURL:(NSURL *)URL
 allowingReadAccessToURL:(NSURL *)readAccessURL
```

** readAccessURL如果是一个文件，直接加载，如果是一个目录，加载里面的文件 **

## Navigating导航

* allowsBackForwardNavigationGestures是否允许水平滑动前进后退页面。默认是NO

``` swift
var allowsBackForwardNavigationGestures: Bool
```

``` objc
allowsBackForwardNavigationGestures
```


* backForwardList历史记录

``` swift
ar backForwardList: WKBackForwardList { get }
```

``` objc
@property(nonatomic, readonly, strong) WKBackForwardList *backForwardList
```

* canGoBack：是否后退到历史记录的一项（只读）

``` swift
var canGoBack: Bool { get }
```

``` objc
@property(nonatomic, readonly) BOOL canGoBack
```


* canGoForward：是否前进到历史记录的某一项（只读）

``` swift
var canGoForward: Bool { get }
```

``` objc
@property(nonatomic, readonly) BOOL canGoForward
```


* allowsLinkPreview：是否支持链接预览，支持3DTouch查看等

``` swift
var allowsLinkPreview: Bool
```

``` objc
@property(nonatomic) BOOL allowsLinkPreview
```


* goBack：回到后一页

``` swift
func goBack() -> WKNavigation?
```

``` objc
- (WKNavigation *)goBack
```


* oForward：前进一页

``` swift
func goForward() -> WKNavigation?
```

``` objc
- (WKNavigation *)goForward
```


* goToBackForwardListItem:导航到一个新的项目（从后向前），并设置为当前项目

``` swift
func goToBackForwardListItem(_ item: WKBackForwardListItem) -> WKNavigation?
```

``` objc
- (WKNavigation *)goToBackForwardListItem:(WKBackForwardListItem *)item
```

* loadRequest:加载URL的请求

``` swift
func loadRequest(_ request: NSURLRequest) -> WKNavigation?
```

``` objc
- (WKNavigation *)loadRequest:(NSURLRequest *)request
```


* 执行JavaScript语言

``` swift
func evaluateJavaScript(_ javaScriptString: String,
      completionHandler completionHandler: ((AnyObject?, NSError?) -> Void)?)
```

``` objc
- (void)evaluateJavaScript:(NSString *)javaScriptString
         completionHandler:(void (^)(id, NSError *error))completionHandler
```

** completionHandler：执行后的block回调 **


> 从上一篇文章我大概根据苹果官方文档，列出了WKWebView相关的属性以及方法。有两种格式，分别是swift以及objective-c。那么，列出来有什么用处呢？我又不会用？下面就我搜集以及实践过的例子来实现一下这些方法以及属性有什么用处。

先来个效果图看看吧
![](http://7xv233.com1.z0.glb.clouddn.com/WKWebView.gif)


<!-- more-->


> 相信大家使用UIWebView已经很熟悉了，这里就不介绍了，但是demo里面有释放的介绍。本文重点介绍WKWebView的用法。废话不哆嗦，上代码。

---

## 声明WKWebView属性

```objc
@property (nonatomic, strong) WKWebView *webView;
```

## 初始化WKWebView

```objc
- (WKWebView *)webView{
    if (_webView == nil) {
        // 配置网页的配置文件
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        // 允许视频播放
        configuration.allowsAirPlayForMediaPlayback = YES;
        // 允许在线播放
        configuration.allowsInlineMediaPlayback = YES;
        // 允许图片播放
        configuration.allowsPictureInPictureMediaPlayback = YES;
        // 允许与网页交互，选择视图
        configuration.selectionGranularity = YES;
        // 创建更改数据源
        NSString *js = [NSString stringWithFormat:@"loadDetail(\"%d\")", 70];
        WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *userContent = [[WKUserContentController alloc] init];
        [userContent addUserScript:script];
        // 是否支持记忆读取
        configuration.suppressesIncrementalRendering = YES;
        // 允许用户更改网页的设置
        configuration.userContentController = userContent;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 66, self.view.frame.size.width, self.view.frame.size.height-64) configuration:configuration];
        // 设置代理
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        // 添加进度监控
        /*
         NSKeyValueObservingOptionNew 把更改之前的值提供给处理方法
         NSKeyValueObservingOptionOld 把更改之后的值提供给处理方法
         NSKeyValueObservingOptionInitial 把初始化的值提供给处理方法，一旦注册，立马就会调用一次。通常它会带有新值，而不会带有旧值。
         NSKeyValueObservingOptionPrior 分2次调用。在值改变之前和值改变之后。
         */
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        // 开启手势触摸
        _webView.allowsBackForwardNavigationGestures = YES;
        // 适应设定的尺寸
        [_webView sizeToFit];
    }
    return _webView;
}
```

## 添加到父视图view

```objc
self.view addSubview:self.webView];
```


## 加载本地HTML语言



```objc
- (void)loadHTML{
    /**
     *  应用场景：只加载网页的某一部分
     *  例如：完整的网页可能包含广告部分，但是又不想要广告，所以我们可以加载整个网页，然后截取想要的部分，再加载
     */
    /**
     *  现在要加载一个HTML文件，里面的内容是
     <html>
    <style type="text/css">
</style>
    <head>
        <meta charset="utf-8">
            <meta name="viewport" content="width=device-width,
    initial-scale=1">
    <title>TITLE</title>
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.css">
        <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script> <script
            src="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.js"></script>
    </head>
<body>
    <div data-role="page" id="page1">
        <div align=justify style="margin-left:20px; margin-right:20px">
            <font size="4.5" face="HelveticaNeue-Light"><br> <p>
                THIS IS A TEST
                </p>
        </div> </div>
</body></html>
     */
    // 获取本地文件的文件的路径
    // 获取文件路径
    NSString *resourcePath = [ [NSBundle mainBundle] resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:@"test.html"];
    NSString *htmlstring =[[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlstring baseURL:[NSURL URLWithString:[[NSBundle mainBundle] bundlePath]]];
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test.html" ofType:nil];
//    NSString *htmlStr = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    [self.webView loadHTMLString:htmlStr baseURL:[NSURL URLWithString:[[NSBundle mainBundle] bundlePath]]];
}
```


## 加载网络上HTML语言

```objc
- (void)loadLineHTML{
    /**
     *  应用场景：只加载网页的某一部分
     *  例如：完整的网页可能包含广告部分，但是又不想要广告，所以我们可以加载整个网页，然后截取想要的部分，再加载
     */
    // 如果你的路径不是本地的，是网络的地址，那么你可以这样写
    NSString *lineURL = @"http://daisuke.cn";
    // 测试过地址含有中文不行的，地址格式也不能错，不然加载出来是空的
    NSString *lineHtmlStr = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:lineURL] encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:lineHtmlStr baseURL:[NSURL URLWithString:lineURL]];
}
```

## 加载文本地件

```objc
- (void)loadFile{
    // 很多时候，我们并不想加载HTML文件，或者说我们没有HTML文件，因为从服务器下载出来的文件并不都是HTML格式，那么可以加载其他格式的文件吗？答案是YES
    // 文件有很多格式，常见的有：txt, PDF, doc, excel, gif, 图片等
    // 获取文件路径
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"The Swift Programming Language 中文版 - v1.2.pdf" withExtension:nil];
    // 建立连接
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:fileURL];
    [self.webView loadRequest:request];
}
```


## 加载网络上文件

```objc
- (void)loadLineFile{
    // 很多时候，我们并不想加载HTML文件，或者说我们没有HTML文件，因为从服务器下载出来的文件并不都是HTML格式，那么可以加载其他格式的文件吗？答案是YES
    // 应用场景：加载从服务器上下载的文件，例如PDF、Word、txt、图片等文件
    // 文件有很多格式，常见的有：txt, PDF, doc, excel, gif, 图片等
    // 获取文件路径
//    NSURL *lineFileURL = [NSURL URLWithString:@"http://img1.imgtn.bdimg.com/it/u=2778058058,3407162019&fm=21&gp=0.jpg"];
    NSURL *lineFileURL = [NSURL URLWithString:@"http://www.iqiyi.com/v_19rrifujmu.html"];
    // 建立连接
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:lineFileURL];
    [self.webView loadRequest:request];
}
```



## 以数据形式加载文件

```objc
- (void)loadData{
    // 应用场景：加载从服务器上下载的文件，例如PDF、Word、txt、图片等文件
    // 文件有很多格式，常见的有：txt, PDF, doc, excel, gif, 图片等
    // 只是转为data形式而已，本质并没有什么差别
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"The Swift Programming Language 中文版 - v1.2.pdf" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    __weak TestWKWebView *weakSelf = self;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [weakSelf.webView loadData:data MIMEType:response.MIMEType characterEncodingName:@"UTF8" baseURL:[NSURL URLWithString:@""]];
    }];
    [dataTask resume];
}
```


## 进度条

### 声明一个UIProgressView属性

```objc
/**
 *  进度条
 */
@property (strong, nonatomic) UIProgressView *progressView;
```

### 来加载UIProgressView初始化

```objc
- (UIProgressView *)progressView{
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 2);
        // 设置进度条颜色
        [_progressView setTrackTintColor:[UIColor whiteColor]];
        _progressView.progressTintColor = [UIColor blueColor];
    }
    return _progressView;
}
```

### 在WKWebView添加进度条监听


```objc
// 添加进度监控
        /*
         NSKeyValueObservingOptionNew 把更改之前的值提供给处理方法
         NSKeyValueObservingOptionOld 把更改之后的值提供给处理方法
         NSKeyValueObservingOptionInitial 把初始化的值提供给处理方法，一旦注册，立马就会调用一次。通常它会带有新值，而不会带有旧值。
         NSKeyValueObservingOptionPrior 分2次调用。在值改变之前和值改变之后。
         */
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
```


### 在view添加UIProgressView

```objc
[self.view addSubview:self.progressView];
```

### 重写observeValueForKeyPath监听方法

```objc
// 计算webView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"])     {
    // 取出加载的值。0~1
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
            [UIView animateWithDuration:0.2 animations:^{
                CGRect rect = self.webView.frame;
                rect.origin.y = 64;
                self.webView.frame = rect;
            }];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}
// 记得取消监听
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
```


## WKNavigationDelegate代理方法

```objc
//这个是网页加载完成，导航的变化
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    /*
     主意：这个方法是当网页的内容全部显示（网页内的所有图片必须都正常显示）的时候调用（不是出现的时候就调用），，否则不显示，或则部分显示时这个方法就不调用。
     */
    NSLog(@"加载完成调用");
    // 获取加载网页的标题
    NSLog(@"加载的标题：%@",self.webView.title);
    NSLog(@"%lf",   self.webView.estimatedProgress);
}
//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    self.progressView.hidden = NO;
    NSLog(@"开始加载的时候调用。。");
    NSLog(@"%lf",   self.webView.estimatedProgress);  
}
//内容返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"当内容返回的时候调用");
}
```



## 前进、后退、重载、跳转方法

### 在view上添加4个按钮，分别对应

```objc
// 添加4个按钮
    NSArray * WkWeb_Title = @[@"重载",@"后退",@"前进",@"跳转"];
    for (int i= 0 ; i<4; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+i*((self.view.bounds.size.width-50)/4+10), self.view.bounds.size.height - 45, (self.view.bounds.size.width-50)/4, 40);
        [button setTitle:WkWeb_Title[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
```

### 点击事件

```objc
- (void)clickBtn:(UIButton *)btn{
    switch (btn.tag) {
        case 0:{
            // 这个是带缓存的验证
            // self.webView reloadFromOrigin];
            // 是不带缓存的验证，刷新当前页面
            [self.webView reload];
        }
            break;
        case 1:{
            // 后退
            // 首先判断网页是否可以后退
            if (self.webView.canGoBack) {
                [self.webView goBack];
            }
        }
            break;
        case 2:{
            // 前进
            // 判断是否可以前进
            if (self.webView.canGoForward) {
                [self.webView goForward];
            }
        }
            break;
        case 3:{
            //进行跳转,我们设置跳转的返回到第一个界面
            NSLog(@"%@",self.webView.backForwardList.backList);
            if (self.webView.backForwardList.backList.count >2) {
                [self.webView goToBackForwardListItem:self.webView.backForwardList.backList[0]];
            }
        }
            break;
        default:
            break;
    }
}
```


## 代码

[WKWebView](https://github.com/DaisukeZJY/WKWebview)












 

