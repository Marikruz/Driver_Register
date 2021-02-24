//
//  BasicPageViewController.m
//  Driver_Register
//
//  Created by didi on 2021/1/25.
//

#import "BasicPageViewController.h"
#import "LocationViewController.h"
#import "ObtainABNViewController.h"
#import "HandViewController.h"
#import "BasicPageConfig_req.h"
#import "BasicPageConfigModel.h"
#import "LocateCity_req.h"
#import "LocateCityModel.h"
#import "InputTableViewCell.h"
#import "DateTableViewCell.h"
#import "SelectTableViewCell.h"
#import "TextLinkTableViewCell.h"
#import "ButtonOfflineTableViewCell.h"
#import "DateTimePickerView.h"

extern NSString *font;

LocateCityDataModel *locatemodel;
NSString *commit_locatecity;
NSString *tmp_date;
BOOL checkDriverLicenceNoFlag;
BOOL checkABNNoFlag;

@interface BasicPageViewController ()<UITableViewDataSource, UITableViewDelegate, DateTimePickerViewDelegate>

@property (nonatomic, strong) BasicPageConfig_req *basicpageconfig_req;
@property (nonatomic, copy) NSString *basicpageconfig_path;
@property (nonatomic, copy) NSString *locatecity_path;
@property (nonatomic, strong) BasicPageConfigModel *basicPageConfigModel;
@property (nonatomic, strong) LocateCity_req *locatecity_req;
@property (nonatomic, strong) LocateCityModel *locatecitymodel;

@property (nonatomic, strong) UIView *bannerView;
@property (nonatomic, strong) UITableView *basicpagetableView;
@property (nonatomic, strong) UILabel *bannerlabel;
@property (nonatomic, assign) int banner_height;
@property (nonatomic, assign) int fix_height;
@property (nonatomic, assign) int change_height;
@property (nonatomic, assign) int btn_height;
@property (nonatomic, assign) int checklabel_height;

@end

@implementation BasicPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initBasicPage];
    self.basicpageconfig_req = [BasicPageConfig_req new];
    [self.basicpageconfig_req dataTask];
    [self performSelector:@selector(loadBasicPageConfig) withObject:@"2" afterDelay:1.0];
    //[self loadBasicPageConfig];
    self.locatecity_req = [LocateCity_req new];
    [self.locatecity_req dataTask];
    [self performSelector:@selector(loadLocateCity) withObject:@"3" afterDelay:1.0];
    //[self loadLocateCity];
    [self performSelector:@selector(setTableView) withObject:@"4" afterDelay:1.0];
    //[self settableView];
}

- (void)viewWillAppear:(BOOL)animated {
    //局部cell刷新
    NSIndexPath *indexPath_location = [NSIndexPath indexPathForRow:4 inSection:0];
    [self.basicpagetableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath_location,nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)initBasicPage {
    //设置界面和导航栏
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(backToStartPage)];
    self.navigationItem.leftBarButtonItem = backBtn;
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.frame = CGRectZero;
    titlelabel.text =@"Register";
    [titlelabel sizeToFit];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = titlelabel;
    
    tmp_date = @" ";
    checkDriverLicenceNoFlag = YES;//无checkLabel
    checkABNNoFlag = YES;
}

