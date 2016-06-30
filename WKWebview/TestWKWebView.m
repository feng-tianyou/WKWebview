//
//  TestWKWebView.m
//  WKWebview
//
//  Created by FTY on 16/6/30.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import "TestWKWebView.h"
#import <WebKit/WebKit.h>

@interface TestWKWebView ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
/**
 *  加载类型
 */
@property (assign, nonatomic) WKWebViewLoadType type;
/**
 *  进度条
 */
@property (strong, nonatomic) UIProgressView *progressView;
@end

@implementation TestWKWebView

- (instancetype)initWithType:(WKWebViewLoadType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.webView];
    
    switch (self.type) {
        case WKWebViewLoadHTMLType:
        {
            self.title = @"加载本地HTML语言";
            [self loadHTML];
        }
            break;
        case WKWebViewLoadLineHTMLType:
        {
            self.title = @"加载网络上HTML语言";
            [self loadLineHTML];
        }
            break;
        case WKWebViewLoadFileType:
        {
            self.title = @"加载文本地件";
            [self loadFile];
        }
            break;
        case WKWebViewLoadLineFileType:
        {
            self.title = @"加载网络上文件";
            [self loadLineFile];
        }
            break;
        case WKWebViewLoadDataType:
        {
            self.title = @"以数据形式加载文件";
            [self loadData];
        }
            break;
            
        default:
            break;
    }
    
    
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
}


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


#pragma mark - 加载HTML语言
- (void)loadHTML{
    /**
     *  应用场景：只加载网页的某一部分
     *  例如：完整的网页可能包含广告部分，但是又不想要广告，所以我们可以加载整个网页，然后截取想要的部分，再加载
     */
    
    /**
     *  现在要加载一个HTML文件，里面的内容是
     <html xmlns:v="urn:schemas-microsoft-com:vml"
     xmlns:o="urn:schemas-microsoft-com:office:office"
     xmlns:w="urn:schemas-microsoft-com:office:word"
     xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882"
     xmlns:m="http://schemas.microsoft.com/office/2004/12/omml"
     xmlns="http://www.w3.org/TR/REC-html40">
     <head>
     </head>
     <body bgcolor=white lang=ZH-CN link=blue vlink=purple style='tab-interval:21.0pt;
     text-justify-trim:punctuation'>
     <p>这是HTML文件里面的内容，当然，你可以完全加载一个完整的HTML。TODO</p>
     </body>
     </html>
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

#pragma mark - 加载HTML语言
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

#pragma mark - 加载本地文件
- (void)loadFile{
    
    // 很多时候，我们并不想加载HTML文件，或者说我们没有HTML文件，因为从服务器下载出来的文件并不都是HTML格式，那么可以加载其他格式的文件吗？答案是YES
    // 文件有很多格式，常见的有：txt, PDF, doc, excel, gif, 图片等
    
    // 获取文件路径
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"The Swift Programming Language 中文版 - v1.2.pdf" withExtension:nil];
    // 建立连接
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:fileURL];
    [self.webView loadRequest:request];
}

#pragma mark - 加载本地文件
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


#pragma mark - 以数据形式加载文件
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


#pragma mark - WKNavigationDelegate


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
// 计算webView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
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


@end
