//
//  TestUIWebView.m
//  WKWebview
//
//  Created by FTY on 16/6/30.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import "TestUIWebView.h"

@interface TestUIWebView ()

@property (nonatomic, strong) UIWebView *webView;

@property (assign, nonatomic) UIWebViewLoadType type;


@end

@implementation TestUIWebView

- (instancetype)initWithType:(UIWebViewLoadType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        // 自动检测所有信息，像地址或者电话（拨打）等建立链接
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        [_webView sizeToFit];
        _webView.allowsInlineMediaPlayback = YES;
        _webView.allowsLinkPreview = YES;
        _webView.allowsPictureInPictureMediaPlayback = YES;
        _webView.mediaPlaybackAllowsAirPlay = YES;
        _webView.mediaPlaybackRequiresUserAction = YES;
        _webView.multipleTouchEnabled = YES;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.webView];
    
    switch (self.type) {
        case UIWebViewLoadHTMLType:
        {
            self.title = @"加载本地HTML语言";
            [self loadHTML];
        }
            break;
        case UIWebViewLoadLineHTMLType:
        {
            self.title = @"加载网络上HTML语言";
            [self loadLineHTML];
        }
            break;
        case UIWebViewLoadFileType:
        {
            self.title = @"加载文本地件";
            [self loadFile];
        }
            break;
        case UIWebViewLoadLineFileType:
        {
            self.title = @"加载网络上文件";
            [self loadLineFile];
        }
            break;
        case UIWebViewLoadDataType:
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
//            NSLog(@"%@",self.webView.backForwardList.backList);
//            if (self.webView.backForwardList.backList.count >2) {
//                [self.webView goToBackForwardListItem:self.webView.backForwardList.backList[0]];
//            }
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
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test.html" ofType:nil];
    NSString *htmlStr = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlStr baseURL:nil];
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
    [self.webView loadHTMLString:lineHtmlStr baseURL:nil];
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
    
    NSURL *lineFileURL = [NSURL URLWithString:@"http://img1.imgtn.bdimg.com/it/u=2778058058,3407162019&fm=21&gp=0.jpg"];
    
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
    __weak TestUIWebView *weakSelf = self;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [weakSelf.webView loadData:data MIMEType:response.MIMEType textEncodingName:@"UTF8" baseURL:[NSURL URLWithString:@""]];
    }];
    [dataTask resume];
}














@end