- (void)loadBasicPageConfig {
    self.basicpageconfig_path = [BasicPageConfig_req getPath];
    NSData *data = [NSData dataWithContentsOfFile:self.basicpageconfig_path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.basicPageConfigModel = [[BasicPageConfigModel alloc] initWithDictionary:json error:nil];
}

- (void)loadLocateCity {
    self.locatecity_path = [LocateCity_req getPath];
    NSData *data = [NSData dataWithContentsOfFile:self.locatecity_path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.locatecitymodel = [[LocateCityModel alloc] initWithDictionary:json error:nil];
    commit_locatecity = self.locatecitymodel.data.text;
}

- (int)banner_height {
    return 60;
}

- (int)fix_height {
    return 75;
}

- (int)checklabel_height {
    return 25;
}

- (int)change_height {
    return self.fix_height+self.checklabel_height+5;
}

- (int)btn_height {
    return 90;
}

- (void)setTableView {
    //设置tableview
    self.basicpagetableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.basicpagetableView.dataSource = self;
    self.basicpagetableView.delegate = self;
    [self.view addSubview:self.basicpagetableView];
    self.basicpagetableView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    self.basicpagetableView.separatorStyle = NO;
    //注册cell
    [self.basicpagetableView registerClass:[InputTableViewCell class] forCellReuseIdentifier:@"InputTableViewCell"];
    [self.basicpagetableView registerClass:[DateTableViewCell class] forCellReuseIdentifier:@"DateTableViewCell"];
    [self.basicpagetableView registerClass:[SelectTableViewCell class] forCellReuseIdentifier:@"SelectTableViewCell"];
    [self.basicpagetableView registerClass:[TextLinkTableViewCell class] forCellReuseIdentifier:@"TextLinkTableViewCell"];
    [self.basicpagetableView registerClass:[ButtonOfflineTableViewCell class] forCellReuseIdentifier:@"ButtonOfflineTableViewCell"];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //设置banner
    self.bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.banner_height)];
    self.bannerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bannerView.bounds.size.width, self.bannerView.bounds.size.height)];
    self.bannerlabel.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    self.bannerlabel.text = [self.basicPageConfigModel.data.form objectAtIndex:0].title;
    [self.bannerlabel setFont:[UIFont fontWithName:font size:22]];
    self.bannerlabel.textAlignment = UIListContentTextAlignmentCenter;
    [self.bannerView addSubview:self.bannerlabel];
    return self.bannerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.banner_height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.basicPageConfigModel.data.form.count-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"row: %ld", indexPath.row);
    NSInteger row = indexPath.row+1;
    switch (indexPath.row) {
        case 0://input
        case 1:
        case 4:
        case 5:
        {
            InputTableViewCell *inputcell = [tableView dequeueReusableCellWithIdentifier:@"InputTableViewCell"];
            inputcell.model = self.basicPageConfigModel.data.form[row];
            inputcell.selectionStyle = NO;
            inputcell.controller = self;
            inputcell.tableView = self.basicpagetableView;
            return inputcell;
        }
            break;
        case 2://date
        {
            DateTableViewCell *datecell = [tableView dequeueReusableCellWithIdentifier:@"DateTableViewCell"];
            datecell.model = self.basicPageConfigModel.data.form[row];
            datecell.selectionStyle = NO;
            return datecell;
        }
            break;
        case 3://select
        {
            //NSLog(@"set select cell");
            SelectTableViewCell *selectcell = [tableView dequeueReusableCellWithIdentifier:@"SelectTableViewCell"];
            selectcell.model = self.basicPageConfigModel.data.form[row];
            selectcell.citymodel = self.locatecitymodel.data;
            locatemodel = self.locatecitymodel.data;
            selectcell.selectionStyle = NO;
            return selectcell;
        }
            break;
        case 6://text-link
        {
            TextLinkTableViewCell *textlinkcell = [tableView dequeueReusableCellWithIdentifier:@"TextLinkTableViewCell"];
            textlinkcell.model = self.basicPageConfigModel.data.form[row];
            self.ABNformitem = self.basicPageConfigModel.data.form[row];
            textlinkcell.controller = self;
            textlinkcell.selectionStyle = NO;
            textlinkcell.backgroundColor = [UIColor clearColor];

            return textlinkcell;
        }
            break;
        case 7://button_offline
        {
            ButtonOfflineTableViewCell *buttonofflinecell = [tableView dequeueReusableCellWithIdentifier:@"ButtonOfflineTableViewCell"];
            buttonofflinecell.model = self.basicPageConfigModel.data.form[row];
            self.Handformitem = self.basicPageConfigModel.data.form[row];
            buttonofflinecell.controller = self;
            buttonofflinecell.selectionStyle = NO;
            buttonofflinecell.backgroundColor = [UIColor clearColor];
            return buttonofflinecell;
        }
            break;
        default:
            return UITableViewCell.new;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSInteger row = indexPath.row;
    switch (indexPath.row) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 6:
            return self.fix_height;
            break;
        case 4:
        {
            if (checkDriverLicenceNoFlag) {
                return self.fix_height;
            }
            else {
                return self.change_height;
            }
        }
            break;
        case 5:
        {
            if (checkABNNoFlag) {
                return self.fix_height;
            }
            else {
                return self.change_height;
            }
        }
            break;
        default:
            return self.btn_height;
            break;;
    }
}

- (void)backToStartPage {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row+1;
    switch (row) {
        case 3:
        {
            //年月日选择弹窗
            DateTimePickerView *pickerView = [[DateTimePickerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            pickerView.delegate = self;
            [self.view addSubview:pickerView];
            [pickerView showDateTimePickerView];
        }
            break;
        case 4:
        {
            //地点选择界面
            LocationViewController *location = [[LocationViewController alloc]init];
#warning 数据解析存在问题
            // TODO: @beibei
            location.optionModel = self.basicPageConfigModel.data.form[4].options;
            location.locatemodel = self.locatecitymodel.data;
            location.curCityStr = commit_locatecity;
            [self.navigationController pushViewController:location animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)didClickFinishDateTimePickerView:(NSString *)date {
    self.commit_date = date;
    tmp_date = date;
    NSIndexPath *indexPath_date = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.basicpagetableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath_date,nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)jumpToObtainABN {
    ObtainABNViewController *obtainabn = [[ObtainABNViewController alloc]init];
    obtainabn.formitem = self.ABNformitem;
    [self.navigationController pushViewController:obtainabn animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)jumpToHand {
    HandViewController *hand = [[HandViewController alloc]init];
    hand.basicFormItem = self.Handformitem;
    hand.BasicOrAudit = YES;
    [self.navigationController pushViewController:hand animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)commitBasicInfo {
    NSLog(@"提交基本信息:");
    NSLog(@"first name: %@", self.commit_firstname);
    NSLog(@"last name: %@", self.commit_lastname);
    NSLog(@"date: %@", self.commit_date);
    NSLog(@"location: %@", commit_locatecity);
    NSLog(@"driver licence no: %@", self.commit_driverlicenceno);
    NSLog(@"abn no: %@", self.commit_abnno);
}

+ (LocateCityDataModel *)getLocateModel {
    return locatemodel;
}

+ (void)setLocateCity:(NSString *)city {
    commit_locatecity = city;
}

+(NSString *)getLocateCity {
    return commit_locatecity;
}

+ (NSString *)getChoosedDate {
    return tmp_date;
}

+ (void)setDriverLicenceNoFlag:(BOOL)flag {
    checkDriverLicenceNoFlag = flag;
}

+ (void)setABNNoFlag:(BOOL)flag {
    checkABNNoFlag = flag;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
