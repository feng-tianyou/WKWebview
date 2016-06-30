//
//  ViewController.m
//  WKWebview
//
//  Created by FTY on 16/6/29.
//  Copyright © 2016年 FTY. All rights reserved.
//

#import "ViewController.h"

#import "TestUIWebView.h"
#import "TestWKWebView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) NSArray *titles;

@end

@implementation ViewController

- (NSArray *)titles{
    if (_titles == nil) {
        _titles = @[@"加载本地HTML语言",
                    @"加载网络上HTML语言",
                    @"加载文本地件",
                    @"加载网络上文件",
                    @"以数据形式加载文件"];
    }
    return _titles;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"just a test";
    [self.view addSubview:self.tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"UIWebView";
    } else {
        cell.textLabel.text = @"WKWebView";
    }
    cell.detailTextLabel.text = self.titles[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithWhite:0.498 alpha:0.5];
    if (section == 0) {
        label.text = @"UIWebView";
    } else {
        label.text = @"WKWebView";
    }
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {// UIWebView
            switch (indexPath.row) {
                case 0:
                {
                    // 加载本地HTML语言
                    TestUIWebView *webView = [[TestUIWebView alloc] initWithType:UIWebViewLoadHTMLType];
                    [self.navigationController pushViewController:webView animated:YES];
                }
                    break;
                case 1:
                {
                    // 加载网络上HTML语言
                    TestUIWebView *webView = [[TestUIWebView alloc] initWithType:UIWebViewLoadLineHTMLType];
                    [self.navigationController pushViewController:webView animated:YES];
                }
                    break;
                case 2:
                {
                    // 加载文本地件
                    TestUIWebView *webView = [[TestUIWebView alloc] initWithType:UIWebViewLoadFileType];
                    [self.navigationController pushViewController:webView animated:YES];
                }
                    break;
                case 3:
                {
                    // 加载网络上文件
                    TestUIWebView *webView = [[TestUIWebView alloc] initWithType:UIWebViewLoadLineFileType];
                    [self.navigationController pushViewController:webView animated:YES];
                }
                    break;
                case 4:
                {
                    // 以数据形式加载文件
                    TestUIWebView *webView = [[TestUIWebView alloc] initWithType:UIWebViewLoadDataType];
                    [self.navigationController pushViewController:webView animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {// WKWebView
            switch (indexPath.row) {
                case 0:
                {
                    // 加载本地HTML语言
                    TestWKWebView *webView = [[TestWKWebView alloc] initWithType:WKWebViewLoadHTMLType];
                    [self.navigationController pushViewController:webView animated:YES];
                }
                    break;
                case 1:
                {
                    // 加载网络上HTML语言
                    TestWKWebView *webView = [[TestWKWebView alloc] initWithType:WKWebViewLoadLineHTMLType];
                    [self.navigationController pushViewController:webView animated:YES];
                }
                    break;
                case 2:
                {
                    // 加载文本地件
                    TestWKWebView *webView = [[TestWKWebView alloc] initWithType:WKWebViewLoadFileType];
                    [self.navigationController pushViewController:webView animated:YES];
                }
                    break;
                case 3:
                {
                    // 加载网络上文件
                    TestWKWebView *webView = [[TestWKWebView alloc] initWithType:WKWebViewLoadLineFileType];
                    [self.navigationController pushViewController:webView animated:YES];
                }
                    break;
                case 4:
                {
                    // 以数据形式加载文件
                    TestWKWebView *webView = [[TestWKWebView alloc] initWithType:WKWebViewLoadDataType];
                    [self.navigationController pushViewController:webView animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}





@end
