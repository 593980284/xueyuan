//
//  EDSFirstSubjectExamFooterView.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSFirstSubjectExamFooterModel : NSObject

@property (nonatomic, copy) NSAttributedString *attar;
@property (nonatomic, copy) NSString *correctstr;
@property (nonatomic, copy) NSString *errorsstr;

@end

@interface EDSFirstSubjectExamFooterView : UIView

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property (nonatomic , strong) IBOutlet UIView *view;
/** 数据 */
@property (nonatomic, strong) EDSFirstSubjectExamFooterModel  *footerModel;
@end
