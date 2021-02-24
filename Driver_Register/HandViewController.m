//
//  HandViewController.m
//  Driver_Register
//
//  Created by didi on 2021/2/4.
//

#import "HandViewController.h"
#import "BasicPageViewController.h"
#import "BasicPageConfigModel.h"
#import <WebKit/WebKit.h>

@interface HandViewController ()

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation HandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self loadWeb];
}

# pragma mark - Private Method

- (void)initView {
    //设置界面和导航栏
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(backToBasicPage)];
    self.navigationItem.leftBarButtonItem = backBtn;
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.frame = CGRectZero;
    titlelabel.text =@"FAQs";
    [titlelabel sizeToFit];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = titlelabel;
}

- (void)backToBasicPage {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)loadWeb {
    NSInteger height = [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, height, self.view.bounds.size.width, self.view.bounds.size.height)];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

# pragma mark - Getter

- (NSURL *)url {
    if (!_url) {
        if (self.BasicOrAudit) {
            _url = [NSURL URLWithString:self.basicFormItem.link];
        }
        else {
            //self.url = [NSURL URLWithString:self.auditFormItem.attach_link.link];
            _url = [NSURL URLWithString:@"https://d.didiglobal.com/faqs"];
        }
    }
    return _url;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [WKWebView new];
    }
    return _webView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
