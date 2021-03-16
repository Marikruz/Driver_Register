//
//  PhotoCollectionViewCell.m
//  Driver_Register
//
//  Created by didi on 2021/3/16.
//

#import "PhotoCollectionViewCell.h"

@interface PhotoCollectionViewCell ()

@property (nonatomic ,strong) UILabel *text;
@property (nonatomic ,strong) UIButton *btn;
@property (nonatomic,strong) UIButton *delBtn;

@end

@implementation PhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    [self addSubview:self.imgView];
    [self addSubview:self.text];
    [self addSubview:self.delBtn];
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, CGRectGetWidth(self.frame)-10)];
    }
    return _imgView;
}

- (UILabel *)text {
    if (!_text) {
        _text = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imgView.frame), CGRectGetWidth(self.frame)-10, 20)];
        _text.textAlignment = NSTextAlignmentCenter;
    }
    return _text;
}

- (UIButton *)delBtn {
    if (!_delBtn) {
        _delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _delBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage * image = [UIImage imageNamed:@"delete.png"];
        [_delBtn setImage:image forState:UIControlStateNormal];
        [_delBtn setFrame:CGRectMake(self.frame.size.width-image.size.width, 0, image.size.width, image.size.height)];
        [_delBtn sizeToFit];
        [_delBtn addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delBtn;
}

-(void)deletePic:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(moveImageBtnClick:)]) {
        [_delegate moveImageBtnClick:self];
    }
}



@end
