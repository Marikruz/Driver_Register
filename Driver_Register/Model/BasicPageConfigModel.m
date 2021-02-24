//
//  BasicPageConfigModel.m
//  Driver_Register
//
//  Created by didi on 2021/1/28.
//

#import "BasicPageConfigModel.h"

@implementation CityItem

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation formItem

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation BasicPageConfigDataModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation BasicPageConfigModel

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
