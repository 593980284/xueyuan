//
//  EDSRecitedPoliticsFooterView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/10.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSRecitedPoliticsFooterView.h"
#import "EDSDataBase.h"
#import "EDSFourDataBase.h"

@interface EDSRecitedPoliticsFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *collectionBrn;

@end

@implementation EDSRecitedPoliticsFooterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSRecitedPoliticsFooterView" owner:self options:nil] lastObject];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}


- (void)setIsCollection:(BOOL)isCollection
{
    _isCollection = isCollection;
    
    NSInteger ID = [self.ID intValue];
    self.collectionBrn.selected = isCollection;
    @weakify(self);
    [self.collectionBrn bk_whenTapped:^{
        
        @strongify(self);
        if (self.collectionBrn.selected) {
            
            if (ID > 1325) {
                
                [[EDSFourDataBase sharedDataBase] upDataFourSubjectunCollectionWithID:self.ID];
                self.collectionBrn.selected = NO;
                [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
                [SVProgressHUD dismissWithDelay:1.5];
            }else{
                
                if ([[EDSDataBase sharedDataBase] upDataFirstSubjectunCollectionWithID:self.ID]) {
                    
                    self.collectionBrn.selected = NO;
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
                    [SVProgressHUD dismissWithDelay:1.5];
                }else{
                    
                    [SVProgressHUD showSuccessWithStatus:@"请重试"];
                    [SVProgressHUD dismissWithDelay:1.5];
                }
            }
            
        }else{
            
            if (ID > 1325) {
                
                [[EDSFourDataBase sharedDataBase] upDataFourSubjectCollectionWithID:self.ID];
                self.collectionBrn.selected = YES;
                [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                [SVProgressHUD dismissWithDelay:1.5];
            }else{
                if ([[EDSDataBase sharedDataBase] upDataFirstSubjectCollectionWithID:self.ID]) {
                    
                    self.collectionBrn.selected = YES;
                    
                    [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                    [SVProgressHUD dismissWithDelay:1.5];
                }else{
                    
                    [SVProgressHUD showSuccessWithStatus:@"请重试"];
                    [SVProgressHUD dismissWithDelay:1.5];
                }
            }
        }
    }];
}


@end
