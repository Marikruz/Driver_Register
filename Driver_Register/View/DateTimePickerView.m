//
//  DateTimePickerView.m
//  Driver_Register
//
//  Created by didi on 2021/2/1.
//

#import "DateTimePickerView.h"

#define ScreenWith   [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface DateTimePickerView()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSInteger yearRange;
    NSInteger monthRange;
    NSInteger dayRange;
    NSInteger startYear;
    NSInteger curYear;
    NSInteger curMonth;
    NSInteger curDay;
//    NSInteger selectedYear;
//    NSInteger selectedMonth;
//    NSInteger selectedDay;
    NSCalendar *calendar;
}

@property (nonatomic,assign) NSInteger selectedYear;
@property (nonatomic,assign) NSInteger selectedMonth;
@property (nonatomic,assign) NSInteger selectedDay;
@property (nonatomic,strong) UIView *contentView; //背景View
@property (nonatomic,strong) UIPickerView *pickerView;
@property (nonatomic,strong) UIView *upView; //盛放按钮的View
@property (nonatomic,strong) UIButton *cancelButton; //左边退出按钮
@property (nonatomic,strong) UIButton *chooseButton; //右边的确定按钮
@property (nonatomic,strong) UIView *splitView; //分割线
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,assign) NSInteger column;//需要分割的列
@property (nonatomic,strong) NSString *date_string;

@end

@implementation DateTimePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
        self.alpha = 0;
        self.column = 3;
                
        // 1.添加子控件
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.pickerView];
        [self.contentView addSubview:self.upView];
        [self.upView addSubview:self.cancelButton];
        [self.upView addSubview:self.chooseButton];
        [self.upView addSubview:self.splitView];
                
        // 2.获取当前时间
        NSCalendar *calendar0 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        comps = [calendar0 components:unitFlags fromDate:[NSDate date]];
        NSInteger year = [comps year];
        
        yearRange = 60;
        startYear = year-yearRange+1;
        
        [self setCurrentDate:[NSDate date]];
    }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.column;
}

//每一列显示内容(year/month/day)
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            return yearRange;
        }
            break;
        case 1:
        {
            return monthRange;
        }
        case 2:
        {
            return dayRange;
        }
            break;
        default:
            break;
    }
    return 0;
}

//默认时间
-(void)setCurrentDate:(NSDate *)currentDate {
    // 获取当前时间
    NSCalendar *calendar0 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    comps = [calendar0 components:unitFlags fromDate:currentDate];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    self.selectedYear = year;
    self.selectedMonth = month;
    self.selectedDay = day;
    curYear = year;
    curMonth = month;
    curDay = day;
    
    //此行代码解决、切换模式时导致的数组越界问题
    [self.pickerView reloadAllComponents];
    //dayRange = [self isAllDay:year andMonth:month];
    
    [self.pickerView selectRow:year inComponent:0 animated:NO];
    [self.pickerView selectRow:month-1 inComponent:1 animated:NO];
    [self.pickerView selectRow:day-1 inComponent:2 animated:NO];

    [self pickerView:self.pickerView didSelectRow:year inComponent:0];
    [self pickerView:self.pickerView didSelectRow:month-1 inComponent:1];
    [self pickerView:self.pickerView didSelectRow:day-1 inComponent:2];
    
    [self.pickerView reloadAllComponents];
}



- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWith*component/6.0, 0,ScreenWith/6.0, 30)];
    label.font = [UIFont systemFontOfSize:18.0];
    label.tag = component*100+row;
    label.textAlignment = NSTextAlignmentCenter;
    
    switch (component) {
        case 0:
        {
            label.text=[NSString stringWithFormat:@"%ld",(long)(startYear + row)];
        }
            break;
        case 1:
        {
            label.text=[NSString stringWithFormat:@"%ld",(long)row+1];
        }
            break;
        case 2:
        {
            label.text=[NSString stringWithFormat:@"%ld",(long)row+1];
        }
            break;
        default:
            break;
    }
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return ([UIScreen mainScreen].bounds.size.width-40)/self.column;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35.0f;
}

// 监听picker的滑动
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            if (row == curYear) {
                row = 0;
            }
            self.selectedYear = startYear + row;
            if (curYear == self.selectedYear) {
                monthRange = curMonth;
            }
            else {
                monthRange = 12;
            }
            if (curYear == self.selectedYear && curMonth == self.selectedMonth) {
                dayRange = curDay;
            }
            else {
                dayRange = [self isAllDay:self.selectedYear andMonth:self.selectedMonth];
            }
            [self.pickerView reloadAllComponents];
        }
            break;
        case 1:
        {
            self.selectedMonth=row+1;
            if (curYear == self.selectedYear && curMonth == self.selectedMonth) {
                dayRange = curDay;
            }
            else {
                dayRange = [self isAllDay:self.selectedYear andMonth:self.selectedMonth];
            }
            [self.pickerView reloadAllComponents];
        }
            break;
        case 2:
        {
            self.selectedDay=row+1;
            [self.pickerView reloadAllComponents];
        }
            break;
        default:
            break;
    }
    _date_string =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld", self.selectedYear, self.selectedMonth, self.selectedDay];
}

- (void)showDateTimePickerView {
    [self setCurrentDate:[NSDate date]];
    self.frame = CGRectMake(0, 0, ScreenWith, ScreenHeight);
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 1;
        self.contentView.frame = CGRectMake(0, ScreenHeight-300, ScreenWith, 300);
    } completion:^(BOOL finished) {
    }];
}

- (void)hideDateTimePickerView {
    [UIView animateWithDuration:0.2f animations:^{
        self.alpha = 0;
        self.contentView.frame = CGRectMake(0, ScreenHeight, ScreenWith, 300);
    } completion:^(BOOL finished) {
        self.frame = CGRectMake(0, ScreenHeight, ScreenWith, ScreenHeight);
    }];
}

//取消的隐藏
- (void)cancelButtonClick {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickCancelDateTimePickerView)]) {
        [self.delegate didClickCancelDateTimePickerView];
    }
    [self hideDateTimePickerView];
    
}

//确认的隐藏
-(void)configButtonClick {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickFinishDateTimePickerView:)]) {
        [self.delegate didClickFinishDateTimePickerView:_date_string];
    }
    [self hideDateTimePickerView];
}

-(NSInteger)isAllDay:(NSInteger)year andMonth:(NSInteger)month {
    int day=0;
    switch(month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            day=31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            day=30;
            break;
        case 2:
        {
            if(((year%4==0)&&(year%100!=0))||(year%400==0))
            {
                day=29;
                break;
            }
            else
            {
                day=28;
                break;
            }
        }
        default:
            break;
    }
    return day;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hideDateTimePickerView];
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWith, 220)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 180)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.dataSource=self;
        _pickerView.delegate=self;
    }
    return _pickerView;
}

- (UIView *)upView{
    if (!_upView) {
        _upView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        _upView.backgroundColor = [UIColor whiteColor];
    }
    return _upView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(12, 0, 60, 40);
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        _cancelButton.backgroundColor = [UIColor clearColor];
        [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)chooseButton {
    if (!_chooseButton) {
        _chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 52, 0, 40, 40);
        [_chooseButton setTitle:@"OK" forState:UIControlStateNormal];
        _chooseButton.backgroundColor = [UIColor clearColor];
        [_chooseButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _chooseButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_chooseButton addTarget:self action:@selector(configButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseButton;
}

- (UIView *)splitView {
    if (!_splitView) {
        _splitView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 0.5)];
        _splitView.backgroundColor = UIColorFromRGB(0xe6e6e6);
    }
    return _splitView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
