//
//  DateTableViewCell.m
//  Driver_Register
//
//  Created by didi on 2021/1/28.
//

#import "DateTableViewCell.h"
#import "BasicPageViewController.h"
#import <Masonry/Masonry.h>

extern NSString *font;
extern NSInteger fontsize;

@interface DateTableViewCell()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, assign) BOOL required;

@property (nonatomic, copy) NSString *choosedDate;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *jumpLabel;

@end

@implementation DateTableViewCell

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
    self.titleLabel.text = self.model.title;
    [self.titleLabel setFont:[UIFont fontWithName:font size:fontsize]];
    self.titleLabel.textColor = [UIColor blackColor];
    self.dateLabel.text = self.choosedDate;
    [self.dateLabel setFont:[UIFont fontWithName:font size:fontsize]];
    self.dateLabel.textColor = [UIColor blackColor];
    self.jumpLabel.text = @">";
    [self.jumpLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:fontsize]];
    self.jumpLabel.textColor = [UIColor blackColor];
}

- (void)setupViews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.jumpLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(25);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_top).with.offset(0);
        make.right.equalTo(self.jumpLabel.mas_left).with.offset(-5);
    }];
    
    [self.jumpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_top).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
    }
    return _titleLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = UILabel.new;
    }
    return _dateLabel;
}

- (UILabel *)jumpLabel {
    if (!_jumpLabel) {
        _jumpLabel = UILabel.new;
    }
    return _jumpLabel;
}

- (NSString *)choosedDate {
    return [BasicPageViewController getChoosedDate];
}

@end
