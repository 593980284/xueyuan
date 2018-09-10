//
//  EDSRecitedPoliticsFooterView.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/10.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSRecitedPoliticsFooterView : UIView

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) BOOL  isCollection;//是否收藏

@end
