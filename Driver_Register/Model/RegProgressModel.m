//
//  RegProgressModel.m
//  Driver_Register
//
//  Created by didi on 2021/1/26.
//

#import "RegProgressModel.h"


@implementation RegProgressDataModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end


@implementation RegProgressModel

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
