//
//  RegProgress_req.h
//  Driver_Register
//
//  Created by didi on 2021/1/25.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegProgress_req : NSObject

@property (nonatomic, strong) NSURL *url;
//@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NSMutableURLRequest *mutablerequest;
@property (nonatomic, copy) NSString *bodyStr;
@property (nonatomic, copy) NSString *path;

- (void)dataTask;

+ (NSString *)getPath;

@end

NS_ASSUME_NONNULL_END
