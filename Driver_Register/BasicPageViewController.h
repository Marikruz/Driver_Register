//
//  BasicPageViewController.h
//  Driver_Register
//
//  Created by didi on 2021/1/25.
//

#import "ViewController.h"
#import "BasicPageConfigModel.h"
#import "LocateCityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BasicPageViewController : UIViewController

@property (nonatomic, strong) formItem *ABNformitem;
@property (nonatomic, strong) formItem *Handformitem;

@property (nonatomic, copy) NSString *commit_firstname;
@property (nonatomic, copy) NSString *commit_lastname;
@property (nonatomic, copy) NSString *commit_date;
@property (nonatomic, copy) NSString *commit_driverlicenceno;
@property (nonatomic, copy) NSString *commit_abnno;

- (void)jumpToObtainABN;
- (void)jumpToHand;
- (void)commitBasicInfo;
+ (LocateCityDataModel *)getLocateModel;
+ (void)setLocateCity:(NSString *) city;
+ (NSString *)getLocateCity;
+ (NSString *)getChoosedDate;
+ (void)setDriverLicenceNoFlag:(BOOL)flag;
+ (void)setABNNoFlag:(BOOL)flag;
+ (void)setfirst_load:(BOOL)flag;

@end

NS_ASSUME_NONNULL_END
