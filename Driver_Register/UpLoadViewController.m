//
//  UpLoadViewController.m
//  Driver_Register
//
//  Created by didi on 2021/2/23.
//

#import "UpLoadViewController.h"
#import <Masonry/Masonry.h>

extern NSString *font;

@interface UpLoadViewController ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *imgView;
@property (nonatomic, strong) UIImageView *passportimg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *submitConfir;
@property (nonatomic, strong) UIButton *submit;
@property (nonatomic, strong) UIAlertController *actionsheet;

@property (nonatomic, copy) NSString *picStr;
@property (nonatomic, assign) BOOL uploadOrReupload;//NO:upload  YES:reupload

@property (nonatomic, assign) BOOL uploadType;//NO:使用UICollecitonView minpicnum==maxpicnum YES:不使用UICollecitonView minpicnum<maxpicnum
@property (nonatomic, assign) NSInteger picnum;
@property (nonatomic, assign) NSInteger minpicnum;
@property (nonatomic, assign) NSInteger maxpicnum;

@end

@implementation UpLoadViewController

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
    
    self.picStr = @"";
    self.uploadOrReupload = NO;
    
    self.picnum = 0;
    switch (self.status) {
        case 1:
        case 5:
        {
            self.minpicnum = self.auditFormItem.pic_field[0].min_pic_num;
            self.maxpicnum = self.auditFormItem.pic_field[0].max_pic_num;
        }
            break;
        case 3:
        case 4:
        {
            self.minpicnum = self.auditFormItem.min_pic_num;
            self.maxpicnum = self.auditFormItem.max_pic_num;
        }
            break;
        default:
            break;
    }
    if (self.minpicnum == self.maxpicnum)
        self.uploadType = YES;
    else
        self.uploadType = NO;
}

- (void)setUpViews {
    self.view.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.imgView];
    [self.imgView addSubview:self.passportimg];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descLabel];
    [self.view addSubview:self.submit];
    [self.view addSubview:self.submitConfir];
    
    [self.submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
        make.top.equalTo(self.submit.mas_bottom).with.offset(-60);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
    }];
    if (self.uploadType) {
        [self setUploadBtn];
    }
    else {
        [self setSubmitBtn];
    }
    
    [self.submitConfir mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.submit.mas_top).with.offset(-10);
        make.top.equalTo(self.submitConfir.mas_bottom).with.offset(-60);
        make.left.right.equalTo(self.submit);
    }];
    self.submitConfir.hidden = YES;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(90);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.submit.mas_top).with.offset(-20);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.imgView.mas_top).with.offset(320);
    }];
    
    NSInteger topwidth;
    NSInteger leftwidth;
    switch (self.status) {
        case 1:
        case 5:
        {
            topwidth = 25;
            leftwidth = 40;
        }
            break;
        case 3:
        {
            topwidth = 20;
            leftwidth = 50;
        }
            break;
        case 4:
        {
            topwidth = 75;
            leftwidth = 40;
        }
            break;
        default:
        {
            topwidth = 0;
            leftwidth = 0;
        }
            break;
    }
    [self.passportimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_top).with.offset(topwidth);
        make.left.equalTo(self.imgView.mas_left).with.offset(leftwidth);
        make.right.equalTo(self.imgView.mas_right).with.offset(0-leftwidth);
        make.bottom.equalTo(self.imgView.mas_bottom).with.offset(0-topwidth);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.titleLabel.mas_top).with.offset(50);
    }];
    
    NSInteger descheight;
    switch (self.status) {
        case 1:
            descheight = 220;
            break;
        case 3:
            descheight = 200;
            break;
        case 4:
            descheight = 270;
            break;
        case 5:
            descheight = 340;
            break;
        default:
            descheight = 0;
            break;
    }
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(-10);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.bottom.equalTo(self.titleLabel.mas_bottom).with.offset(descheight);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.descLabel.mas_bottom);
    }];
}

