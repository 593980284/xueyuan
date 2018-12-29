//
//  EDSSubOneView.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/28.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSSubOneView.h"
@interface EDSSubOneView()
@property (weak, nonatomic) IBOutlet UIView *shunxuBgView;

@property (weak, nonatomic) IBOutlet UIView *sujiBgView;
@property (weak, nonatomic) IBOutlet UIView *zhuanxiangBgView;
@property (weak, nonatomic) IBOutlet UIView *cuotiBgView;
@property (weak, nonatomic) IBOutlet UIView *tubiaoBgView;
@property (weak, nonatomic) IBOutlet UIView *mojiBgView;

@end

@implementation EDSSubOneView
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self setCornraidios:self.shunxuBgView];
    [self setCornraidios:self.sujiBgView];
    [self setCornraidios:self.zhuanxiangBgView];
    [self setCornraidios:self.cuotiBgView];
    [self setCornraidios:self.tubiaoBgView];
    [self setCornraidios:self.mojiBgView];
}
-(void)setCornraidios:(UIView *)bgView{
    bgView.clipsToBounds = YES;
    bgView.layer.cornerRadius = 10;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSSubOneView" owner:self options:nil] lastObject];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}


//顺序学习
- (IBAction)randomLearnClick:(UIButton *)sender {
    if(self.btnClickBlock ){
        self.btnClickBlock(0);
    }
}
//随机学习
- (IBAction)suijiClick:(UIButton *)sender {
    if(self.btnClickBlock ){
        self.btnClickBlock(1);
    }

}
- (IBAction)zhuanxiangClick:(UIButton *)sender {
    if(self.btnClickBlock ){
        self.btnClickBlock(2);
    }

}
- (IBAction)myFaultClick:(UIButton *)sender {
    if(self.btnClickBlock ){
        self.btnClickBlock(3);
    }

}
- (IBAction)tubiaoClick:(UIButton *)sender {
    if(self.btnClickBlock ){
        self.btnClickBlock(4);
    }

}
- (IBAction)shunxuClick:(UIButton *)sender {
    if(self.btnClickBlock ){
        self.btnClickBlock(5);
    }

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
