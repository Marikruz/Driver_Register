//
//  BannerTableViewCell.m
//  Driver_Register
//
//  Created by didi on 2021/2/9.
//

#import "BannerTableViewCell.h"
#import <Masonry/Masonry.h>

extern NSString *font;

@interface BannerTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BannerTableViewCell

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
    
    self.titleLabel.text = self.model.desc;
    [self.titleLabel setFont:[UIFont fontWithName:font size:16]];
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
    self.titleLabel.numberOfLines = 3;
}

#pragma mark - Private Method

- (void)setupViews {
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
    }];
}

#pragma mark - Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
    }
    return _titleLabel;
}

@end
