//
//  UpLoadViewController.h
//  Driver_Register
//
//  Created by didi on 2021/2/23.
//

#import <UIKit/UIKit.h>
#import "AuditInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UpLoadViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

/*
 status:
 1:proof of identity
 3:portrait
 4:driver accreditation
 5:vehicle inspection report
 */
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) BOOL hasSubmit;
@property (nonatomic, strong) auditinfoformItem *auditFormItem;

@end

NS_ASSUME_NONNULL_END
