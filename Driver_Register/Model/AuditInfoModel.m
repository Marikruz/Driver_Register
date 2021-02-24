//
//  AuditInfoModel.m
//  Driver_Register
//
//  Created by didi on 2021/2/7.
//

#import "AuditInfoModel.h"

@implementation AttachLinkModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation Desc_Title_linkModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation pic_fieldItem

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation Pic_DescModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation auditinfoformItem

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation AuditInfoDataModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation AuditInfoModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

//字段名映射
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
        @"_errno": @"errno",
        @"attach_link": @"attach-link"
    }];
}

@end
