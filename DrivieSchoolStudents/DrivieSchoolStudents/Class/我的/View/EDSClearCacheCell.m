//
//  EDSClearCacheCell.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/20.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSClearCacheCell.h"

@implementation EDSClearCacheCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置加载视图
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
        
        //设置文字
        self.textLabel.text = @"清楚缓存";
        self.detailTextLabel.text = @"正在计算";
    }
    return self;
}

@end