- (void)setUploadBtn {
//    if (self.picnum >= 1) {
        [self.submit setBackgroundColor:[UIColor orangeColor]];
        [self.submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.submit.userInteractionEnabled = YES;
//    }
//    else {
//        [self.submit setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:240.0/255.0 alpha:1]];
//        self.submit.userInteractionEnabled = NO;
//    }
}

- (void)setSubmitBtn {
    if (self.picnum >= 1) {
        [self.submit setBackgroundColor:[UIColor orangeColor]];
        [self.submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.submit.userInteractionEnabled = YES;
    }
    else {
        [self.submit setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:240.0/255.0 alpha:1]];
        [self.submit setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
        self.submit.userInteractionEnabled = NO;
    }
}

#pragma mark - Getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    }
    return _contentView;
}

- (UIView *)imgView {
    if (!_imgView) {
        _imgView = [[UIView alloc] initWithFrame:CGRectZero];
        _imgView.backgroundColor = UIColor.blackColor;
    }
    return _imgView;
}

- (UIImageView *)passportimg {
    if (!_passportimg) {
        _passportimg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _passportimg.backgroundColor = UIColor.whiteColor;
        if (self.status == 1||self.status == 4)
            _passportimg.layer.cornerRadius = 23;
        [_passportimg setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.auditFormItem.exam_pic_url[0]]]]];
        _passportimg.contentMode = UIViewContentModeScaleToFill;
    }
    return _passportimg;
}

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
        _descLabel = [[UILabel alloc]initWithFrame:CGRectZero];
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
        _descLabel.numberOfLines = 20;
        _descLabel.textColor = UIColor.grayColor;
        [_descLabel setFont:[UIFont fontWithName:font size:15]];
        _descLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _descLabel;
}

- (UIButton *)submitConfir {
    if (!_submitConfir) {
        _submitConfir = [[UIButton alloc]initWithFrame:CGRectZero];
        [_submitConfir setTitle:@"Submit" forState:UIControlStateNormal];
        [_submitConfir.titleLabel setFont:[UIFont fontWithName:font size:18]];
        _submitConfir.layer.cornerRadius = 5;
        _submitConfir.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_submitConfir setBackgroundColor:[UIColor orangeColor]];
        [_submitConfir setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitConfir addTarget:self action:@selector(commitPic) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitConfir;
}

- (UIButton *)submit {
    if (!_submit) {
        _submit = [[UIButton alloc]initWithFrame:CGRectZero];
        _submit.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        if (self.uploadType) {
            [_submit setTitle:@"UPLOAD" forState:UIControlStateNormal];
            [_submit.titleLabel setFont:[UIFont fontWithName:font size:18]];
            _submit.layer.cornerRadius = 5;
            [_submit addTarget:self action:@selector(clickUpLoad) forControlEvents:UIControlEventTouchUpInside];
        }
        else {
            [_submit setTitle:@"Submit" forState:UIControlStateNormal];
            [_submit.titleLabel setFont:[UIFont fontWithName:font size:20]];
            [_submit addTarget:self action:@selector(commitProofOfIdentity) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _submit;
}

#pragma mark - Response Event

- (void)backToAuditPage {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)clickUpLoad {
    if (!self.uploadOrReupload) {
        [self createActionSheet];
    }
    else {//reupload
        self.picStr = @"";
        [self.passportimg setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.auditFormItem.exam_pic_url[0]]]]];
        self.titleLabel.hidden = NO;
        self.descLabel.hidden = NO;
        self.submitConfir.hidden = YES;
        [self.submit setTitle:@"UPLOAD" forState:UIControlStateNormal];
        [self.submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.submit setBackgroundColor:[UIColor orangeColor]];
    }
    self.uploadOrReupload = !self.uploadOrReupload;
}

- (void)createActionSheet {
    //创建
    self.actionsheet = [[UIAlertController alloc] init];
    if (self.uploadType) {
        //添加按钮
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            /*
             从相册选择图片,得到图片路径picStr
             */
            self.picStr = @"sun1.jpg";
            [self upLoad];
        }];
        UIAlertAction *browseAction = [UIAlertAction actionWithTitle:@"Browse" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //
            //得到picStr
            //
            self.picStr = @"sun2.jpg";
            [self upLoad];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancel action");
        }];
        [self.actionsheet addAction:photoAction];
        [self.actionsheet addAction:browseAction];
        [self.actionsheet addAction:cancelAction];
    }
    else {
        //添加按钮
        UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:@"Take a picture" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"picture action");
        }];
        UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"Album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"album action");
            /*
             从相册选择图片,得到图片路径picStr
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
    }
    //显示
    [self presentViewController:self.actionsheet animated:YES completion:nil];
}

- (void)upLoad {
    [self.passportimg setImage:[UIImage imageNamed:self.picStr]];
    self.titleLabel.hidden = YES;
    self.descLabel.hidden = YES;
    self.submitConfir.hidden = NO;
    [self.submit setTitle:@"REUPLOAD" forState:UIControlStateNormal];
    [self.submit setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.submit setBackgroundColor:[UIColor whiteColor]];
    [self.submit.layer setBorderWidth:1];//边框宽度
    [self.submit.layer setBorderColor:UIColor.orangeColor.CGColor];//边框颜色
}

- (void)commitProofOfIdentity {
    NSLog(@"commit proof of identity");
    //
    //修改field_status
    //
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)commitPic {
    NSLog(@"commit portrait, pic: %@", self.picStr);
    //
    //修改field_status,上传picStr
    //
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
