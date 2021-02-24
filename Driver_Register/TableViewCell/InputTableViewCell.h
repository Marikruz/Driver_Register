//
//  InputTableViewCell.h
//  Driver_Register
//
//  Created by didi on 2021/1/28.
//

#import <UIKit/UIKit.h>
#import "BasicPageViewController.h"
#import "BasicPageConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface InputTableViewCell : UITableViewCell

@property (nonatomic, strong) BasicPageViewController *controller;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) formItem *model;

@end

NS_ASSUME_NONNULL_END
