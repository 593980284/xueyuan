//
//  EDSZXPracticeCell.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/29.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSZXPracticeCell.h"

@interface EDSZXPracticeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *firstImgV;

@property (weak, nonatomic) IBOutlet UIImageView *secImgV;

@property (weak, nonatomic) IBOutlet UIImageView *thirdImgV;
@property (weak, nonatomic) IBOutlet UIImageView *fourImgV;

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourLabel;

@end

@implementation EDSZXPracticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    NSArray * titleArr = dataDic[@"title"];
    _firstLabel.text = titleArr[0];
    _secLabel.text = titleArr[1];
    _thirdLabel.text = titleArr[2];
    _fourLabel.text = titleArr[3];
    
    NSArray * imgArr = dataDic[@"img"];
    _firstImgV.image = [UIImage imageNamed:imgArr[0]];
    _secImgV.image = [UIImage imageNamed:imgArr[1]];
    _thirdImgV.image = [UIImage imageNamed:imgArr[2]];
    _fourImgV.image = [UIImage imageNamed:imgArr[3]];
}

+(instancetype)getCellWithId:(NSString *)cellID andTableView:(UITableView *)tableView{
    EDSZXPracticeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EDSZXPracticeCell" owner:nil options:nil]lastObject];
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//第一个点击事件
- (IBAction)firstBtnClick:(UIButton *)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock(0);
    }
}
- (IBAction)secBtnClick:(UIButton *)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock(1);
    }
}
- (IBAction)thirdBtnClick:(id)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock(2);
    }
}
- (IBAction)fourBtnClick:(UIButton *)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock(3);
    }
}

@end
