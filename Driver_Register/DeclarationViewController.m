//
//  DeclarationViewController.m
//  Driver_Register
//
//  Created by didi on 2021/2/24.
//

#import "DeclarationViewController.h"
#import <Masonry/Masonry.h>

extern NSString *font;

@interface DeclarationViewController ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *desctitleLabel;
@property (nonatomic, strong) UIButton *chooseBtn;
@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, assign) BOOL required;
@property (nonatomic, assign) BOOL chooseFlag;

@end

@implementation DeclarationViewController

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
    
    self.required = self.auditFormItem.required;
    self.chooseFlag = NO;
    if (!self.required || self.hasSubmit) {
        self.chooseBtn.hidden = YES;
        self.desctitleLabel.hidden = YES;
        self.submitBtn.hidden = YES;
    }
}

- (void)setUpViews {
    self.view.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subtitleLabel];
    [self.contentView addSubview:self.descLabel];
    [self.view addSubview:self.chooseBtn];
    [self.view addSubview:self.desctitleLabel];
    [self.view addSubview:self.submitBtn];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
        make.top.equalTo(self.submitBtn.mas_bottom).with.offset(-60);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
    }];
    [self setSubmitBtn];
    
    [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.submitBtn.mas_top).with.offset(-20);
        make.top.equalTo(self.chooseBtn.mas_bottom).with.offset(-20);
        make.left.equalTo(self.submitBtn.mas_left).with.offset(0);
        make.right.equalTo(self.chooseBtn.mas_left).with.offset(20);
    }];
    
    [self.desctitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.chooseBtn);
        make.left.equalTo(self.chooseBtn.mas_right).with.offset(5);
        make.right.equalTo(self.submitBtn.mas_right).with.offset(0);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(90);
        make.bottom.equalTo(self.desctitleLabel.mas_top).with.offset(-10);
        make.left.right.equalTo(self.view);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.bottom.equalTo(self.titleLabel.mas_top).with.offset(40);
    }];
    
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(0);
        make.left.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.subtitleLabel.mas_top).with.offset(50);
    }];
    
    NSInteger height;
    if (self.status == 2) {
        height = 320;
    }
    else {
        height = 380;
    }
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subtitleLabel.mas_bottom).with.offset(0);
        make.left.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.descLabel.mas_top).with.offset(height);
    }];
}

- (void)setSubmitBtn {
    if (self.chooseFlag) {
        [self.submitBtn setBackgroundColor:[UIColor orangeColor]];
        [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.chooseBtn setBackgroundColor:[UIColor orangeColor]];
        [self.chooseBtn setTitle:@"✓" forState:UIControlStateNormal];
        [self.chooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = YES;
    }
    else {
        [self.submitBtn setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:240.0/255.0 alpha:1]];
        [self.submitBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.chooseBtn setBackgroundColor:[UIColor whiteColor]];
        [self.chooseBtn setTitle:@"" forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = NO;
    }
}

#pragma mark - Getter

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = UIColor.clearColor;
        _titleLabel.text = self.auditFormItem.title;
        _titleLabel.textColor = UIColor.blackColor;
        [_titleLabel setFont:[UIFont fontWithName:font size:24]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subtitleLabel.backgroundColor = UIColor.clearColor;
        _subtitleLabel.text = self.auditFormItem.sub_title;
        _subtitleLabel.textColor = UIColor.blackColor;
        _subtitleLabel.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
        _subtitleLabel.numberOfLines = 2;
        [_subtitleLabel setFont:[UIFont fontWithName:font size:15]];
        _subtitleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _subtitleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _descLabel.backgroundColor = UIColor.clearColor;
        NSMutableString *textStr = [[NSMutableString alloc]init];
        NSInteger count = [self.auditFormItem.content count];
        for (NSInteger i=0;i<count;i++) {
            [textStr appendString:self.auditFormItem.content[i]];
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

- (UIButton *)chooseBtn {
    if (!_chooseBtn) {
        _chooseBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_chooseBtn setBackgroundColor:[UIColor whiteColor]];
        _chooseBtn.layer.cornerRadius = 10;
        [_chooseBtn addTarget:self action:@selector(chooseInsuranceDeclaration) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseBtn;
}

- (UILabel *)desctitleLabel {
    if (!_desctitleLabel) {
        _desctitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _desctitleLabel.backgroundColor = UIColor.clearColor;
        _desctitleLabel.text = self.auditFormItem.desc_title;
        _desctitleLabel.textColor = UIColor.grayColor;
        [_desctitleLabel setFont:[UIFont fontWithName:font size:16]];
        _desctitleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _desctitleLabel;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
        [_submitBtn.titleLabel setFont:[UIFont fontWithName:font size:20]];
        _submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_submitBtn addTarget:self action:@selector(commitInsuranceDeclaration) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

#pragma mark - Response Event

- (void)backToAuditPage {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)chooseInsuranceDeclaration {
    self.chooseFlag = !self.chooseFlag;
    [self setSubmitBtn];
}

- (void)commitInsuranceDeclaration {
    NSLog(@"commit insurance declaration");
    //
    //修改field_status,设置hasSubmit为YES
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
