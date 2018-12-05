//
//  EDSFirstSubjectExamFooterView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSFirstSubjectExamFooterView.h"


@implementation EDSFirstSubjectExamFooterModel

@end

@interface EDSFirstSubjectExamFooterView ()

@property (weak, nonatomic) IBOutlet UILabel *correctLbl;
@property (weak, nonatomic) IBOutlet UILabel *errorsLbl;
@property (weak, nonatomic) IBOutlet UILabel *prograssLbl;

@end

@implementation EDSFirstSubjectExamFooterView

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSFirstSubjectExamFooterView" owner:self options:nil] lastObject];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
//        [self setup];
    }
    return self;
}


- (void)setup{
    [[NSBundle mainBundle] loadNibNamed:@"EDSFirstSubjectExamFooterView" owner:self options:nil];
    [self addSubview:self.view];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}


- (void)setFooterModel:(EDSFirstSubjectExamFooterModel *)footerModel
{
    _footerModel = footerModel;
    
    self.prograssLbl.attributedText = footerModel.attar;
    self.correctLbl.text = footerModel.correctstr;
    self.errorsLbl.text = footerModel.errorsstr;
}

@end
