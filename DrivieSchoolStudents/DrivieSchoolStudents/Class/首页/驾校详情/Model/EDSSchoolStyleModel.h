//
//  EDSSchoolStyleModel.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSSchoolStyleModel : NSObject

@property (nonatomic, copy) NSString *clickCount;   //点击量
@property (nonatomic, copy) NSString *creatTime;    //创建时间
@property (nonatomic, copy) NSString *likeCount;    //点赞量
@property (nonatomic, copy) NSString *schoolId;     //驾校id
@property (nonatomic, copy) NSString *styleContent; //风采内容
@property (nonatomic, copy) NSString *styleId;      //风采id
@property (nonatomic, copy) NSString *styleName;    //风采名称
@property (nonatomic, copy) NSString *stylePhoto;   //图片
@property (nonatomic, copy) NSString *styleVideo;   //视频
@property (nonatomic, copy) NSString *titleCover;   //标题封面


@property (nonatomic, copy) NSString *showStylePhoto;   //展示图片
@end
