//
//  JoinConfTestCaseViewController.m
//  CloudLinkMeetingDemo
//
//  Created by zhangjianfang on 2019/3/14.
//  Copyright © 2019年 huawei. All rights reserved.
//

#import "JoinConfTestCaseViewController.h"
#import <CloudLink_Meeting/CloudLinkMeeting.h>

#define START_Y 80
#define TEXT_FIELD_WIDTH 200
#define TEXT_FIELD_HEIGHT 40
#define FIELD_H_SEP   10

@interface JoinConfTestCaseViewController ()
@property (nonatomic, strong) UITextField *confIdField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *joinClmConfBtn;
@end

@implementation JoinConfTestCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.confIdField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.joinClmConfBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITextField *)confIdField {
    if (nil == _confIdField) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _confIdField = [[UITextField alloc] initWithFrame:CGRectMake((width - TEXT_FIELD_WIDTH) / 2,
                                                                            START_Y,
                                                                            TEXT_FIELD_WIDTH,
                                                                            TEXT_FIELD_HEIGHT)];
        _confIdField.borderStyle = UITextBorderStyleLine;
        _confIdField.placeholder = @"会议ID";
    }
    return _confIdField;
}

- (UITextField *)passwordField {
    if (nil == _passwordField) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _passwordField = [[UITextField alloc] initWithFrame:CGRectMake((width - TEXT_FIELD_WIDTH) / 2,
                                                                         START_Y + FIELD_H_SEP + TEXT_FIELD_HEIGHT,
                                                                         TEXT_FIELD_WIDTH,
                                                                         TEXT_FIELD_HEIGHT)];
        _passwordField.borderStyle = UITextBorderStyleLine;
        _passwordField.placeholder = @"会议密码(可选)";
    }
    return _passwordField;
}

- (UIButton *)joinClmConfBtn {
    if (nil == _joinClmConfBtn) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _joinClmConfBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _joinClmConfBtn.backgroundColor = [UIColor redColor];
        [_joinClmConfBtn setTitle:@"clm_joinConfById" forState:UIControlStateNormal];
        _joinClmConfBtn.frame = CGRectMake((width - TEXT_FIELD_WIDTH) / 2,
                                     START_Y + 2 * FIELD_H_SEP + 2 * TEXT_FIELD_HEIGHT,
                                     TEXT_FIELD_WIDTH,
                                     TEXT_FIELD_HEIGHT);
        [_joinClmConfBtn addTarget:self action:@selector(joinClmConf:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _joinClmConfBtn;
}

- (void)joinClmConf:(id)sender {
    [self.view endEditing:YES];
    CloudLinkMeeting *clm = [CloudLinkMeeting sharedInstance];
    clmJoinMeetingParam *param = [[clmJoinMeetingParam alloc] init];
    param.meetingID = self.confIdField.text;
    param.password = self.passwordField.text;
    [clm clm_joinMeetingById:param completionBlock:^(NSError *error) {
        NSLog(@"clm join meeting, result is:%@", error);
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *message = (nil == error ? @"success" : [NSString stringWithFormat:@"failed:%@", error]);
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"clm_joinConf result" message:message preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self.navigationController presentViewController:alert animated:YES completion:nil];
            });
        }
    }];
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
