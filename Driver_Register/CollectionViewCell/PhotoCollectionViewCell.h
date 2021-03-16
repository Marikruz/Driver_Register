//
//  PhotoCollectionViewCell.h
//  Driver_Register
//
//  Created by didi on 2021/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PhotoCollectionViewCell;

@protocol PhotoCollectionCellDelegate <NSObject>

-(void)moveImageBtnClick:(PhotoCollectionViewCell *)aCell;

@end

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong) UIImageView *imgView;
@property (nonatomic,assign) id<PhotoCollectionCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
