//
//  EDSZXPracticeCell.h
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/29.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDSZXPracticeCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dataDic;
// 0 1 2 3 从左到右依次 item点击回调
@property (nonatomic,copy) void (^btnClickBlock)(NSInteger clickType);
+(instancetype)getCellWithId:(NSString *)cellID andTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
