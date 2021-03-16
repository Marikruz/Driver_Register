//
//  JointParams.m
//  Driver_Register
//
//  Created by didi on 2021/3/15.
//

#import "JointParams.h"
//#import "DSDriver.h"
//#import "DGBFFCommonParams.h"
//#import <ONEDataTracker/ONEDataTracker.h>
//#import "DGAppInstanceId.h"

@implementation JointParams

+ (NSMutableDictionary *)commmonParams {
    NSMutableDictionary *commonparams = [NSMutableDictionary dictionary];
    [commonparams setValue:@"dlogin" forKey:@"enterFrom"];
    [commonparams setValue:@"9" forKey:@"channel"];
    [commonparams setValue:@"en_AU" forKey:@"locale"];
    [commonparams setValue:@"driver" forKey:@"user_role"];
    [commonparams setValue:@"70002" forKey:@"appID"];
    [commonparams setValue:@"DriverEnd" forKey:@"end"];
    [commonparams setValue:@"qDdiJkcZTsmKlB+MJs+OAQ" forKey:@"oid"];
    [commonparams setValue:@"2" forKey:@"product"];
    
    /*
    NSDictionary *params = [DGBFFCommonParams comminParams];
    [commonparams setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"bundle_id"];
    [commonparams setValue:[DSDriver currentDriver].langInfo.default_lang forKey:@"lang"];
    [commonparams setValue:[params valueForKey:@"app_version"] forKey:@"appversion"];
    [commonparams setValue:[params valueForKey:@"lng"] forKey:@"lng"];
    [commonparams setValue:[params valueForKey:@"map_type"] forKey:@"maptype"];
    [commonparams setValue:[params valueForKey:@"location_cityid"] forKey:@"Cityid"];
    [commonparams setValue:[params valueForKey:@"utc_offset"] forKey:@"utc_offset"];
    [commonparams setValue:[params valueForKey:@"location_cityid"] forKey:@"location_cityid"];
    [commonparams setValue:[ONEDataTracker appsFlyerUID] forKey:@"aid"];
    [commonparams setValue:[params valueForKey:@"deviceid"] forKey:@"deviceid"];
    [commonparams setValue:[DSDriver currentDriver].ticket forKey:@"ticket"];
    [commonparams setValue:[DSDriver currentDriver].uid forKey:@"uid"];
    [commonparams setValue:[params valueForKey:@"location_country" forKey:@"location_country"];
    [commonparams setValue:[params valueForKey:@"biz_type"] forKey:@"biz_type"];
    [commonparams setValue:[DGAppInstanceId getAppInstanceId] forKey:@"frid"];
    [commonparams setValue:[params valueForKey:@"lat"] forKey:@"lat"];
    [commonparams setValue:[DSDriver currentDriver].phoneNumber forKey:@"cell"];
    [commonparams setValue:[params valueForKey:@"origin_id"] forKey:@"origin_id"];
    [commonparams setValue:[DSDriver currentDriver].role forKey:@"role"];
    //[commonparams setValue: forKey:@"__randNum"];
    [commonparams setValue:[params valueForKey:@"terminal_id"] forKey:@"terminal_id"];
    */
     
    return commonparams;
}

+ (NSString *)baseURL {
    return @"https://mis.didiglobal.com";
}

@end
