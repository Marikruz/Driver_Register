//
//  UpLoadViewController.m
//  Driver_Register
//
//  Created by didi on 2021/2/23.
//

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)

#import "UpLoadViewController.h"
#import "PhotoCollectionViewCell.h"
#import <Masonry/Masonry.h>

extern NSString *font;

@interface UpLoadViewController ()<PhotoCollectionCellDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *imgView;
@property (nonatomic, strong) UIImageView *passportimg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *submitConfir;
@property (nonatomic, strong) UIButton *submit;
@property (nonatomic, strong) UIButton *addPhoto;
@property (nonatomic, strong) UIAlertController *actionsheet;

@property (nonatomic, assign) BOOL uploadOrReupload;//NO:upload  YES:reupload

@property (nonatomic, assign) BOOL uploadType;//NO:使用UICollecitonView minpicnum==maxpicnum YES:不使用UICollecitonView minpicnum<maxpicnum
@property (nonatomic, assign) NSInteger minpicnum;
@property (nonatomic, assign) NSInteger maxpicnum;
//多图片选择视图
@property (nonatomic,strong) UICollectionView *collectionView;
//图片路径数组
@property (nonatomic,strong) NSMutableArray * imageArr;
//每行显示的图片数量
@property (nonatomic, assign) NSInteger numOfRow;
//每行的高度
@property (nonatomic, assign) NSInteger heightOfRow;

@end

@implementation UpLoadViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self setUpViews];
}

# pragma mark - Private Method

- (void)initView {
    //设置界面和导航栏
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(backToAuditPage)];
    self.navigationItem.leftBarButtonItem = backBtn;
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.frame = CGRectZero;
    titlelabel.text =@"Register";
    [titlelabel sizeToFit];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = titlelabel;
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.uploadOrReupload = NO;

    switch (self.status) {
        case 1:
        case 5:
        {
            self.minpicnum = self.auditFormItem.pic_field[0].min_pic_num;
            self.maxpicnum = self.auditFormItem.pic_field[0].max_pic_num;
        }
            break;
        case 3:
        case 4:
        {
            self.minpicnum = self.auditFormItem.min_pic_num;
            self.maxpicnum = self.auditFormItem.max_pic_num;
        }
            break;
        default:
            break;
    }
    if (self.minpicnum == self.maxpicnum)
        self.uploadType = YES;
    else
        self.uploadType = NO;
}

- (void)setUpViews {
    self.view.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.imgView];
    [self.imgView addSubview:self.passportimg];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descLabel];
    [self.contentView addSubview:self.addPhoto];
    [self.contentView addSubview:self.collectionView];
    [self.view addSubview:self.submit];
    [self.view addSubview:self.submitConfir];
    
    [self.submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
        make.top.equalTo(self.submit.mas_bottom).with.offset(-60);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
    }];
    
    [self.submitConfir mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.submit.mas_top).with.offset(-10);
        make.top.equalTo(self.submitConfir.mas_bottom).with.offset(-60);
        make.left.right.equalTo(self.submit);
    }];
    self.submitConfir.hidden = YES;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(88);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.submit.mas_top).with.offset(-20);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.imgView.mas_top).with.offset(320);
    }];
    
    NSInteger topwidth;
    NSInteger leftwidth;
    switch (self.status) {
        case 1:
        case 5:
        {
            topwidth = 25;
            leftwidth = 40;
        }
            break;
        case 3:
        {
            topwidth = 20;
            leftwidth = 50;
        }
            break;
        case 4:
        {
            topwidth = 75;
            leftwidth = 40;
        }
            break;
        default:
        {
            topwidth = 0;
            leftwidth = 0;
        }
            break;
    }
    [self.passportimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_top).with.offset(topwidth);
        make.left.equalTo(self.imgView.mas_left).with.offset(leftwidth);
        make.right.equalTo(self.imgView.mas_right).with.offset(0-leftwidth);
        make.bottom.equalTo(self.imgView.mas_bottom).with.offset(0-topwidth);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.titleLabel.mas_top).with.offset(50);
    }];
    
    NSInteger descheight;
    switch (self.status) {
        case 1:
            descheight = 220;
            break;
        case 3:
            descheight = 200;
            break;
        case 4:
            descheight = 270;
            break;
        case 5:
            descheight = 340;
            break;
        default:
            descheight = 0;
            break;
    }
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(-10);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.bottom.equalTo(self.titleLabel.mas_bottom).with.offset(descheight);
    }];
    
    [self.addPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.descLabel.mas_left).with.offset(0);
        make.right.equalTo(self.addPhoto.mas_left).with.offset(20);
        make.bottom.equalTo(self.addPhoto.mas_top).with.offset(20);
    }];
    
    NSInteger collectionheight;
    NSInteger row = self.maxpicnum/self.numOfRow + (self.maxpicnum%self.numOfRow==0?0:1);
    NSLog(@"row: %ld", row);
    if (self.uploadType) {
        collectionheight = 0;
    }
    else {
        collectionheight = (self.heightOfRow+10)*row;
    }
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addPhoto.mas_bottom).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(5);
        make.right.equalTo(self.contentView.mas_right).with.offset(-5);
        make.bottom.equalTo(self.collectionView.mas_top).with.offset(collectionheight);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.collectionView.mas_bottom);
    }];
    
    if (self.uploadType) {
        self.addPhoto.hidden = YES;
        self.collectionView.hidden = YES;
        [self setUploadBtn];
    }
    else {
        [self setAddPhotoBtn];
        [self setSubmitBtn];
    }
}

