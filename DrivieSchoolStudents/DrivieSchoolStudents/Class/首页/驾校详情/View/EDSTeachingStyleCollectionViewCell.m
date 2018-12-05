//
//  EDSTeachingStyleCollectionViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSTeachingStyleCollectionViewCell.h"

#import "EDSSchoolStyleModel.h"

@interface EDSTeachingStyleCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *stylePhoto;
@property (weak, nonatomic) IBOutlet UILabel *styleNameLbl;

@end

@implementation EDSTeachingStyleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setStyleModel:(EDSSchoolStyleModel *)styleModel
{
    _styleModel = styleModel;
    
    [self.stylePhoto sd_setImageWithURL:[NSURL URLWithString:styleModel.showStylePhoto] placeholderImage:PLACEHOLDERGOODSIMAGE];
    
    self.styleNameLbl.text = styleModel.styleName;
}

@end
