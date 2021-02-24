//
//  AuditInfo_req.m
//  Driver_Register
//
//  Created by didi on 2021/2/7.
//

#import "AuditInfo_req.h"

@implementation AuditInfo_req

-(NSURL *)url {
    if (_url == nil) {
        _url = [[NSURL alloc]initWithString:@"https://mis.didiglobal.com/gulfstream/deadpool/register/getAuditInfo"];
    }
    return _url;
}

- (NSString *)bodyStr {
    if (_bodyStr == nil) {
        _bodyStr = @"enterFrom=dlogin&channel=9&bundle_id=com.didiglobal.driver.au.inhouse&lang=en-AU&appversion=7.5.86&lng=145.087272&enterFrom=dlogin&locale=en_AU&maptype=wgs84&Cityid=61020600&utc_offset=660&location_cityid=61020600&aid=1612164334666-5161724&deviceid=b51f9e2bb10b84f503795438169485ee&ticket=NRtcbaOQw9sO1ZUfdeV1R7qgiH07i3Z3HwE3uegn5LIUy7lNBVEMheFe_hRr5OO7O6MICmAZluQigYhG9P70CvgutpOUww_H2CJl7CCHu4exCznH6tKKotZnMXYl3diN5PEJ45kE44XszZek2kZEGct4IyOMk7z4_f77eT1J_zfeSXVVlTlrNz5IHrrcXd0VronxSSKMrzu5BQAA__8%3D&uid=650911145722379&location_country=AU&biz_type=2&frid=E8CFF37E9B03406AB8178202ECA45B99&lat=-37.884782&cell=+6100016012018&origin_id=1&role=2&__randNum=675716077&terminal_id=10&user_role=driver&appID=70002&end=DriverEnd&oid=&product=2";
    }
    return _bodyStr;
}

//使用post方式请求
- (NSMutableURLRequest *)mutablerequest {
    if (_mutablerequest == nil) {
        _mutablerequest = [[NSMutableURLRequest alloc]initWithURL:self.url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
        _mutablerequest.HTTPBody = [self.bodyStr dataUsingEncoding:NSUTF8StringEncoding];
        _mutablerequest.HTTPMethod = @"POST";
    }
    return _mutablerequest;
}

//POST请求
- (void)dataTask {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:self.mutablerequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            self.path = [AuditInfo_req getPath];
            //保存数据
            [data writeToFile:self.path atomically:YES];
        }
    }];
    [dataTask resume];
}

+ (NSString *)getPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path =[documentsDirectory stringByAppendingPathComponent:@"auditinfo.json"];
    return path;
}

@end
