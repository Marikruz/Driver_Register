//
//  LocationViewController.m
//  Driver_Register
//
//  Created by didi on 2021/2/2.
//

#import "LocationViewController.h"
#import "BasicPageViewController.h"
#import <Masonry/Masonry.h>

#define LocationPageSearchViewHeight 65.f
#define LocationPageCurCityViewHeight 40.f

extern NSString *font;

@interface LocationViewController ()<UITableViewDataSource, UITableViewDelegate>

// 搜索框container
@property (nonatomic, strong) UIView *searchView;
// 搜索框输入
@property (nonatomic, strong) UITextField *searchTextField;
// 城市列表
@property (nonatomic, strong) UITableView *locationTableView;
// 排序标记
@property (nonatomic, strong) NSArray *sortedKeys;
// 搜索城市列表
@property (nonatomic, strong) UITableView *searchedCitiesTableView;
// 搜索结果
@property (nonatomic, strong) NSMutableArray *searchedCities;
@property (nonatomic, assign) NSInteger searchview_height;
@property (nonatomic, strong) UILabel *curCityLabel;
@property (nonatomic, strong) UILabel *curCityTextLabel;
@property (nonatomic, strong) UILabel *curCity;
@property (nonatomic, strong) UILabel *curCityText;
@property (nonatomic, assign) NSInteger curcityView_height;
@property (nonatomic, assign) NSInteger cellHeight;

@end

@implementation LocationViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // example
    [self initLocation];
    [self setupViews];
}

#pragma mark - Public Method


/// 我是一个方法的注释🍐
/// @param a AAAAA
/// @param b BBBBB
- (void)methodExampleWithParamA:(NSString *)a paramB:(NSInteger)b {
    
}

#pragma mark - Private Method

- (void)initLocation {
    //设置界面和导航栏
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(backToBasicPage)];
    self.navigationItem.leftBarButtonItem = backBtn;
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.frame = CGRectZero;
    titlelabel.text =@"Register";
    [titlelabel sizeToFit];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = titlelabel;
    
    self.searchedCitiesTableView.hidden = YES;
    self.searchedCities = [[NSMutableArray alloc] init];
}

- (void)setupViews {
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.searchView];
    [self.searchView addSubview:self.searchTextField];
    [self.view addSubview:self.curCityLabel];
    [self.curCityLabel addSubview:self.curCityTextLabel];
    [self.view addSubview:self.curCity];
    [self.curCity addSubview:self.curCityText];
    [self.view addSubview:self.locationTableView];
    [self.view addSubview:self.searchedCitiesTableView];
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(100);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(LocationPageSearchViewHeight);
    }];
    
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchView.mas_top).with.offset(10);
        make.left.equalTo(self.searchView.mas_left).with.offset(20);
        make.right.equalTo(self.searchView.mas_right).with.offset(-20);
        make.bottom.equalTo(self.searchView.mas_bottom).with.offset(-10);
    }];
    [self.searchTextField addTarget:self action:@selector(searchCity:) forControlEvents:UIControlEventEditingChanged];
    
    [self.curCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.searchView.mas_bottom).with.offset(LocationPageCurCityViewHeight);
    }];
    
    [self.curCityTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.curCityLabel.mas_left).with.offset(20);
        make.top.right.bottom.equalTo(self.curCityLabel);
    }];
    
    [self.curCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.curCityLabel.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.curCityLabel.mas_bottom).with.offset(LocationPageCurCityViewHeight);
    }];
    
    [self.curCityText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.curCity.mas_left).with.offset(20);
        make.top.right.bottom.equalTo(self.curCity);
    }];
    
    [self.locationTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.curCity.mas_bottom).with.offset(0);
//        make.left.equalTo(self.view.mas_left).with.offset(0);
//        make.right.equalTo(self.view.mas_right).with.offset(0);
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.searchedCitiesTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchView.mas_bottom).with.offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)searchCity:(UITextField *) textField {
    NSString *text = textField.text;
    if ([text isEqual:@""]) {//显示全部城市
        self.searchedCitiesTableView.hidden = YES;
    }
    else {//显示搜索城市
        //搜索
        [self.searchedCities removeAllObjects];
        NSArray *result = self.optionModel.allValues;
        for (int i=0;i<result.count;i++) {
            for (int j=0;j<[result[i] count];j++) {
                NSDictionary *tmp = result[i][j];
                NSString *tmpStr = tmp.allValues[1];
                if ([tmpStr hasPrefix:text]) {
                    [self.searchedCities addObject:tmpStr];
                }
            }
        }
        self.searchedCitiesTableView.hidden = NO;
        [self.searchedCitiesTableView reloadData];
    }
}

