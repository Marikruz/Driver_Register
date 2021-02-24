//
//  AuditInfoViewController.m
//  Driver_Register
//
//  Created by didi on 2021/1/25.
//

#import "AuditInfoViewController.h"
#import "DriverLicenceViewController.h"
#import "DeclarationViewController.h"
#import "UpLoadViewController.h"
#import "HandViewController.h"
#import "AuditInfo_req.h"
#import "AuditInfoModel.h"
#import "BannerTableViewCell.h"
#import "MultiPhotoTableViewCell.h"
#import "ButtonTableViewCell.h"

extern NSString *font;

@interface AuditInfoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) AuditInfo_req *auditinfo_req;
@property (nonatomic, copy) NSString *auditinfo_path;
@property (nonatomic, strong) AuditInfoModel *auditinfomodel;

@property (nonatomic, strong) UIView *bannerView;
@property (nonatomic, strong) UITableView *auditinfoView;
@property (nonatomic, assign) int banner_height;
@property (nonatomic, strong) UIImageView *banner_imgview;
@property (nonatomic, strong) UIView *labelview;
@property (nonatomic, assign) int label_height;
@property (nonatomic, assign) int banner_imgview_height;
@property (nonatomic, strong) UILabel *banner_title;
@property (nonatomic, strong) UILabel *banner_desc;

@end

@implementation AuditInfoViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initAuditInfo];
    self.auditinfo_req = [AuditInfo_req new];
    [self.auditinfo_req dataTask];
    [self performSelector:@selector(loadAuditInfo) withObject:@"5" afterDelay:1.0];
    [self performSelector:@selector(setTableView) withObject:@"6" afterDelay:2.0];
}

#pragma mark - Public Method

