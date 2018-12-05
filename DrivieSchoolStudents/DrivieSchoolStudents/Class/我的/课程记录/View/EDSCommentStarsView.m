//
//  EDSCommentStarsView.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/15.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCommentStarsView.h"

@interface EDSCommentStarsView ()
/** 控件数组 */
@property (nonatomic, strong) NSMutableArray  *viewMulArr;

@end

@implementation EDSCommentStarsView


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.viewMulArr = [[NSMutableArray alloc] init];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.viewMulArr = [[NSMutableArray alloc] init];
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.viewMulArr = [[NSMutableArray alloc] init];
        [self setup];
    }
    return self;
}

- (void)setup{
    
    CGFloat H = self.frame.size.height;
    CGFloat W = self.frame.size.width/5;
    
    for (int i = 0; i < 5; i ++) {
        UIImageView *starImgView = [UIImageView imageViewWithSuperView:self];
        starImgView.userInteractionEnabled = YES;
        [starImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(H, H));
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(W*i);
        }];
        
        [starImgView bk_whenTapped:^{
            
            self.selectNumber = i + 1;
            if (self.startBackNumber) {
                
                self.startBackNumber(self.selectNumber);
            }
        }];
        if (i < self.selectNumber) {
            
            starImgView.image = [UIImage imageNamed:@"star_content_icon_selected"];
        }else{
            
            starImgView.image = [UIImage imageNamed:@"star_content_icon_default"];
        }
        
        [self.viewMulArr addObject:starImgView];
    }
}


- (void)setSelectNumber:(NSInteger)selectNumber
{
    _selectNumber = selectNumber;
    
    for (int j = 0; j < self.viewMulArr.count; j ++ ) {
        UIImageView *imageView = self.viewMulArr[j];
        if (j < selectNumber) {
            
            imageView.image = [UIImage imageNamed:@"star_content_icon_selected"];
        }else{
            
            imageView.image = [UIImage imageNamed:@"star_content_icon_default"];
        }
    }
}

@end
