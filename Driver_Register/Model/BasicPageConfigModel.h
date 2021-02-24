//
//  BasicPageConfigModel.h
//  Driver_Register
//
//  Created by didi on 2021/1/28.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CityItem;
@interface CityItem : JSONModel

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSInteger value;

@end

@protocol formItem;
@interface formItem : JSONModel

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) BOOL required;
@property (nonatomic, assign) NSInteger max_length;
@property (nonatomic, copy) NSString *regex;
@property (nonatomic, copy) NSString *format;
@property (nonatomic, assign) BOOL clear_format;
@property (nonatomic, copy) NSString *regex_remind;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *valid_api;
@property (nonatomic, copy) NSString *field_status;
@property (nonatomic, copy) NSString *field_result;
@property (nonatomic, copy) NSString *align;
@property (nonatomic, strong) NSDictionary *options;
@property (nonatomic, copy) NSString *target;
@property (nonatomic, copy) NSString *link;

@end

@interface BasicPageConfigDataModel : JSONModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray <formItem *><formItem> *form;

@end

@interface BasicPageConfigModel : JSONModel

@property (nonatomic, assign) NSInteger _errno;
@property (nonatomic, copy) NSString *errmsg;
@property (nonatomic, strong) BasicPageConfigDataModel *data;

@end

NS_ASSUME_NONNULL_END
