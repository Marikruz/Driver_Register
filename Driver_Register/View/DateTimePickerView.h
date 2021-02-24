//
//  DateTimePickerView.h
//  Driver_Register
//
//  Created by didi on 2021/2/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DateTimePickerViewDelegate <NSObject>
@optional
//确定按钮
- (void)didClickFinishDateTimePickerView:(NSString *)date;
//取消按钮
- (void)didClickCancelDateTimePickerView;
@end

@interface DateTimePickerView : UIView
/*
 设置当前时间
 */
@property (nonatomic, strong) NSDate *currentDate;
@property(nonatomic, strong)id<DateTimePickerViewDelegate>delegate;
//隐藏
- (void)hideDateTimePickerView;
//显示
- (void)showDateTimePickerView;

@end

NS_ASSUME_NONNULL_END
