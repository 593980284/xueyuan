//
//  EDSPracticeFooterView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSPracticeFooterView.h"
#import "EDSDataBase.h"


@implementation EDSPractioceFooterModel

@end

@interface EDSPracticeFooterView ()
@property (weak, nonatomic) IBOutlet UILabel *correctLbl;
@property (weak, nonatomic) IBOutlet UILabel *errorLbl;
@property (weak, nonatomic) IBOutlet UILabel *progressLbl;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;

@end

@implementation EDSPracticeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSPracticeFooterView" owner:self options:nil] lastObject];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}


- (void)setFooterModel:(EDSPractioceFooterModel *)footerModel
{
    _footerModel = footerModel;
//    NSAttributedString *attStr = [NSString attributedStringWithColorTitle:[NSString stringWithFormat:@"/%@",[[EDSDataBase sharedDataBase] getOneFirstSubjectCount]] normalTitle:@"" frontTitle:[EDSSave account].firstSubjectID diffentColor:ThirdColor];
    
    self.progressLbl.attributedText = footerModel.progressAttr;
    
//    NSInteger allcount = [[EDSSave account].firstSubjectID intValue];
//    NSInteger errCount = [[[EDSDataBase sharedDataBase] getOneFirstSubjectErrorCount] intValue];
//    self.errorLbl.text = [NSString stringWithFormat:@"%ld",(long)errCount];
//    self.correctLbl.text = [NSString stringWithFormat:@"%ld",(allcount - errCount - 1)];
//    self.collectionBtn.selected = isCollection;
    
    self.errorLbl.text = footerModel.errorStr;
    self.correctLbl.text = footerModel.correctStr;
    self.collectionBtn.selected = footerModel.isCollection;
    
    @weakify(self);
    [self.collectionBtn bk_whenTapped:^{
        
        @strongify(self);
        if (self.collectionBtn.selected) {
            
            [[EDSDataBase sharedDataBase] upDataFirstSubjectunCollectionWithID:footerModel.ID];
            self.collectionBtn.selected = NO;
            [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
            [SVProgressHUD dismissWithDelay:1.5];
        }else{
            [[EDSDataBase sharedDataBase] upDataFirstSubjectCollectionWithID:footerModel.ID];
            self.collectionBtn.selected = YES;
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
            [SVProgressHUD dismissWithDelay:1.5];
        }
    }];
}

- (void)setIsCollection:(BOOL *)isCollection
{
    
}

//下一题
- (IBAction)nextClick:(id)sender {
    if (self.practiceFooterViewDidSelectStringback) {
        
        self.practiceFooterViewDidSelectStringback(@"下一题");
    }
}

//收藏
- (IBAction)collectionClick:(id)sender {
    if (self.practiceFooterViewDidSelectStringback) {
        
        self.practiceFooterViewDidSelectStringback(@"收藏");
    }
}

//清除
- (IBAction)closeClick:(id)sender {
    
    if (self.practiceFooterViewDidSelectStringback) {
        
        self.practiceFooterViewDidSelectStringback(@"清除");
    }
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

@end
