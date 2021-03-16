//
//  AppDelegate.m
//  Driver_Register
//
//  Created by didi on 2021/1/25.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    NSString *query = @"enterFrom=dlogin&channel=9&bundle_id=com.didiglobal.driver.au.inhouse&lang=en-AU&appversion=7.5.86&lng=145.087272&enterFrom=dlogin&locale=en_AU&maptype=wgs84&Cityid=61020600&utc_offset=660&location_cityid=61020600&aid=1612164334666-5161724&deviceid=b51f9e2bb10b84f503795438169485ee&ticket=NRtcbaOQw9sO1ZUfdeV1R7qgiH07i3Z3HwE3uegn5LIUy7lNBVEMheFe_hRr5OO7O6MICmAZluQigYhG9P70CvgutpOUww_H2CJl7CCHu4exCznH6tKKotZnMXYl3diN5PEJ45kE44XszZek2kZEGct4IyOMk7z4_f77eT1J_zfeSXVVlTlrNz5IHrrcXd0VronxSSKMrzu5BQAA__8%3D&uid=650911145722379&location_country=AU&biz_type=2&frid=E8CFF37E9B03406AB8178202ECA45B99&lat=-37.884782&cell=+6100016012018&origin_id=1&role=2&__randNum=675716077&terminal_id=10&user_role=driver&appID=70002&end=DriverEnd&oid=&product=2";
//    NSURLComponents *component = [NSURLComponents componentsWithString:@"http://www.baidu.com"];
//    component.query = query;
//    for (NSURLQueryItem *queryItem in component.queryItems) {
//        NSLog(@"%@", [NSString stringWithFormat:@"🍍🍍🍍🍍 %@ = %@", queryItem.name, queryItem.value]);
//    }
//    NSLog(@"");
    
    // Override point for customization after application launch.
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
