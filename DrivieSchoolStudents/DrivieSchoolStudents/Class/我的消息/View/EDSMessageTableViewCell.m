//
//  EDSMessageTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/4.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSMessageTableViewCell.h"
#import "EDSStudentMsgModel.h"
@interface EDSMessageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@end

@implementation EDSMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setMesModel:(EDSStudentMsgModel *)mesModel
{
    _mesModel = mesModel;
    
    self.contentLbl.text = mesModel.content;
    self.timeLbl.text = mesModel.date;
}
@end
