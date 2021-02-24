//
//  LocateCity_req.m
//  Driver_Register
//
//  Created by didi on 2021/2/2.
//

#import "LocateCity_req.h"

@implementation LocateCity_req

-(NSURL *)url {
    if (_url == nil) {
        _url = [[NSURL alloc]initWithString:@"https://mis.didiglobal.com/gulfstream/deadpool/register/getLocateCity"];
    }
    return _url;
}

- (NSString *)bodyStr {
    if (_bodyStr == nil) {
        _bodyStr = @"enterFrom=dlogin&channel=9&bundle_id=com.didiglobal.driver.au.inhouse&lang=en-AU&appversion=7.5.86&lng=145.087272&enterFrom=dlogin&locale=en_AU&maptype=wgs84&Cityid=61020600&utc_offset=660&location_cityid=61020600&aid=1612164334666-5161724&deviceid=b51f9e2bb10b84f503795438169485ee&ticket=V4Db2jTPrZMDIsaxgt4mcb-uUeyoK_6pPL_x5uUFKkoUy81tAjEQhuFe3mtGq288azueW4pIAQksPxcjgTit6B1RwLMzRRKLFmFMJ92YheySijGD_O6juY8SUaJ2Y66kjFlJfn4x_kgw_slWNdx9rT1cqsaRbGFs5M7j9rwfNlIv40R68-hFfQzjTPLVXJI3eZF3jAuJY1w_5B0AAP__&uid=650911145731005&location_country=AU&biz_type=2&frid=E8CFF37E9B03406AB8178202ECA45B99&lat=-37.884782&cell=+6100016012017&origin_id=1&role=2&__randNum=1335550274&terminal_id=10&user_role=driver&appID=70002&end=DriverEnd&oid=aV3FFIbQSaioBu%2B4eFr3tQ&product=2";
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
            self.path = [LocateCity_req getPath];
            //保存数据
            [data writeToFile:self.path atomically:YES];
        }
    }];
    [dataTask resume];
}

+ (NSString *)getPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path =[documentsDirectory stringByAppendingPathComponent:@"locatecity.json"];
    return path;
}

@end
