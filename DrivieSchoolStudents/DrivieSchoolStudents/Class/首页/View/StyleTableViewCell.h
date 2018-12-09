//
//  StyleTableViewCell.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/9.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolStyleVIew.h"


@interface StyleTableViewCell : UITableViewCell
@property(nonatomic, strong)SchoolStyleVIew* leftView;
@property(nonatomic, strong)SchoolStyleVIew* rightView;
@end


