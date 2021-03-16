//
//  RegProgress_req.m
//  Driver_Register
//
//  Created by didi on 2021/1/25.
//

#import "RegProgress_req.h"
#import "JointParams.h"

@implementation RegProgress_req

-(NSURL *)url {
    if (_url == nil) {
        _url = [[NSURL alloc]initWithString:@"https://mis.didiglobal.com/gulfstream/deadpool/register/getRegProgress"];
    }
    return _url;
}

- (NSString *)bodyStr {
    if (_bodyStr == nil) {
        //修改bundle_id @"com.thinkofsomethingclever.Driver-Register"
        _bodyStr = @"enterFrom=dlogin&channel=9&bundle_id=com.thinkofsomethingclever.Driver-Register&lang=en-AU&appversion=7.5.91&lng=150.973579&enterFrom=dlogin&locale=en_AU&maptype=wgs84&Cityid=61011500&utc_offset=660&location_cityid=61011500&aid=1615201028509-5734811&deviceid=c7c49e3e65a69805999ab94403b1f5a3&ticket=15jh4x-SlqaQj4fEaWLdP_-YwMqdOESr8omJFcsrKm4Uy7mNAkEQheFcfndLo3rd01d5G8QGsMBwOI0EwhqROyKAb2c6QV58cYwpQsZMRHP3ZMxM9DaqNFJWqT0bcyXcmIXg9w_jnwDjQNTiQ9JaWkq5DeNE5GFsxM7z_nocN8LfxplQVemtr6MYF4KfKndXdSVXx7gSCOP2JZ8AAAD__w%3D%3D&uid=650911145722379&location_country=AU&biz_type=2&frid=65F01EB2870844D0A9B084DB6884D66F&lat=-33.817667&cell=+6100016012018&origin_id=1&role=2&__randNum=24735737&terminal_id=10&user_role=driver&appID=70002&end=DriverEnd&oid=qDdiJkcZTsmKlB%2BMJs%2BOAQ&product=2";
    }
    return _bodyStr;
}

//使用get方式请求
/*
- (NSURLRequest *)request {
    if (_request == nil) {
        _request = [[NSURLRequest alloc]initWithURL:self.url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:0];
    }
    return _request;
}
*/

//使用post方式请求
- (NSMutableURLRequest *)mutablerequest {
    if (_mutablerequest == nil) {
        _mutablerequest = [[NSMutableURLRequest alloc]initWithURL:self.url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
        _mutablerequest.HTTPBody = [self.bodyStr dataUsingEncoding:NSUTF8StringEncoding];
        //NSLog(@"HTTPbody: %@", _mutablerequest.HTTPBody);
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
            self.path = [RegProgress_req getPath];
            //NSLog(@"regprogress.json_path: %@", self.path);
            //保存数据
            [data writeToFile:self.path atomically:YES];
        }
    }];
    [dataTask resume];
}

//BFF请求
/*
- (void)BFFDataTask {
    NSString *baseURL = [JointParams baseURL];
    NSString *path = @"gulfstream/deadpool/register/getRegProgress";
    NSDictionary *parameters = [JointParams commmonParams];
    
    __weak typeof(self) weakSelf = self;
    [[GBFFRequest new] requestWithBaseURL:baseURL path:path parameters:parameters success:^(GBFFRequest *request, NSDictionary *response) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        strongSelf.taskState = GBFFTaskFinishedState;
        GBFFResponseModel *responseModel = [[GBFFResponseModel alloc] initWithDictionary:response error:nil];
        
        if ([responseModel isValid]) {
            [strongSelf handleSuccessWithResponseModel:responseModel request:request];
            if (success) {
                success(request, response);
            }
        } else {
            NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorUnknown userInfo:@{NSLocalizedDescriptionKey:@"bizError: errNo not exist or errNo != 0 "}];
            [strongSelf handleFailureWithError:error request:request];
            if (failure) {
                failure(request, error);
            }
        }
    } failure:^(GBFFRequest *request, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        strongSelf.taskState = GBFFTaskFinishedState;
        [strongSelf handleFailureWithError:error request:request];
        if (failure) {
            failure(request, error);
        }
    }];
}
 */

+ (NSString *)getPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path =[documentsDirectory stringByAppendingPathComponent:@"regprogress.json"];
    return path;
}

@end
