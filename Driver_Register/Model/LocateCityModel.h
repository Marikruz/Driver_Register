//
//  LocateCityModel.h
//  Driver_Register
//
//  Created by didi on 2021/2/2.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocateCityDataModel : JSONModel

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, copy) NSString *open_type;

@end

@interface LocateCityModel : JSONModel

@property (nonatomic, assign) NSInteger _errno;
@property (nonatomic, copy) NSString *errmsg;
@property (nonatomic, strong) LocateCityDataModel *data;

@end

NS_ASSUME_NONNULL_END
