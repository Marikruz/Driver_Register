//
//  LocateCityModel.m
//  Driver_Register
//
//  Created by didi on 2021/2/2.
//

#import "LocateCityModel.h"

@implementation LocateCityDataModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation LocateCityModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

//字段名映射
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
        @"_errno": @"errno"
    }];
}

@end
