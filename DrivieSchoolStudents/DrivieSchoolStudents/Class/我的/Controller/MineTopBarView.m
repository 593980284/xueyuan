//
//  MineTopBarView.m
//  DrivieSchoolStudents
//
//  Created by kkmm on 2018/12/16.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "MineTopBarView.h"

@implementation MineTopBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init{
	self = [[[NSBundle mainBundle] loadNibNamed:@"MineTopBarView" owner:self options:nil] firstObject];
	self.frame = CGRectMake(0,0, kScreenWidth, 258);
	if (self) {
	}
	return self;
}
@end
