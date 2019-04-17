//
//  LoginTestCaseViewController.m
//  CloudLinkMeetingDemo
//
//  Created by zhangjianfang on 2019/3/13.
//  Copyright © 2019年 huawei. All rights reserved.
//

#import "LoginTestCaseViewController.h"
#import <CloudLink_Meeting/CloudLinkMeeting.h>

#define START_Y 80
#define TEXT_FIELD_WIDTH 200
#define TEXT_FIELD_HEIGHT 40
#define FIELD_H_SEP   10

@interface LoginTestCaseViewController ()
@property (nonatomic, strong) UITextField *serverAddressField;
@property (nonatomic, strong) UITextField *serverPortField;
@property (nonatomic, strong) UITextField *userAccountField;
@property (nonatomic, strong) UITextField *userPasswordField;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, weak) CloudLinkMeeting *clm;
@end

@implementation LoginTestCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _clm = [CloudLinkMeeting sharedInstance];
    [self.view addSubview:self.serverAddressField];
    [self.view addSubview:self.serverPortField];
    [self.view addSubview:self.userAccountField];
    [self.view addSubview:self.userPasswordField];
    [self.view addSubview:self.loginBtn];
}

- (UITextField *)serverAddressField {
    if (nil == _serverAddressField) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _serverAddressField = [[UITextField alloc] initWithFrame:CGRectMake((width - TEXT_FIELD_WIDTH) / 2,
                                                                            START_Y,
                                                                            TEXT_FIELD_WIDTH,
                                                                            TEXT_FIELD_HEIGHT)];
        _serverAddressField.borderStyle = UITextBorderStyleLine;
        _serverAddressField.text = @"";
        _serverAddressField.placeholder = @"服务器地址";
    }
    return _serverAddressField;
}

- (UITextField *)serverPortField {
    if (nil == _serverPortField) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _serverPortField = [[UITextField alloc] initWithFrame:CGRectMake((width - TEXT_FIELD_WIDTH) / 2,
                                                                         START_Y + FIELD_H_SEP + TEXT_FIELD_HEIGHT,
                                                                         TEXT_FIELD_WIDTH,
                                                                         TEXT_FIELD_HEIGHT)];
        _serverPortField.borderStyle = UITextBorderStyleLine;
        _serverPortField.text = @"";
        _serverPortField.placeholder = @"服务器端口";
    }
    return _serverPortField;
}

- (UITextField *)userAccountField {
    if (nil == _userAccountField) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _userAccountField = [[UITextField alloc] initWithFrame:CGRectMake((width - TEXT_FIELD_WIDTH) / 2,
                                                                       START_Y + 2 * FIELD_H_SEP + 2 * TEXT_FIELD_HEIGHT,
                                                                       TEXT_FIELD_WIDTH,
                                                                       TEXT_FIELD_HEIGHT)];
        _userAccountField.borderStyle = UITextBorderStyleLine;
        _userAccountField.text = @"";
        _userAccountField.placeholder = @"用户名";
    }
    
    return _userAccountField;
}

- (UITextField *)userPasswordField {
    if (nil == _userPasswordField) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _userPasswordField = [[UITextField alloc] initWithFrame:CGRectMake((width - TEXT_FIELD_WIDTH) / 2,
                                                                           START_Y + 3 * FIELD_H_SEP + 3 * TEXT_FIELD_HEIGHT,
                                                                           TEXT_FIELD_WIDTH,
                                                                           TEXT_FIELD_HEIGHT)];
        _userPasswordField.borderStyle = UITextBorderStyleLine;
        _userPasswordField.text = @"";
        _userPasswordField.placeholder = @"密码";
    }
    return _userPasswordField;
}

- (UIButton *)loginBtn {
    if (nil == _loginBtn) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.backgroundColor = [UIColor redColor];
        [_loginBtn setTitle:@"clm_login" forState:UIControlStateNormal];
        _loginBtn.frame = CGRectMake((width - TEXT_FIELD_WIDTH) / 2,
                                     START_Y + 4 * FIELD_H_SEP + 4 * TEXT_FIELD_HEIGHT,
                                     TEXT_FIELD_WIDTH,
                                     TEXT_FIELD_HEIGHT);
        [_loginBtn addTarget:self action:@selector(loginToClm:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (void)loginToClm:(id)sender {
    [self.view endEditing:YES];
    clmLoginParam *loginParam = [[clmLoginParam alloc] init];
    loginParam.serverAddress = self.serverAddressField.text;
    loginParam.serverPort = [self.serverPortField.text integerValue];
    loginParam.account = self.userAccountField.text;
    loginParam.password = self.userPasswordField.text;//@"1qaz@WSX";
    UIActivityIndicatorView *activeView = [[UIActivityIndicatorView alloc] initWithFrame:self.view.bounds];
    activeView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activeView.color = [UIColor grayColor];
    [self.view addSubview:activeView];
    [activeView startAnimating];
    [_clm clm_login:loginParam completionBlock:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [activeView stopAnimating];
            [activeView removeFromSuperview];
            NSLog(@"clm_login result is:%@", error);
            NSString *message = (nil == error ? @"success" : [NSString stringWithFormat:@"failed:%@", error]);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"clm_login result" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self.navigationController presentViewController:alert animated:YES completion:nil];
        });
    }];
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
