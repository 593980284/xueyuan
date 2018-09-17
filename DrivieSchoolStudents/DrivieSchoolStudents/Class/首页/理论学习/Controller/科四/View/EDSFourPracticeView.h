//
//  EDSFourPracticeView.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/17.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSFourPracticeViewModel : NSObject

@property (nonatomic, copy) NSAttributedString *progressAttr;//进度
@property (nonatomic, copy) NSString *errorStr;//错题
@property (nonatomic, copy) NSString *correctStr;//正确
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) BOOL  isCollection;//是否收藏

@end

@interface EDSFourPracticeView : UIView

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property (nonatomic, strong) EDSFourPracticeViewModel  *footerModel;

@property (nonatomic, copy) void (^practiceFooterViewDidSelectStringback)(NSString *titleStr);

@end
