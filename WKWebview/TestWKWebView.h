//
//  TestWKWebView.h
//  WKWebview
//
//  Created by FTY on 16/6/30.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WKWebViewLoadType) {
    WKWebViewLoadHTMLType,
    WKWebViewLoadLineHTMLType,
    WKWebViewLoadFileType,
    WKWebViewLoadLineFileType,
    WKWebViewLoadDataType
};

@interface TestWKWebView : UIViewController

- (instancetype)initWithType:(WKWebViewLoadType)type;

@end
