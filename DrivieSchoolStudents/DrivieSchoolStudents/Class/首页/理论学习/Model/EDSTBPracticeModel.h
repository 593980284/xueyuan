//
//  EDSTBPracticeModel.h
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2019/1/2.
//  Copyright © 2019 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EDSTBPracticeListModel : NSObject

@property (nonatomic,strong)  NSArray*listArr;



+(NSArray *)getListArr;

@end

@interface EDSTBPracticeModel : NSObject

@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,strong) NSString *ImgUrl;


@end


