//
//  AuditInfoModel.h
//  Driver_Register
//
//  Created by didi on 2021/2/7.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface AttachLinkModel : JSONModel

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *align;
@property (nonatomic, copy) NSString *target;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;

@end

@interface Desc_Title_linkModel : JSONModel

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;

@end

@protocol pic_fieldItem;
@interface pic_fieldItem : JSONModel

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger min_pic_num;
@property (nonatomic, assign) NSInteger max_pic_num;
@property (nonatomic, copy) NSArray *value;
@property (nonatomic, copy) NSArray *show_value;

@end

@interface Pic_DescModel : JSONModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *content;

@end

@protocol auditinfoformItem;
@interface auditinfoformItem : JSONModel

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) BOOL required;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) NSObject *value;
@property (nonatomic, copy) NSString *sub_title;
@property (nonatomic, copy) NSArray *content;
@property (nonatomic, copy) NSString *desc_title;
@property (nonatomic, strong) Desc_Title_linkModel *desc_title_link;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign) NSInteger exam_pic_type;
@property (nonatomic, copy) NSArray *exam_pic_url;
@property (nonatomic, strong) Pic_DescModel *pic_desc;
@property (nonatomic, copy) NSArray <pic_fieldItem *><pic_fieldItem> *pic_field;
@property (nonatomic, assign) NSInteger field_status;
@property (nonatomic, copy) NSString *field_result;
@property (nonatomic, copy) NSString *photo_tip;
@property (nonatomic, copy) NSString *field_result_key;
@property (nonatomic, assign) NSInteger min_pic_num;
@property (nonatomic, assign) NSInteger max_pic_num;
@property (nonatomic, copy) NSString *align;
@property (nonatomic, strong) AttachLinkModel *attach_link;

@end

@interface AuditInfoDataModel : JSONModel

@property (nonatomic, assign) BOOL is_finished;
@property (nonatomic, assign) BOOL is_rejected;
@property (nonatomic, copy) NSArray <auditinfoformItem *><auditinfoformItem> *form;
@property (nonatomic, assign) BOOL is_ocr;

@end

@interface AuditInfoModel : JSONModel

@property (nonatomic, assign) NSInteger _errno;
@property (nonatomic, copy) NSString *errmsg;
@property (nonatomic, strong) AuditInfoDataModel *data;

@end

NS_ASSUME_NONNULL_END
