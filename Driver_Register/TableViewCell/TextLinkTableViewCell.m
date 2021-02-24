//
//  TextLinkTableViewCell.m
//  Driver_Register
//
//  Created by didi on 2021/2/3.
//

#import "TextLinkTableViewCell.h"
#import <Masonry/Masonry.h>

extern NSString *font;

@interface TextLinkTableViewCell()

@property (nonatomic, strong) UIButton *textBtn;

@end

@implementation TextLinkTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.textBtn setTitle:self.model.title forState:UIControlStateNormal];
    [self.textBtn.titleLabel setFont:[UIFont fontWithName:font size:16]];
    [self.textBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.textBtn addTarget:self action:@selector(obtainABN) forControlEvents:UIControlEventTouchUpInside];
}

# pragma mark - Private Method

- (void)setupViews {
    [self.contentView addSubview:self.textBtn];
    [self.textBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
    }];
}

- (void)obtainABN {
    [self.controller jumpToObtainABN];
}

# pragma mark - Getter

- (UIButton *)textBtn {
    if (!_textBtn) {
        _textBtn = UIButton.new;
    }
    return _textBtn;
}

@end
