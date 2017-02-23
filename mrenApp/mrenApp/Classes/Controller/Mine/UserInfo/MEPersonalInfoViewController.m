//
//  PersonalInfoViewController.m
//  VChat
//
//  Created by zhouen on 16/8/11.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEPersonalInfoViewController.h"
#import "MEUpdateNameViewController.h"
#import "UIImage+Extension.h"
#import "MEActionSheet.h"
#import "MEUpdateSexSheet.h"

#import "MEUpdateViewModel.h"

#import "MEUserRequest.h"

#import "MESection.h"
#import "MEItem.h"
#import "MEUser.h"

@interface MEPersonalInfoViewController ()<MEActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end
@implementation MEPersonalInfoViewController

#pragma mark ------ Lifecycle

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellType = SettingCellTypeCustom;
    [self p_initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"个人资料";
    
    [MEUser getUserInfo];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------ setter getter


#pragma mark ------ Public


#pragma mark ------ Private
- (void)p_initData {
    self.sections = @[[self p_getSection1]];
}

// 上传头像
-(void)p_didSelectHeaderImage{
    MEActionSheet *sheet = [[MEActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitle:@"拍照",@"从手机相册选择", nil];
    [sheet setCancelButtonTitleColor:[UIColor blackColor] fontSize:0];
    [sheet setButtonTitleColor:[UIColor blackColor] fontSize:0];
    [sheet show];
}

//昵称
- (void)p_didSelectNickName {
    [self.navigationController pushViewController:[MEUpdateNameViewController new] animated:YES];
}

#pragma mark 性别
- (void)p_didSelectSex {
    MEUpdateSexSheet *sheet = [[MEUpdateSexSheet alloc] initWithFrame:self.view.bounds];
    sheet.sex = [MEUser userDefaults].sex == 0 ? @"男" : @"女";
    sheet.sexBlock = ^(int sex){
        [MEUpdateViewModel updateSex:sex];
    };
    [self.view addSubview:sheet];
    sheet.alpha = 0.0;
    
    [UIView animateWithDuration:0.3 animations:^{
        sheet.alpha = 1.0;
    }completion:^(BOOL finished) {
        
    }];
}

- (MESection *)p_getSection1 {
    @weakify(self);
    MEItem *item1 = [MEItem itemWithText:@"头像" actionBlock:^{
        @strongify(self);
        [self p_didSelectHeaderImage];
        
    }];
    item1.detailImageUrl = [URLUtil getHeaderImagePath:User.headPortrait];
    
    MEItem *item2 = [MEItem itemWithText:@"昵称" detailText:[MEUser userDefaults].nickname actionBlock:^{
        @strongify(self);
        [self p_didSelectNickName];
    }];
    
    NSString *sex = [MEUser userDefaults].sex == 0 ? @"男" : @"女";
    MEItem *item3 = [MEItem itemWithText:@"性别" detailText:sex actionBlock:^{
        @strongify(self);
        [self p_didSelectSex];
    }];
    
    MESection *section = [[MESection alloc] init];
    section.items = @[item1 ,item2 ,item3];
    section.headerHeight = 0.1f;
    
    
    [RACObserve(User, headPortrait) subscribeNext:^(id x) {
        @strongify(self);
        item1.detailImageUrl = [URLUtil getHeaderImagePath:x];
        [self.tableView reloadData];
    }];
    
    [[[RACObserve([MEUser userDefaults], nickname) distinctUntilChanged] skip:1] subscribeNext:^(id x) {
        @strongify(self);
        item2.detailText = x;
        [self.tableView reloadData];
    }];
    
    [[[RACObserve([MEUser userDefaults], sex) distinctUntilChanged] skip:1] subscribeNext:^(id x) {
        @strongify(self);
        item3.detailText = [x intValue] == 0 ? @"男" : @"女";
        [self.tableView reloadData];
    }];
    
    return section;
}
- (MESection *)p_getSection2 {
    MEItem *item1 = [MEItem itemWithText:@"资助小编" imageName:@"mine_hen" actionBlock:^{
        
    }];
    MESection *section = [[MESection alloc] init];
    section.items = @[item1];
    return section;
}

#pragma mark 打开相机
- (void)p_openCamera {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
        
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请使用真机进行" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
    
}

#pragma mark 打开相册
- (void)p_openPhotoAlbum {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        
        self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        
    }
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark ------ Protocol
#pragma mark ------ MEActionSheetDelegate
- (void)actionSheet:(MEActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self p_openCamera];//打开相机
            break;
        case 1:
            [self p_openPhotoAlbum];//打开相册
            break;
            
        default:
            break;
    }
}
#pragma mark ------ UITableViewDataSource
#pragma mark ------ UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    }
    return 44;
}
#pragma mark ------ UIImagePickerControllerDelegate
//相册选取照片
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        //调整图片方向，防止上传后图片方向不对
        image = [UIImage fixOrientation:image];
        image = [UIImage imageWithImageSimple:image scaledToSize:CGSizeMake(120, 120)];
        NSData *data = nil;
        NSString *fileName = nil;
        long long currentTime = [[NSDate date] timeIntervalSince1970]*1000;
        if (UIImagePNGRepresentation(image)) {
            //返回为png图像。
            fileName = [NSString stringWithFormat:@"%lld.png",currentTime];
        }else {
            //返回为JPEG图像。
            fileName = [NSString stringWithFormat:@"%lld.jpg",currentTime];
        }
        data = [self imageData:image];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.label.text = @"上传中～";
        
        [[MEUserRequest uploadHeaderImage:data fileName:fileName] subscribeNext:^(id x) {
            User.headPortrait = x;
            [hud hideAnimated:YES];
            [self.view makeCenterToast:@"上传头像成功"];
            
        } error:^(NSError *error) {
            [hud hideAnimated:YES];
            [self.view makeCenterToast:@"上传头像出现异常！"];
        }];
    
    }
}

//取消图片选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark ------ Override
- (NSData *)imageData:(UIImage *)myimage {
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M  0.5
            data=UIImageJPEGRepresentation(myimage, 0.3);
        }else if (data.length>200*1024) {//0.25M-0.5M 0.9
            data=UIImageJPEGRepresentation(myimage, 0.5);
        }
    }
    return data;
}


@end
