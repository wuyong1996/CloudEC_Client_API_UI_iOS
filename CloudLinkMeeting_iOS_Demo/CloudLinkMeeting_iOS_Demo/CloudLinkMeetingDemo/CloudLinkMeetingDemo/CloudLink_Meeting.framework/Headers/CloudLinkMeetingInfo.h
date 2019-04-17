//
//  CloudLinkMeetingInfo.h
//  CloudLink Meeting
//
//  Created by zhangjianfang on 2019/2/25.
//

#import <Foundation/Foundation.h>

extern NSString* const clmErrorDomain;
extern NSString* const clmUninitErrorDescription;
extern NSString* const clmActionInProcessDescription;

//clm接口结果枚举
typedef NS_ENUM(NSInteger, CLM_RESULT) {
    CLM_RESULT_IN_PROCESS = -2,   //当前请求在进行中
    CLM_RESULT_FAILED = -1,
    CLM_RESULT_SUCCESS = 0,
    
};


//会议类型枚举
typedef NS_ENUM(NSInteger, CONF_MEDIATYPE) {
    CONF_MEDIA_FLAG_VOICE_DATA = 17,   //语音加数据
    CONF_MEDIA_FLAG_VIDEO_DATA = 19,    //视频加数据
};

@interface clmLoginParam : NSObject
@property (nonatomic, copy) NSString *serverAddress;   //登录地址
@property (nonatomic, assign) NSInteger serverPort;    //登录端口
@property (nonatomic, copy) NSString *account;         //登录账号
@property (nonatomic, copy) NSString *password;        //登录密码
@end

@interface clmCreateMeetingParam : NSObject
@property (nonatomic, copy) NSString *meetingSubject;       //会议主题
@property (nonatomic, assign) CONF_MEDIATYPE meetingType;   //会议类型
@property (nonatomic, assign) BOOL needPassword;            //会议是否需要密码
@end

@interface clmJoinMeetingParam : NSObject
@property (nonatomic, copy) NSString *meetingID;  //会议ID
@property (nonatomic, copy) NSString *password;   //会议密码
@end

//@interface clmJoinLocalMeetingParam : NSObject
//@property (nonatomic, copy) NSString *meetingID;  //会议ID
//@end

