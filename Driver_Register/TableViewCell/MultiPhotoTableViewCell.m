//
//  MultiPhotoTableViewCell.m
//  Driver_Register
//
//  Created by didi on 2021/2/8.
//

#import "MultiPhotoTableViewCell.h"
#import <Masonry/Masonry.h>

extern NSString *font;
extern NSInteger fontsize;

@interface MultiPhotoTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *jumpLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UILabel *checkLabel;

@end

@implementation MultiPhotoTableViewCell

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
    
    self.jumpLabel.text = @">";
    [self.jumpLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:fontsize]];
    self.jumpLabel.textColor = [UIColor blackColor];
    
    self.lineLabel.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    
    self.checkLabel.text = self.model.field_result;
    switch (self.model.field_status) {
        case 5:
        {
            self.checkLabel.textColor = UIColor.redColor;
            self.checkLabel.font = [UIFont fontWithName:font size:16];
            self.checkLabel.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
            self.checkLabel.numberOfLines = 2;
        }
            break;
        default:
        {
            self.checkLabel.textColor = UIColor.grayColor;
            self.checkLabel.font = [UIFont fontWithName:font size:16];
        }
            break;
    }
}

#pragma mark - Private Method

- (void)setupViews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.jumpLabel];
    [self.contentView addSubview:self.lineLabel];
    [self.contentView addSubview:self.checkLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(25);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
    }];
    
    [self.jumpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_top).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
    }];
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(75);
        make.left.equalTo(self.titleLabel.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_top).with.offset(77);
    }];
    
    [self.checkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineLabel.mas_bottom).with.offset(0);
        make.left.equalTo(self.titleLabel.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
    }];
}

#pragma mark - Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
    }
    return _titleLabel;
}

- (UILabel *)jumpLabel {
    if (!_jumpLabel) {
        _jumpLabel = UILabel.new;
    }
    return _jumpLabel;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = UILabel.new;
    }
    return _lineLabel;
}

- (UILabel *)checkLabel {
    if (!_checkLabel) {
        _checkLabel = UILabel.new;
    }
    return _checkLabel;
}

@end
