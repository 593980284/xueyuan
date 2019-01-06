//
//  EDSTBListCell.h
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/29.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDSTBPracticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDSTBListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstImagV;
@property (weak, nonatomic) IBOutlet UIImageView *secImageV;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageV;
@property (weak, nonatomic) IBOutlet UIImageView *fourImageV;

//@property (nonatomic,strong) EDSTBPracticeModel *model;
@property (nonatomic,strong) NSDictionary *dataDic;


+(instancetype)getCellWithId:(NSString *)cellID andTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
