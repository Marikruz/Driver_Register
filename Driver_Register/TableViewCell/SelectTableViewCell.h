//
//  SelectTableViewCell.h
//  Driver_Register
//
//  Created by didi on 2021/1/28.
//

#import <UIKit/UIKit.h>
#import "BasicPageConfigModel.h"
#import "LocateCityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectTableViewCell : UITableViewCell

@property (nonatomic, strong) formItem *model;
@property (nonatomic, strong) LocateCityDataModel *citymodel;

@end

NS_ASSUME_NONNULL_END
