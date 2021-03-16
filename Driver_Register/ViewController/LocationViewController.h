//
//  LocationViewController.h
//  Driver_Register
//
//  Created by didi on 2021/2/2.
//

#import <UIKit/UIKit.h>
#import "LocateCityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LocationViewController : UIViewController

@property (nonatomic, strong) NSDictionary *optionModel;
@property (nonatomic, strong) LocateCityDataModel *locatemodel;
@property (nonatomic, copy) NSString *curCityStr;

/// 我是一个方法的注释🍐
/// @param a AAAAA
/// @param b BBBBB
- (void)methodExampleWithParamA:(NSString *)a paramB:(NSInteger)b;

@end

NS_ASSUME_NONNULL_END
