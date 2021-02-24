//
//  BasicPageConfig_req.h
//  Driver_Register
//
//  Created by didi on 2021/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicPageConfig_req : NSObject

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSMutableURLRequest *mutablerequest;
@property (nonatomic, copy) NSString *bodyStr;
@property (nonatomic, copy) NSString *path;

- (void)dataTask;

+ (NSString *)getPath;

@end

NS_ASSUME_NONNULL_END
