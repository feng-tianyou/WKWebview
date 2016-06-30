//
//  TestUIWebView.h
//  WKWebview
//
//  Created by FTY on 16/6/30.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIWebViewLoadType) {
    UIWebViewLoadHTMLType,
    UIWebViewLoadLineHTMLType,
    UIWebViewLoadFileType,
    UIWebViewLoadLineFileType,
    UIWebViewLoadDataType
};

@interface TestUIWebView : UIViewController

- (instancetype)initWithType:(UIWebViewLoadType)type;

@end
