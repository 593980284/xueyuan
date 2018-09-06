//
//  EDSMyHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSMyHeaderView.h"

@interface EDSMyHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *avarterImgView;


@end

@implementation EDSMyHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.avarterImgView.userInteractionEnabled = YES;
    @weakify(self);
    [self.avarterImgView bk_whenTapped:^{
        @strongify(self);
        
        if (self.headerImgViewDidClick) {
            
            self.headerImgViewDidClick();
        }
    }];
}

- (void)setHeaderArr:(NSArray *)headerArr
{
    _headerArr = headerArr;
    
    NSURL *url = [NSURL URLWithString:[EDSSave account].showPicUrl];

    [self.avarterImgView sd_setImageWithURL:url placeholderImage:PLACEHOLDERGOODSIMAGE];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSMyHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSMyHeaderView" owner:self options:nil] lastObject];
        
    }
    return self;
}

@end