- (void)setAddPhotoBtn {
    if (self.imageArr.count<self.maxpicnum) {
        [self.addPhoto setBackgroundColor:[UIColor orangeColor]];
        [self.addPhoto setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.addPhoto.hidden = NO;
    }
    else {
        self.addPhoto.hidden = YES;
    }
}

- (void)setUploadBtn {
    [self.submit setBackgroundColor:[UIColor orangeColor]];
    [self.submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submit.userInteractionEnabled = YES;
}

- (void)setSubmitBtn {
    if (self.imageArr.count >= 1) {
        [self.submit setBackgroundColor:[UIColor orangeColor]];
        [self.submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.submit.userInteractionEnabled = YES;
    }
    else {
        [self.submit setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:240.0/255.0 alpha:1]];
        [self.submit setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
        self.submit.userInteractionEnabled = NO;
    }
}

#pragma mark - Response Event

- (void)backToAuditPage {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)clickAddPhoto {
    [self createActionSheet];
}

- (void)clickUpLoad {
    if (!self.uploadOrReupload) {
        [self createActionSheet];
    }
    else {//reupload
        //将imgArr清空
        [self.imageArr removeObjectAtIndex:0];
        [self.passportimg setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.auditFormItem.exam_pic_url[0]]]]];
        self.titleLabel.hidden = NO;
        self.descLabel.hidden = NO;
        self.submitConfir.hidden = YES;
        [self.submit setTitle:@"UPLOAD" forState:UIControlStateNormal];
        [self.submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.submit setBackgroundColor:[UIColor orangeColor]];
    }
    self.uploadOrReupload = !self.uploadOrReupload;
}

- (void)createActionSheet {
    //创建
    self.actionsheet = [[UIAlertController alloc] init];
    if (self.uploadType) {
        //添加按钮
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"photo library action");
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            [imgPicker setAllowsEditing:YES];
            [imgPicker setDelegate:self];
            [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentViewController:imgPicker animated:YES completion:NULL];
            //[self upLoad];
        }];
        UIAlertAction *browseAction = [UIAlertAction actionWithTitle:@"Browse" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"browse action");
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancel action");
        }];
        [self.actionsheet addAction:photoAction];
        [self.actionsheet addAction:browseAction];
        [self.actionsheet addAction:cancelAction];
    }
    else {
        //添加按钮
        UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:@"Take a picture" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"picture action");
        }];
        UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"Album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"album action");
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            [imgPicker setAllowsEditing:YES];
            [imgPicker setDelegate:self];
            [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentViewController:imgPicker animated:YES completion:NULL];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancel action");
        }];
        [self.actionsheet addAction:pictureAction];
        [self.actionsheet addAction:albumAction];
        [self.actionsheet addAction:cancelAction];
    }
    //显示
    [self presentViewController:self.actionsheet animated:YES completion:nil];
}

- (void)upLoad {
    self.passportimg.image = [self.imageArr objectAtIndex:0];
    self.titleLabel.hidden = YES;
    self.descLabel.hidden = YES;
    self.submitConfir.hidden = NO;
    [self.submit setTitle:@"REUPLOAD" forState:UIControlStateNormal];
    [self.submit setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.submit setBackgroundColor:[UIColor whiteColor]];
    [self.submit.layer setBorderWidth:1];//边框宽度
    [self.submit.layer setBorderColor:UIColor.orangeColor.CGColor];//边框颜色
}

- (void)commitPhoto {
    NSLog(@"photos: %@", self.imageArr);
    //
    //修改field_status
    //
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - UIActionSheet

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex ==0) {
        //相机
        UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
        [imgPicker setAllowsEditing:YES];
        [imgPicker setDelegate:self];
        [imgPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imgPicker animated:YES completion:NULL];
    }
    if (buttonIndex ==1) {
        UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
        [imgPicker setAllowsEditing:YES];
        [imgPicker setDelegate:self];
        [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:imgPicker animated:YES completion:NULL];
    }
}

