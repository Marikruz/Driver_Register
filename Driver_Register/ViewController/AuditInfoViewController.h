//
//  AuditInfoViewController.h
//  Driver_Register
//
//  Created by didi on 2021/1/25.
//

#import "ViewController.h"
#import "AuditInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AuditInfoViewController : UIViewController

@property (nonatomic, strong) auditinfoformItem *Handformitem;

- (void)jumpToHand;

@end

NS_ASSUME_NONNULL_END
