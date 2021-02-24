//
//  ButtonTableViewCell.h
//  Driver_Register
//
//  Created by didi on 2021/2/8.
//

#import <UIKit/UIKit.h>
#import "AuditInfoViewController.h"
#import "AuditInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ButtonTableViewCell : UITableViewCell

@property (nonatomic, strong) auditinfoformItem *model;
@property (nonatomic, strong) AuditInfoViewController *controller;

@end

NS_ASSUME_NONNULL_END