//相机
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    [self.imageArr addObject:image];
    //添加图片，修改按钮
    if (self.uploadType) {
        [self upLoad];
    }
    else {
        [self setAddPhotoBtn];
        [self setSubmitBtn];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.collectionView reloadData];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    return;
}

#pragma mark - UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //NSLog(@"%d", self.imageArr.count);
    return self.imageArr.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    cell.imgView.image = [self.imageArr objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake(self.heightOfRow, self.heightOfRow);
}

//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 5, 5, 5);
}

//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择图片%ld",indexPath.row);
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)moveImageBtnClick:(PhotoCollectionViewCell *)aCell {
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:aCell];
    [self.imageArr removeObjectAtIndex:indexPath.row];
    //图片数量改变，修改按钮
    [self setAddPhotoBtn];
    [self setSubmitBtn];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    }
    return _contentView;
}

- (UIView *)imgView {
    if (!_imgView) {
        _imgView = [[UIView alloc] initWithFrame:CGRectZero];
        _imgView.backgroundColor = UIColor.blackColor;
    }
    return _imgView;
}

- (UIImageView *)passportimg {
    if (!_passportimg) {
        _passportimg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _passportimg.backgroundColor = UIColor.whiteColor;
        if (self.status == 1||self.status == 4)
            _passportimg.layer.cornerRadius = 23;
        [_passportimg setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.auditFormItem.exam_pic_url[0]]]]];
        _passportimg.contentMode = UIViewContentModeScaleToFill;
    }
    return _passportimg;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = UIColor.clearColor;
        _titleLabel.text = self.auditFormItem.pic_desc.title;
        _titleLabel.textColor = UIColor.blackColor;
        [_titleLabel setFont:[UIFont fontWithName:font size:25]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _descLabel.backgroundColor = UIColor.clearColor;
        NSMutableString *textStr = [[NSMutableString alloc]init];
        NSInteger count = [self.auditFormItem.pic_desc.content count];
        for (NSInteger i=0;i<count;i++) {
            [textStr appendString:self.auditFormItem.pic_desc.content[i]];
            if (i != (count-1))
                [textStr appendString:@"\n"];
        }
        _descLabel.text = textStr;
        _descLabel.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
        _descLabel.numberOfLines = 20;
        _descLabel.textColor = UIColor.grayColor;
        [_descLabel setFont:[UIFont fontWithName:font size:15]];
        _descLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _descLabel;
}

- (UIButton *)submitConfir {
    if (!_submitConfir) {
        _submitConfir = [[UIButton alloc]initWithFrame:CGRectZero];
        [_submitConfir setTitle:@"Submit" forState:UIControlStateNormal];
        [_submitConfir.titleLabel setFont:[UIFont fontWithName:font size:18]];
        _submitConfir.layer.cornerRadius = 5;
        _submitConfir.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_submitConfir setBackgroundColor:[UIColor orangeColor]];
        [_submitConfir setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitConfir addTarget:self action:@selector(commitPhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitConfir;
}

- (UIButton *)submit {
    if (!_submit) {
        _submit = [[UIButton alloc]initWithFrame:CGRectZero];
        _submit.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        if (self.uploadType) {
            [_submit setTitle:@"UPLOAD" forState:UIControlStateNormal];
            [_submit.titleLabel setFont:[UIFont fontWithName:font size:18]];
            _submit.layer.cornerRadius = 5;
            [_submit addTarget:self action:@selector(clickUpLoad) forControlEvents:UIControlEventTouchUpInside];
        }
        else {
            [_submit setTitle:@"Submit" forState:UIControlStateNormal];
            [_submit.titleLabel setFont:[UIFont fontWithName:font size:20]];
            [_submit addTarget:self action:@selector(commitPhoto) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _submit;
}

- (UIButton *)addPhoto {
    if (!_addPhoto) {
        _addPhoto = [[UIButton alloc]initWithFrame:CGRectZero];
        _addPhoto.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_addPhoto setTitle:@"+" forState:UIControlStateNormal];
        [_addPhoto.titleLabel setFont:[UIFont fontWithName:font size:18]];
        _addPhoto.layer.cornerRadius = 10;
        [_addPhoto addTarget:self action:@selector(clickAddPhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addPhoto;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    }
    return _collectionView;
}

- (NSMutableArray *)imageArr {
    if (!_imageArr) {
        _imageArr = [NSMutableArray arrayWithCapacity:self.maxpicnum];
        //从json文件中读取已经上传的图片路径

    }
    return _imageArr;
}

- (NSInteger)numOfRow {
    return 3;
}

- (NSInteger)heightOfRow {
//    NSLog(@"heightOfRow: %f", (fDeviceWidth-20)/self.numOfRow);
    return (fDeviceWidth-20)/self.numOfRow;
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
