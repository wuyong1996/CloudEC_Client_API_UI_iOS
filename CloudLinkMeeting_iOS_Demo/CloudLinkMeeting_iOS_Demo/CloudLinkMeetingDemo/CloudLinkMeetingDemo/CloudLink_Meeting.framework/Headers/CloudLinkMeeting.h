//
//  CloudLink_Meeting.h
//  CloudLink Meeting
//
//  Created by zhangjianfang on 2019/2/21.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CloudLinkMeetingInfo.h"

//! Project version number for CloudLink_Meeting.
FOUNDATION_EXPORT double CloudLink_MeetingVersionNumber;

//! Project version string for CloudLink_Meeting.
FOUNDATION_EXPORT const unsigned char CloudLink_MeetingVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <CloudLink_Meeting/PublicHeader.h>

typedef void(^clmActionCompletionBlock)(NSError *error);

@interface CloudLinkMeeting : NSObject


/**
 单例接口

 @return CloudLinkMeeting单例对象
 */
+ (instancetype)sharedInstance;


/**
 初始化配置接口

 @param completionBlock 完成回调
 */
- (void)clm_initWithCompletionBlock:(clmActionCompletionBlock)completionBlock;


/**
 登录接口

 @param loginParam 登录参数
 @param completionBlock 完成回调(需要先初始化才能调用)
 */
- (void)clm_login:(clmLoginParam *)loginParam
        completionBlock:(clmActionCompletionBlock)completionBlock;


/**
 创建会议接口

 @param createParam 创会参数
 @param completionBlock 完成回调(需要先初始化登录才能调用)
 */
- (void)clm_createMeeting:(clmCreateMeetingParam *)createParam
          completionBlock:(clmActionCompletionBlock)completionBlock;


/**
 使用会议ID入会接口

 @param joinParam 加入会议参数
 @param completionBlock 完成回调(需要先初始化登录才能调用)
 */
- (void)clm_joinMeetingById:(clmJoinMeetingParam *)joinParam
            completionBlock:(clmActionCompletionBlock)completionBlock;

@end

