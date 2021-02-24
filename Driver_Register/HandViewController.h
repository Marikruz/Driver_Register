//
//  HandViewController.h
//  Driver_Register
//
//  Created by didi on 2021/2/4.
//

#import <UIKit/UIKit.h>
#import "BasicPageConfigModel.h"
#import "AuditInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HandViewController : UIViewController

@property (nonatomic, strong) formItem *basicFormItem;
@property (nonatomic, strong) auditinfoformItem *auditFormItem;
@property (nonatomic, assign) BOOL BasicOrAudit;//YES:basic NO:audit

@end

NS_ASSUME_NONNULL_END
