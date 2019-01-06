//
//  EDSTBDetailListCell.h
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2019/1/2.
//  Copyright © 2019 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDSTBDetailListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *firstImagV;
@property (weak, nonatomic) IBOutlet UILabel *firstTilteLabel;
@property (weak, nonatomic) IBOutlet UIImageView *secImagV;
@property (weak, nonatomic) IBOutlet UILabel *secTitleLabel;

+(instancetype)getCellWithId:(NSString *)cellID andTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
