//
//  ViewController.m
//  CloudLinkMeetingDemo
//
//  Created by zhangjianfang on 2019/2/22.
//  Copyright © 2019年 huawei. All rights reserved.
//

#import "ViewController.h"
#import <CloudLink_Meeting/CloudLinkMeeting.h>
#import "LoginTestCaseViewController.h"
#import "CreateConfTestCaseViewController.h"
#import "JoinConfTestCaseViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) CloudLinkMeeting *clm;
@property (nonatomic, strong) UITableView *clmTestTableView;
@property (nonatomic, strong) NSArray *testCases;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //prepare datas
    _testCases = @[@"clm_init",
                   @"clm_login",
                   @"clm_createMeeting",
                   @"clm_joinMeetingById"];
    
    _clm = [CloudLinkMeeting sharedInstance];
    //prepare views
    [self.view addSubview: self.clmTestTableView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- inner methods

- (UITableView *)clmTestTableView {
    if (nil == _clmTestTableView) {
        _clmTestTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _clmTestTableView.delegate = self;
        _clmTestTableView.dataSource = self;
    }
    return _clmTestTableView;
}

#pragma mark - clmTestTableView delegate dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.testCases.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
    cell.detailTextLabel.text = [self.testCases objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *methodName = [self.testCases objectAtIndex:indexPath.row];
    
    if ([@"clm_init" isEqualToString:methodName]) {
        [self initTestCase];
    }
    else if ([@"clm_login" isEqualToString:methodName]) {
        [self runAndLoginTestCase];
    }
    else if ([@"clm_createMeeting" isEqualToString:methodName]) {
        [self createMeetingTestCase];
    }
    else if ([@"clm_joinMeetingById" isEqualToString:methodName]) {
        [self joinMeetingByIdTestCase];
    }
}

- (void)initTestCase {
    UIActivityIndicatorView *activeView = [[UIActivityIndicatorView alloc] initWithFrame:self.view.bounds];
    activeView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activeView.color = [UIColor grayColor];
    [self.view addSubview:activeView];
    [activeView startAnimating];
    [_clm clm_initWithCompletionBlock:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [activeView stopAnimating];
            [activeView removeFromSuperview];
            NSLog(@"clm_init result is:%@", error);
            NSString *message = (nil == error ? @"success" : [NSString stringWithFormat:@"failed:%@", error]);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"clm_init result" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self.navigationController presentViewController:alert animated:YES completion:nil];
        });
    }];
}

- (void)runAndLoginTestCase {
    LoginTestCaseViewController *loginTestCtrl = [[LoginTestCaseViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:loginTestCtrl animated:YES];
}

- (void)createMeetingTestCase {
    CreateConfTestCaseViewController *createConfCtrl = [[CreateConfTestCaseViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:createConfCtrl animated:YES];
}

- (void)joinMeetingByIdTestCase {
    JoinConfTestCaseViewController *joinConfTestCaseCtrl = [[JoinConfTestCaseViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:joinConfTestCaseCtrl animated:YES];
}

@end
