//
//  RegisterViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterRequest.h"

@interface RegisterViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatorImageView;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;


@property (strong, nonatomic) UIImagePickerController *pickerController;
@property(assign,nonatomic)BOOL loginState;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginState = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBack.jpg"]];
    self.avatorImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    
    [self.avatorImageView addGestureRecognizer:tap];
    
    self.avatorImageView.layer.masksToBounds = YES;
    self.avatorImageView.layer.cornerRadius = self.avatorImageView.bounds.size.width / 2;
}
- (IBAction)cancleAction:(id)sender {
    [self alert:@"提示" message:@"确定放弃注册?"];
}

- (IBAction)registerAction:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"提示" preferredStyle:(UIAlertControllerStyleAlert)];
    // 验证 判断用户名密码
    if(self.userNameTextField.text.length == 0){
        
        alertController.message = @"用户名为空";
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
        [alertController addAction:OKAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else if (self.passWordTextField.text.length == 0){
        
        alertController.message = @"密码为空";
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
        [alertController addAction:OKAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }else{
        RegisterRequest *request = [[RegisterRequest alloc] init];
        [request RegisterWithUserName:self.userNameTextField.text passWord:self.passWordTextField.text avatar:self.avatorImageView.image success:^(NSDictionary *dic) {
        
            NSLog(@"1,%@",dic);
            NSString *code = [[dic objectForKey:@"code"] stringValue];
            if ([code isEqualToString:@"1005"]) {
                self.loginState = YES;
                NSString *avatar = [[dic objectForKey:@"data"] objectForKey:@"avatar"];
                NSString *userId = [[dic objectForKey:@"data"] objectForKey:@"userId"];
                // 保存头像、id、用户名、密码以及登录状态到本地
                [[NSUserDefaults standardUserDefaults] setObject:avatar forKey:@"avatar"];
                [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
                [[NSUserDefaults standardUserDefaults] setObject:self.userNameTextField.text forKey:@"userName"];
                [[NSUserDefaults standardUserDefaults] setObject:self.passWordTextField.text forKey:@"passWord"];
                [[NSUserDefaults standardUserDefaults] setBool:self.loginState forKey:@"loginState"];
                // 保存
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self alert:@"提示" message:@"注册成功"];
                
            }else if ([code isEqualToString:@"1002"]){
                [self alert:@"提示" message:@"该用户名已被使用，请更换用户名"];
            }
        } failure:^(NSError *error) {
        
            NSLog(@"0,%@",error);
        
        }];
    }
}
#pragma mark--注册结果提示框--
- (void)alert:(NSString *)title message:(NSString *)message{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if ([message isEqualToString:@"注册成功"] || [message isEqualToString:@"确定放弃注册?"]) {
            // 注册界面消失
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [alertView addAction:action];
    [self presentViewController:alertView animated:YES completion:nil];
}

- (void)tapAction{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"提示" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        
        // 判断选择的模式是否为相机模式，如果没有，则弹出警告
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.pickerController = [UIImagePickerController new];
            
            // 设置代理
            self.pickerController.delegate = self;
            // 设置相机模式
            self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:self.pickerController animated:YES completion:nil];
        }else{
            
            // 若是未检测到有相机，则提示没有相机
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"未检测到相机" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
            [alertController addAction:OKAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [self invokePhoto];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alertController addAction:camera];
    [alertController addAction:photo];
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


// 三个代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = nil;
    // 判断一下我们从哪里获取照片
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        // 修改前的image
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    }else{
        
        // 可编辑UIImagePickerControllerEditedImage（获取编辑后的图片）
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    
    // 设置图片
    self.avatorImageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




- (IBAction)ImageAction:(id)sender {
    
    
}


- (void)invokePhoto{
    
    self.pickerController = [UIImagePickerController new];
    // 设置代理
    self.pickerController.delegate = self;
    // 允许编辑图片
    self.pickerController.allowsEditing = YES;
    // 设置相册选完照片后，是否调到编辑模式，进行图片剪辑
    [self presentViewController:self.pickerController animated:YES completion:nil];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
