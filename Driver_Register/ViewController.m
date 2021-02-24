//
//  ViewController.m
//  Driver_Register
//
//  Created by didi on 2021/1/25.
//

#import "ViewController.h"
#import "BasicPageViewController.h"
#import "AuditInfoViewController.h"
#import "RegProgress_req.h"
#import "RegProgressModel.h"

NSString *font = @"Heiti SC";
NSInteger fontsize = 20;

@interface ViewController ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) RegProgress_req *regprogress_reg;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) RegProgressModel *regprogressmodel;
//getRegProgress参数
@property (nonatomic, assign) NSInteger _errno;
@property (nonatomic, copy) NSString *errmsg;
@property (nonatomic, copy) NSString *progress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initStartPage];
    //请求数据
    self.regprogress_reg = [RegProgress_req new];
    [self.regprogress_reg dataTask];
    //注册进度数据
    [self performSelector:@selector(loadRegProgress) withObject:@"1" afterDelay:1.0];
    //[self loadRegProgress];
}

- (void)initStartPage {
    self.view.backgroundColor = [UIColor whiteColor];
    //设置跳转按钮
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(25, 100, 100, 40);
    [self.view addSubview:self.btn];
    [self.btn setTitle:@"register" forState:UIControlStateNormal];
    self.btn.titleLabel.font = [UIFont systemFontOfSize: 25.0];
    [self.btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btn setBackgroundColor:[UIColor whiteColor]];
    //点击按钮跳转
    [self.btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonClicked: (id)sender {
    if ([self.progress isEqual:@"basicInfo"]) {//基础信息页面
        BasicPageViewController *basicpage = [[BasicPageViewController alloc]init];
        [self.navigationController pushViewController:basicpage animated:YES];
    }
    else {//证件信息页面
        AuditInfoViewController *auditinfo = [[AuditInfoViewController alloc]init];
        [self.navigationController pushViewController:auditinfo animated:YES];
    }
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)loadRegProgress {
    //NSLog(@"loadRegProgress");
    self.path = [RegProgress_req getPath];
    NSData *data = [NSData dataWithContentsOfFile:self.path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.regprogressmodel = [[RegProgressModel alloc] initWithDictionary:json error:nil];
    self._errno = self.regprogressmodel._errno;
    self.errmsg = self.regprogressmodel.errmsg;
    self.progress = self.regprogressmodel.data.progress;
    NSLog(@"errno: %ld, errmsg: %@, progress: %@",self._errno, self.errmsg, self.progress);
}

@end
