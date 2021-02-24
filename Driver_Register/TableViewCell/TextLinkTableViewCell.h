//
//  TextLinkTableViewCell.h
//  Driver_Register
//
//  Created by didi on 2021/2/3.
//

#import <UIKit/UIKit.h>
#import "BasicPageViewController.h"
#import "BasicPageConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TextLinkTableViewCell : UITableViewCell

@property (nonatomic, strong) BasicPageViewController *controller;
@property (nonatomic, strong) formItem *model;

@end

NS_ASSUME_NONNULL_END
