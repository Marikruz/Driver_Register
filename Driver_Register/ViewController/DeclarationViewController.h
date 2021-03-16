//
//  DeclarationViewController.h
//  Driver_Register
//
//  Created by didi on 2021/2/24.
//

#import <UIKit/UIKit.h>
#import "AuditInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeclarationViewController : UIViewController

/*
 status:
 2:Insurance Declaration
 7:CPVR
 */
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) BOOL hasSubmit;
@property (nonatomic, strong) auditinfoformItem *auditFormItem;

@end

NS_ASSUME_NONNULL_END
