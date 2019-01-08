//
//  EDSTBPracticeModel.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2019/1/2.
//  Copyright © 2019 班文政. All rights reserved.
//

#import "EDSTBPracticeModel.h"

@implementation EDSTBPracticeListModel

+(NSArray *)getListArr{
    
    NSArray * titleArr = @[
                           @"文字题",@"图片题",@"动画题",@"判断题",
                           @"多选题",@"单选题",@"速度题",@"距离题",
                           @"标志题",@"手势题",@"信号题",@"酒驾题",
                           @"标线题",@"灯光题",@"装置题",@"路况题",
                           ];
    
    NSMutableArray * listArr = [NSMutableArray new];
    for (NSInteger index = 0; index < 4; index ++) {
        
        NSMutableArray * cellArr = [NSMutableArray new];
        for (NSInteger j = 0; j < 4; j++) {
            EDSTBPracticeModel * model = [EDSTBPracticeModel new];
            model.titleStr = titleArr[index * j];
            [cellArr addObject:model];
        }
        [listArr addObject:cellArr];
    }
    return listArr;
}

@end

@implementation EDSTBPracticeModel



@end
