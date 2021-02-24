//
//  InputTableViewCell.m
//  Driver_Register
//
//  Created by didi on 2021/1/28.
//

#import "InputTableViewCell.h"
#import "BasicPageViewController.h"
#import <Masonry/Masonry.h>

extern NSString *font;
extern NSInteger fontsize;
extern BOOL checkDriverLicenceNoFlag;
extern BOOL checkABNNoFlag;

@interface InputTableViewCell()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, assign) BOOL required;
@property (nonatomic, assign) NSInteger max_length;
@property (nonatomic, copy) NSString *format;
@property (nonatomic, assign) BOOL clear_format;

@property (nonatomic, strong) UIView *checkView;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UILabel *checkLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *valueTextField;

@end

@implementation InputTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 0;
    frame.origin.y += 0;
    frame.size.height -= 5;
    frame.size.width -= 0;
    [super setFrame:frame];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.text = @" ";
    [self.titleLabel setFont:[UIFont fontWithName:font size:16]];
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.text = self.model.title;
    if ([self.valueTextField.text isEqual:@""]) {
        self.titleLabel.hidden = YES;
    }
    self.valueTextField.placeholder = self.model.title;
    [self.valueTextField setFont:[UIFont fontWithName:font size:fontsize]];
    [self.valueTextField addTarget:self action:@selector(textContentChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 1)];
    self.lineLabel.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    self.checkLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 400, 20)];
    self.checkLabel.backgroundColor = [UIColor whiteColor];
    self.checkLabel.font = [UIFont fontWithName:font size:16];
    [self.checkView addSubview:self.lineLabel];
    [self.checkView addSubview:self.checkLabel];
    self.checkView.hidden = YES;
    
    if ([self.model.title isEqual:@"Driver Licence No."] || [self.model.title isEqual:@"ABN No."]) {
        [self.valueTextField addTarget:self action:@selector(checkNo:) forControlEvents:UIControlEventEditingChanged];
    }
    else {
        [self.valueTextField addTarget:self action:@selector(commitName:) forControlEvents:UIControlEventEditingChanged];
    }
    
}

- (void)setupViews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.valueTextField];
    [self.contentView addSubview:self.checkView];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(8);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
    }];
    
    [self.valueTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(12);
        make.left.equalTo(self.titleLabel.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
    }];
    
    [self.checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(75);
        make.left.equalTo(self.titleLabel.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-5);
    }];
}

# pragma mark - Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
    }
    return _titleLabel;
}

- (UITextField *)valueTextField {
    if (!_valueTextField) {
        _valueTextField = UITextField.new;
    }
    return _valueTextField;
}

- (UIView *)checkView {
    if (!_checkView) {
        _checkView = UIView.new;
    }
    return _checkView;
}

# pragma mark - Private Method

- (void)textContentChanged:(UITextField *)textField {
    if ([self.valueTextField.text isEqual:@""]) {
        self.titleLabel.hidden = YES;
    }
    else {
        self.titleLabel.hidden = NO;
    }
}

- (NSString *)convert:(BOOL)flag {
    if (flag == YES)
        return @"YES";
    return @"NO";
}

- (void)checkNo:(UITextField *)textField {
    NSString *input_no = self.valueTextField.text;
    //刷新cell
    if ([self.model.title isEqual:@"Driver Licence No."]) {//check driver licence no
        [BasicPageViewController setDriverLicenceNoFlag:NO];
        NSIndexPath *indexPath_driverlicenceno = [NSIndexPath indexPathForRow:5 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath_driverlicenceno,nil] withRowAnimation:UITableViewRowAnimationNone];
        if (![self checkDriverLicenceNo:input_no]) {//wrong driver licence no
            [self showWrongCheckView];
        }
        else {//correct driver licence no
            self.controller.commit_driverlicenceno = input_no;
            [self showCorrectCheckView];
        }
        
    }
    if ([self.model.title isEqual:@"ABN No."]) {//check abn no
        [BasicPageViewController setABNNoFlag:NO];
//        NSLog(@"ABNNoFlag: %@", [self convert:checkABNNoFlag]);
        NSIndexPath *indexPath_abnno = [NSIndexPath indexPathForRow:6 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath_abnno,nil] withRowAnimation:UITableViewRowAnimationNone];
        if (![self checkABNNo:input_no]) {//wrong abn no
            [self showWrongCheckView];
        }
        else {//correct abn no
            self.controller.commit_abnno = input_no;
            [self showCorrectCheckView];
        }
    }
}

- (BOOL)checkDriverLicenceNo:(NSString *)input {//检查结果
    //checkId
    //
    //
    //
    return NO;
}

- (BOOL)checkABNNo:(NSString *)input {//检查结果
    //checkId
    //
    //
    //
    return YES;
}

- (void)commitName:(UITextField *)textField {
    if ([self.model.title isEqual:@"First name"]) {
        self.controller.commit_firstname = textField.text;
    }
    else {
        self.controller.commit_lastname = textField.text;
    }
}

- (void)showWrongCheckView {
    self.checkView.hidden = NO;
    self.checkLabel.text = [[NSString alloc]initWithFormat:@"%@%@",@"Please enter the correct ",self.model.title];
    self.checkLabel.textColor = [UIColor redColor];
}

- (void)showCorrectCheckView {
    self.checkView.hidden = NO;
    self.checkLabel.text = @"Checking";
    self.checkLabel.textColor = [UIColor grayColor];
    [self performSelector:@selector(checkOK) withObject:@"5" afterDelay:2];
}

- (void)checkOK {
    self.checkView.hidden = YES;
}

@end