- (void)jumpToHand {
    HandViewController *hand = [[HandViewController alloc]init];
    hand.auditFormItem = self.Handformitem;
    hand.BasicOrAudit = NO;
    [self.navigationController pushViewController:hand animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - Private Method

- (void)initAuditInfo {
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
}

- (void)loadAuditInfo {
    self.auditinfo_path = [AuditInfo_req getPath];
    NSData *data = [NSData dataWithContentsOfFile:self.auditinfo_path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.auditinfomodel = [[AuditInfoModel alloc] initWithDictionary:json error:nil];
}

- (void)setTableView {
    //设置tableview
    self.auditinfoView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.auditinfoView.dataSource = self;
    self.auditinfoView.delegate = self;
    [self.view addSubview:self.auditinfoView];
    self.auditinfoView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    self.auditinfoView.separatorStyle = NO;
    //注册cell
    [self.auditinfoView registerClass:[MultiPhotoTableViewCell class] forCellReuseIdentifier:@"MultiPhotoTableViewCell"];
    [self.auditinfoView registerClass:[BannerTableViewCell class] forCellReuseIdentifier:@"BannerTableViewCell"];
    [self.auditinfoView registerClass:[ButtonTableViewCell class] forCellReuseIdentifier:@"ButtonTableViewCell"];
    
}

- (void)backToStartPage {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - Getter

- (int)banner_height {
    return 230;
}

- (int)banner_imgview_height {
    return self.banner_height*0.3;
}

- (int)label_height {
    return self.banner_height*0.55;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.banner_height)];
    self.bannerView.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:122.0/255.0 blue:61.0/255.0 alpha:1];
    
    self.labelview = [[UIView alloc]initWithFrame:CGRectMake(0, self.banner_height-self.label_height, self.view.bounds.size.width, self.label_height)];
    self.labelview.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    int blank_height_top = 25;
    int blank_height_left = 20;
    self.banner_title = [[UILabel alloc] initWithFrame:CGRectMake(blank_height_left, blank_height_top, self.view.bounds.size.width-blank_height_left*2, 80)];
    self.banner_title.textColor = [UIColor blackColor];
    self.banner_title.backgroundColor = [UIColor clearColor];
    
    //行间距
    NSString *str = self.auditinfomodel.data.form[1].title;
    [self.banner_title setNumberOfLines:0];
    [self.banner_title setFont:[UIFont fontWithName:@"Helvetica" size:22]];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:0];
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    [self.banner_title setAttributedText:attStr];
    [self.banner_title sizeToFit];
    
    [self.labelview addSubview:self.banner_title];
    self.banner_desc = [[UILabel alloc] initWithFrame:CGRectMake(blank_height_left, blank_height_top+(self.label_height-blank_height_top)/2, self.view.bounds.size.width-blank_height_left*2, (self.label_height-blank_height_top)/2)];
    self.banner_desc.text = self.auditinfomodel.data.form[1].desc;
    self.banner_desc.textColor = [UIColor grayColor];
    self.banner_desc.backgroundColor = [UIColor clearColor];
    [self.banner_desc setFont:[UIFont fontWithName:font size:15]];
    self.banner_desc.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
    self.banner_desc.numberOfLines = 2;
    [self.labelview addSubview:self.banner_desc];
    [self.bannerView addSubview:self.labelview];
    
    self.banner_imgview = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-self.banner_imgview_height/2, (self.banner_height-self.label_height)/2, self.banner_imgview_height, self.banner_imgview_height)];
    self.banner_imgview.backgroundColor = [UIColor redColor];
    [self.banner_imgview setImage:[UIImage imageNamed:@"sun1.jpg"]];
    [self.bannerView addSubview:self.banner_imgview];
    return self.bannerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.banner_height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.auditinfomodel.data.form.count-2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row+2;
    switch (indexPath.row) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 7:
        {
            MultiPhotoTableViewCell *multiphotocell = [tableView dequeueReusableCellWithIdentifier:@"MultiPhotoTableViewCell"];
            multiphotocell.model = self.auditinfomodel.data.form[row];
            multiphotocell.selectionStyle = NO;
            return multiphotocell;
        }
            break;
        case 6:
        {
            BannerTableViewCell *bannercell = [tableView dequeueReusableCellWithIdentifier:@"BannerTableViewCell"];
            bannercell.model = self.auditinfomodel.data.form[row];
            bannercell.selectionStyle = NO;
            bannercell.backgroundColor = [UIColor clearColor];
            return bannercell;
        }
            break;
        case 8:
        {
            ButtonTableViewCell *buttoncell = [tableView dequeueReusableCellWithIdentifier:@"ButtonTableViewCell"];
            buttoncell.model = self.auditinfomodel.data.form[row];
            self.Handformitem = self.auditinfomodel.data.form[row];
            buttoncell.controller = self;
            buttoncell.selectionStyle = NO;
            buttoncell.backgroundColor = [UIColor clearColor];
            return buttoncell;
        }
        default:
            return UITableViewCell.new;
            break;
    }
    return UITableViewCell.new;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row+2;
    switch (indexPath.row) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 7:
        {
            if (self.auditinfomodel.data.form[row].field_status == 5) {
                return 135;
            }
            else {
                return 120;
            }
        }
            break;
        case 6:
        {
            return 75;
        }
            break;
        default:
        {
            return 150;
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row+2;
    switch (indexPath.row) {
        case 0:
        {
            //Driver Licence界面
            DriverLicenceViewController *driverlicence = [[DriverLicenceViewController alloc]init];
            driverlicence.auditFormItem = self.auditinfomodel.data.form[row];
            [self.navigationController pushViewController:driverlicence animated:YES];
        }
            break;
        case 2://Insurance Declaration界面
        case 7://CPVR界面
        {
            DeclarationViewController *declaration = [[DeclarationViewController alloc]init];
            declaration.auditFormItem = self.auditinfomodel.data.form[row];
            declaration.hasSubmit = NO;
            declaration.status = indexPath.row;
            [self.navigationController pushViewController:declaration animated:YES];
        }
            break;
        case 1://Proof of Identity界面
        case 3://portrait界面
        case 4://driver accreditation界面
        case 5://vehicle inspection report界面
        {
            UpLoadViewController *upload = [[UpLoadViewController alloc]init];
            upload.auditFormItem = self.auditinfomodel.data.form[row];
            upload.hasSubmit = NO;
            upload.status = indexPath.row;
            [self.navigationController pushViewController:upload animated:YES];
        }
            break;;
        default:
            break;
    }
}

//tip-color-0/banner-1,8/multi-photo-2,3,7/declare-4,9/portrait-5/photo-6/button-10

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
