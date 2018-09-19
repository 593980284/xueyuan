//
//  EDSFourSubjectExamBase.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/19.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSFourSubjectExamBase : NSObject

+ (instancetype)sharedDataBase;


- (NSArray *)getFourSubjectExam;

/*
 科目四出题规则：
 对错题（1--10题） 23     SELECT *FROM classifyfourbean WHERE tagid = 23 ORDER BY random() LIMIT 10
 单选题(11--40题） 25    SELECT *FROM classifyfourbean WHERE tagid != 23 AND tagid != 24 ORDER BY random() LIMIT 30
 多选题（41--50题） 24    SELECT *FROM classifyfourbean WHERE tagid = 24 ORDER BY random() LIMIT 10
 题库中随机抽选，共计50题，90分及格。
 */
@end
