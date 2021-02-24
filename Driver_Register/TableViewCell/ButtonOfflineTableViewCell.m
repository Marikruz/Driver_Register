//
//  ButtonOfflineTableViewCell.m
//  Driver_Register
//
//  Created by didi on 2021/2/3.
//

#import "ButtonOfflineTableViewCell.h"
#import <Masonry/Masonry.h>

extern NSString *font;
extern NSInteger fontsize;

@interface ButtonOfflineTableViewCell()

@property (nonatomic, strong) UIButton *handBtn;
@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation ButtonOfflineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.handBtn setTitle:self.model.title forState:UIControlStateNormal];
    [self.handBtn.titleLabel setFont:[UIFont fontWithName:font size:16]];
    [self.handBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    //文字居中显示
    self.handBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.handBtn addTarget:self action:@selector(obtain_abn) forControlEvents:UIControlEventTouchUpInside];
    [self.nextBtn setTitle:@"Next" forState:UIControlStateNormal];
    [self.nextBtn.titleLabel setFont:[UIFont fontWithName:font size:fontsize]];
    [self.nextBtn setTitleColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:240.0/255.0 alpha:1]];
    self.nextBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.nextBtn addTarget:self action:@selector(commitBasicInfo) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupViews {
    [self.contentView addSubview:self.handBtn];
    [self.contentView addSubview:self.nextBtn];
    
    [self.handBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-55);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.handBtn.mas_bottom).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
    }];
}

- (void)obtain_abn {
    [self.controller jumpToHand];
}

- (UIButton *)handBtn {
    if (!_handBtn) {
        _handBtn = UIButton.new;
    }
    return _handBtn;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = UIButton.new;
    }
    return _nextBtn;
}

- (void)commitBasicInfo {
    [self.controller commitBasicInfo];
}

@end
