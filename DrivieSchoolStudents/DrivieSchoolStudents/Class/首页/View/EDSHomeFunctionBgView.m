//
//  EDSHomeFunctionBgView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSHomeFunctionBgView.h"
#import "EDSHomeFunctionBtn.h"

@interface EDSHomeFunctionBgView ()
@property (weak, nonatomic) IBOutlet EDSHomeFunctionBtn *bmyyView;

@end

@implementation EDSHomeFunctionBgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSHomeFunctionBgView" owner:self options:nil] lastObject];
        
    }
    return self;
}

- (void)setArr:(NSArray *)arr
{
    _arr =arr;
    
    _bmyyView.btnArr = @[@""];
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

@end
