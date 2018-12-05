//
//  EDSFourPracticeView.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/17.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSFourPracticeView.h"
#import "EDSFourDataBase.h"

@implementation EDSFourPracticeViewModel


@end

@interface EDSFourPracticeView ()

@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property (weak, nonatomic) IBOutlet UILabel *correctLbl;
@property (weak, nonatomic) IBOutlet UILabel *errorLbl;
@property (weak, nonatomic) IBOutlet UILabel *progressLbl;

@end

@implementation EDSFourPracticeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSFourPracticeView" owner:self options:nil] lastObject];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}


- (void)setFooterModel:(EDSFourPracticeViewModel *)footerModel
{
    _footerModel = footerModel;
    self.progressLbl.attributedText = footerModel.progressAttr;
    self.errorLbl.text = footerModel.errorStr;
    self.correctLbl.text = footerModel.correctStr;
    self.collectionBtn.selected = footerModel.isCollection;
    
    @weakify(self);
    [self.collectionBtn bk_whenTapped:^{
        @strongify(self);
        
        if (self.practiceFooterViewDidSelectStringback) {
            
            self.practiceFooterViewDidSelectStringback(@"收藏");
        }
    }];
}


- (IBAction)closeClick:(id)sender {
    
    if (self.practiceFooterViewDidSelectStringback) {
        
        self.practiceFooterViewDidSelectStringback(@"清除");
    }
}

@end
