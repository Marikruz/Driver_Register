//
//  DriverLicenceViewController.m
//  Driver_Register
//
//  Created by didi on 2021/2/20.
//

#import "DriverLicenceViewController.h"
#import <Masonry/Masonry.h>

#define PicHeight 110.f

extern NSString *font;

@interface DriverLicenceViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *frontLabel;
@property (nonatomic, strong) UIButton *frontBtn;
@property (nonatomic, strong) UILabel *backLabel;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *submit;
@property (nonatomic, strong) UIAlertController *actionsheet;

@property (nonatomic, assign) BOOL setFrontPicFlag;
@property (nonatomic, assign) BOOL setBackPicFlag;
@property (nonatomic, assign) NSInteger picnum;

@end

@implementation DriverLicenceViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self setUpViews];
}

# pragma mark - Private Method

- (void)initView {
    //设置界面和导航栏
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(backToAuditPage)];
    self.navigationItem.leftBarButtonItem = backBtn;
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.frame = CGRectZero;
    titlelabel.text =@"Register";
    [titlelabel sizeToFit];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = titlelabel;
    
    self.picnum = 0;
    self.setFrontPicFlag = NO;
    self.setBackPicFlag = NO;
}

- (void)setUpViews {
    self.view.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.descLabel];
    [self.view addSubview:self.frontLabel];
    [self.view addSubview:self.frontBtn];
    [self.view addSubview:self.backLabel];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.submit];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(90);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.titleLabel.mas_top).with.offset(50);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.bottom.equalTo(self.titleLabel.mas_bottom).with.offset(100);
    }];
    
    [self.frontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLabel.mas_bottom).with.offset(15);
        make.left.equalTo(self.descLabel.mas_left).with.offset(0);
        make.right.equalTo(self.descLabel.mas_right).with.offset(0);
        make.bottom.equalTo(self.frontLabel.mas_top).with.offset(30);
    }];
    
    [self.frontBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.frontLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.frontLabel.mas_left).with.offset(0);
        make.right.equalTo(self.frontBtn.mas_left).with.offset(PicHeight);
        make.bottom.equalTo(self.frontBtn.mas_top).with.offset(PicHeight);
    }];
    
    [self.backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.frontBtn.mas_bottom).with.offset(5);
        make.left.equalTo(self.descLabel.mas_left).with.offset(0);
        make.right.equalTo(self.descLabel.mas_right).with.offset(0);
        make.bottom.equalTo(self.backLabel.mas_top).with.offset(30);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.backLabel.mas_left).with.offset(0);
        make.right.equalTo(self.backBtn.mas_left).with.offset(PicHeight);
        make.bottom.equalTo(self.backBtn.mas_top).with.offset(PicHeight);
    }];
    
    [self.submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
        make.top.equalTo(self.submit.mas_bottom).with.offset(-60);
        make.left.equalTo(self.descLabel.mas_left).with.offset(0);
        make.right.equalTo(self.descLabel.mas_right).with.offset(0);
    }];
    self.submit.userInteractionEnabled = NO;
    [self setSubmitBtn];

}

- (void)setSubmitBtn {
    if (self.picnum == 2) {
        [self.submit setBackgroundColor:[UIColor orangeColor]];
        [_submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.submit.userInteractionEnabled = YES;
    }
    else {
        [self.submit setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:240.0/255.0 alpha:1]];
    }
}

# pragma mark - Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = UIColor.clearColor;
        _titleLabel.text = self.auditFormItem.pic_desc.title;
        _titleLabel.textColor = UIColor.blackColor;
        [_titleLabel setFont:[UIFont fontWithName:font size:25]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descLabel.backgroundColor = UIColor.clearColor;
        NSMutableString *textStr = [[NSMutableString alloc]init];
        NSInteger count = [self.auditFormItem.pic_desc.content count];
        for (NSInteger i=0;i<count;i++) {
            [textStr appendString:self.auditFormItem.pic_desc.content[i]];
            if (i != (count-1))
                [textStr appendString:@"\n"];
        }
        _descLabel.text = textStr;
        _descLabel.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
        _descLabel.numberOfLines = count;
        _descLabel.textColor = UIColor.grayColor;
        [_descLabel setFont:[UIFont fontWithName:font size:16]];
        _descLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _descLabel;
}

- (UILabel *)frontLabel {
    if (!_frontLabel) {
        _frontLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _frontLabel.backgroundColor = UIColor.clearColor;
        _frontLabel.text = self.auditFormItem.pic_field[0].title;
        _frontLabel.textColor = UIColor.grayColor;
        [_frontLabel setFont:[UIFont fontWithName:font size:16]];
        _frontLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _frontLabel;
}

//UIButton显示图片 https://www.jianshu.com/p/091c5fdc082e?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation

- (UIButton *)frontBtn {
    if (!_frontBtn) {
        _frontBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        _frontBtn.backgroundColor = UIColor.whiteColor;
        [_frontBtn addTarget:self action:@selector(chooseFrontPic) forControlEvents:UIControlEventTouchUpInside];
    }
    return _frontBtn;
}

- (UILabel *)backLabel {
    if (!_backLabel) {
        _backLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _backLabel.backgroundColor = UIColor.clearColor;
        _backLabel.text = self.auditFormItem.pic_field[1].title;
        _backLabel.textColor = UIColor.grayColor;
        [_backLabel setFont:[UIFont fontWithName:font size:16]];
        _backLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _backLabel;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        _backBtn.backgroundColor = UIColor.whiteColor;
        [_backBtn addTarget:self action:@selector(chooseBackPic) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIButton *)submit {
    if (!_submit) {
        _submit = [[UIButton alloc]initWithFrame:CGRectZero];
        [_submit setTitle:@"Submit" forState:UIControlStateNormal];
        [_submit.titleLabel setFont:[UIFont fontWithName:font size:20]];
        [_submit setTitleColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1] forState:UIControlStateNormal];
        _submit.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_submit addTarget:self action:@selector(commitDriverLicence) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submit;
}

#pragma mark - Response Event

- (void)backToAuditPage {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)chooseFrontPic {
    [self createActionSheet];
    if (!self.setFrontPicFlag) {
        self.picnum = self.picnum+1>2?2:self.picnum+1;
        [self setSubmitBtn];
        self.setFrontPicFlag = !self.setFrontPicFlag;
    }
}

- (void)chooseBackPic {
    [self createActionSheet];
    if (!self.setBackPicFlag) {
        self.picnum = self.picnum+1>2?2:self.picnum+1;
        [self setSubmitBtn];
        self.setBackPicFlag = !self.setBackPicFlag;
    }
}

- (void)createActionSheet {
    //创建
    self.actionsheet = [[UIAlertController alloc] init];
    //添加按钮
    UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:@"Take a picture" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"picture action");
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"Album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"album action");
        /*
         从相册选择图片
         */
        //
        //
        //
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"cancel action");
    }];
    [self.actionsheet addAction:pictureAction];
    [self.actionsheet addAction:albumAction];
    [self.actionsheet addAction:cancelAction];
    //显示
    [self presentViewController:self.actionsheet animated:YES completion:nil];
}

- (void)commitDriverLicence {
    NSLog(@"commit driver licence");
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