#pragma mark - Response Event

- (void)backToBasicPage {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Setter

- (void)setOptionModel:(NSDictionary *)optionModel {
    _optionModel = optionModel;
    
    self.sortedKeys = ({
        NSArray *array = [_optionModel.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSComparisonResult result = [obj1 compare:obj2];//升序, [obj2 compare:obj1]是降序
            return result;
        }];
        array;
    });
}

#pragma mark - Getter

- (UITableView *)locationTableView {
    if (!_locationTableView) {
        _locationTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _locationTableView.delegate = self;
        _locationTableView.dataSource = self;
        _locationTableView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
        _locationTableView.separatorStyle = NO;
    }
    return _locationTableView;
}

- (UITableView *)searchedCitiesTableView {
    if (!_searchedCitiesTableView) {
        _searchedCitiesTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _searchedCitiesTableView.delegate = self;
        _searchedCitiesTableView.dataSource = self;
        _searchedCitiesTableView.backgroundColor = [UIColor whiteColor];
        _searchedCitiesTableView.separatorStyle = NO;
    }
    return _searchedCitiesTableView;
}

- (UIView *)searchView {
    if (!_searchView) {
        _searchView = UIView.new;
        _searchView.backgroundColor = UIColor.whiteColor;
    }
    return _searchView;
}

- (UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        UIImageView *leftImgView = UIImageView.new;
        leftImgView.image = [UIImage imageNamed:@"search"];
        leftImgView.contentMode = UIViewContentModeScaleAspectFit;
        _searchTextField.leftView = leftImgView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.placeholder = @"Enter the city name";
        _searchTextField.layer.borderColor = [[UIColor grayColor] CGColor];
        _searchTextField.layer.borderWidth = 0.3;
        [_searchTextField setFont:[UIFont fontWithName:font size:20]];
    }
    return _searchTextField;
}

- (UILabel *)curCityLabel {
    if (!_curCityLabel) {
        _curCityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _curCityLabel.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    }
    return _curCityLabel;
}

- (UILabel *)curCityTextLabel {
    if (!_curCityTextLabel) {
        _curCityTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _curCityTextLabel.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
        _curCityTextLabel.text = @"Current City";
        [_curCityTextLabel setFont:[UIFont fontWithName:font size:18]];
    }
    return _curCityTextLabel;
}

- (UILabel *)curCity {
    if (!_curCity) {
        _curCity = [[UILabel alloc] initWithFrame:CGRectZero];
        _curCity.backgroundColor = [UIColor whiteColor];
    }
    return _curCity;
}

- (UILabel *)curCityText {
    if (!_curCityText) {
        _curCityText = [[UILabel alloc] initWithFrame:CGRectZero];
        _curCityText.backgroundColor = [UIColor whiteColor];
        _curCityText.text = self.curCityStr;
        _curCityText.textColor = [UIColor orangeColor];
        [_curCityText setFont:[UIFont fontWithName:font size:18]];
    }
    return _curCityText;
}

- (NSInteger)cellHeight {
    return 45.0f;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([tableView isEqual:self.locationTableView]) {
        return self.optionModel.count;
    }
    else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.locationTableView]) {
        NSString *sectionKey = self.sortedKeys[section];
        NSArray *cities = [self.optionModel objectForKey:sectionKey];
        return cities.count;
    }
    else {
        return [self.searchedCities count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellIdentifier"];
    if ([tableView isEqual:self.locationTableView]) {
        NSString *sectionKey = self.sortedKeys[indexPath.section];
        NSArray *cities = [self.optionModel objectForKey:sectionKey];
        NSError *error = nil;
        CityItem *item = [[CityItem alloc] initWithDictionary:cities[indexPath.row] error:&error];
        cell.textLabel.text = item.text;
        [cell.textLabel setFont:[UIFont fontWithName:font size:18]];
        return cell;
    }
    else {

        cell.textLabel.text = self.searchedCities[indexPath.row];
        [cell.textLabel setFont:[UIFont fontWithName:font size:18]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([tableView isEqual:self.locationTableView]) {
        return self.cellHeight;
    }
    else {
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([tableView isEqual:self.locationTableView]) {
        return self.sortedKeys[section];
    }
    else {
        return @"";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.locationTableView]) {
        UITableViewCell *cell = [self.locationTableView cellForRowAtIndexPath:indexPath];
        [BasicPageViewController setLocateCity:cell.textLabel.text];
    }
    else {
        UITableViewCell *cell = [self.searchedCitiesTableView cellForRowAtIndexPath:indexPath];
        [BasicPageViewController setLocateCity:cell.textLabel.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
