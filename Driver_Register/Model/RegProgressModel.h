//
//  RegProgressModel.h
//  Driver_Register
//
//  Created by didi on 2021/1/26.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN


@interface RegProgressDataModel : JSONModel

@property (nonatomic, strong) NSString *progress;

@end


@interface RegProgressModel : JSONModel

@property (nonatomic, assign) NSInteger _errno;
@property (nonatomic, copy) NSString *errmsg;
@property (nonatomic, strong) RegProgressDataModel *data;

@end

NS_ASSUME_NONNULL_END
