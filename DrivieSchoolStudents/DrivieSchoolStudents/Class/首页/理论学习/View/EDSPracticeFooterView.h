//
//  EDSPracticeFooterView.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSPractioceFooterModel : NSObject


@property (nonatomic, copy) NSAttributedString *progressAttr;//进度
@property (nonatomic, copy) NSString *errorStr;//错题
@property (nonatomic, copy) NSString *correctStr;//正确
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) BOOL  isCollection;//是否收藏

@end

@interface EDSPracticeFooterView : UIView

@property (nonatomic, copy) void (^practiceFooterViewDidSelectStringback)(NSString *titleStr);

@property (nonatomic, strong) EDSPractioceFooterModel  *footerModel;
@end
