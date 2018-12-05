//
//  EDSOnlineClassDateListModel.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSOnlineClassDateListModel : NSObject

@property (nonatomic , copy) NSString              * date;
@property (nonatomic , copy) NSString              * has;


@property (nonatomic , copy) NSString              * showWeak;//周几
@property (nonatomic , copy) NSString              * showDay;//日期
@property (nonatomic , assign) BOOL                isSubject;//是否有课

@end
