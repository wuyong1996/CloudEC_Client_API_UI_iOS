//
//  CreateConfTestCaseViewController.m
//  CloudLinkMeetingDemo
//
//  Created by zhangjianfang on 2019/3/13.
//  Copyright © 2019年 huawei. All rights reserved.
//

#import "CreateConfTestCaseViewController.h"
#import <CloudLink_Meeting/CloudLinkMeeting.h>

#define START_Y 80
#define LBL_WIDTH  120
#define LBL_HEIGHT 40
#define TEXT_FIELD_WIDTH 200
#define TEXT_FIELD_HEIGHT 40
#define FIELD_H_SEP   10

@interface CreateConfTestCaseViewController ()
@property (nonatomic, strong) UITextField *subjectTextField;
@property (nonatomic, strong) UISwitch *mediaTypeSwitch;
@property (nonatomic, strong) UISwitch *needPassWordSwitch;
@property (nonatomic, strong) UIButton *createConfBtn;
@property (nonatomic, strong) UILabel *mediaTypeLbl;
@property (nonatomic, strong) UILabel *needPasswordLbl;
@end

@implementation CreateConfTestCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.subjectTextField];
    [self.view addSubview:self.mediaTypeLbl];
    [self.view addSubview:self.needPasswordLbl];
    [self.view addSubview:self.mediaTypeSwitch];
    [self.view addSubview:self.needPassWordSwitch];
    [self.view addSubview:self.createConfBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITextField *)subjectTextField {
    if (nil == _subjectTextField) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _subjectTextField = [[UITextField alloc] initWithFrame:CGRectMake((width - TEXT_FIELD_WIDTH) / 2,
                                                                            START_Y,
                                                                            TEXT_FIELD_WIDTH,
                                                                            TEXT_FIELD_HEIGHT)];
        _subjectTextField.borderStyle = UITextBorderStyleLine;
        _subjectTextField.placeholder = @"会议主题";
    }
    return _subjectTextField;
}

- (UILabel *)mediaTypeLbl {
    if (nil == _mediaTypeLbl) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _mediaTypeLbl = [[UILabel alloc] initWithFrame:CGRectMake((width - TEXT_FIELD_WIDTH - LBL_WIDTH) / 2,
                                                                    START_Y + FIELD_H_SEP + TEXT_FIELD_HEIGHT,
                                                                    TEXT_FIELD_WIDTH,
                                                                    TEXT_FIELD_HEIGHT)];
        _mediaTypeLbl.text = @"视频";
    }
    return _mediaTypeLbl;
}

- (UISwitch *)mediaTypeSwitch {
    if (nil == _mediaTypeSwitch) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _mediaTypeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake((width - TEXT_FIELD_WIDTH) / 2,
                                                                      START_Y + FIELD_H_SEP + TEXT_FIELD_HEIGHT,
                                                                      TEXT_FIELD_WIDTH,
                                                                      TEXT_FIELD_HEIGHT)];
        //[_mediaTypeSwitch addTarget:self action:@selector(mediaTypeChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _mediaTypeSwitch;
}

- (UILabel *)needPasswordLbl {
    if (nil == _needPasswordLbl) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _needPasswordLbl = [[UILabel alloc] initWithFrame:CGRectMake((width - TEXT_FIELD_WIDTH - LBL_WIDTH) / 2,
                                                                    START_Y + 2*FIELD_H_SEP + 2*TEXT_FIELD_HEIGHT,
                                                                    TEXT_FIELD_WIDTH,
                                                                    TEXT_FIELD_HEIGHT)];
        _needPasswordLbl.text = @"密码";
    }
    return _needPasswordLbl;
}

- (UISwitch *)needPassWordSwitch {
    if (nil == _needPassWordSwitch) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _needPassWordSwitch = [[UISwitch alloc] initWithFrame:CGRectMake((width - TEXT_FIELD_WIDTH) / 2,
                                                                      START_Y + 2*FIELD_H_SEP + 2*TEXT_FIELD_HEIGHT,
                                                                      TEXT_FIELD_WIDTH,
                                                                      TEXT_FIELD_HEIGHT)];
        //[_needPassWordSwitch addTarget:self action:@selector(needpasswordChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _needPassWordSwitch;
}

- (UIButton *)createConfBtn {
    if(nil == _createConfBtn) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _createConfBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _createConfBtn.backgroundColor = [UIColor redColor];
        [_createConfBtn setTitle:@"clm_createConf" forState:UIControlStateNormal];
        _createConfBtn.frame = CGRectMake((width - TEXT_FIELD_WIDTH) / 2,
                                     START_Y + 4 * FIELD_H_SEP + 4 * TEXT_FIELD_HEIGHT,
                                     TEXT_FIELD_WIDTH,
                                     TEXT_FIELD_HEIGHT);
        [_createConfBtn addTarget:self action:@selector(createClmConf:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _createConfBtn;
}

- (void)createClmConf:(id)sender {
    [self.view endEditing:YES];
    clmCreateMeetingParam *param = [[clmCreateMeetingParam alloc] init];
    param.meetingSubject = self.subjectTextField.text;
    param.meetingType = (self.mediaTypeSwitch.isOn ? CONF_MEDIA_FLAG_VIDEO_DATA : CONF_MEDIA_FLAG_VOICE_DATA);
    param.needPassword = self.needPassWordSwitch.isOn;
    [[CloudLinkMeeting sharedInstance] clm_createMeeting:param completionBlock:^(NSError *error) {
        NSLog(@"create clm conf ,error is:%@", error);
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *message = (nil == error ? @"success" : [NSString stringWithFormat:@"failed:%@", error]);
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"clm_createConf result" message:message preferredStyle:UIAlertControllerStyleAlert];
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
