//
//  EDSStrategyListModel.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSStrategyListModel : NSObject

@property (nonatomic , copy) NSString              * titleCover;//标题封面
@property (nonatomic , copy) NSString              * strategyVideo;//视频
@property (nonatomic , copy) NSString              * strategyType;//类型：0考规，1技巧，2趣事
@property (nonatomic , copy) NSString              * strategyName;//攻略名称
@property (nonatomic , copy) NSString              * creatTime;//创建时间
@property (nonatomic , copy) NSString              * likeCount;//点赞量
@property (nonatomic , copy) NSString              * strategyPhoto;//图片
@property (nonatomic , copy) NSString              * clickCount;//点击量
@property (nonatomic , copy) NSString              * studyStrategyId;//攻略id

@end
