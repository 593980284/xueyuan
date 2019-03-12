//
//  EDSMsgCell.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/9.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSMsgCell.h"
#define fontSize 14
@interface EDSMsgCell()
@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIImageView *leftImageV;
@property (nonatomic,strong) UILabel *contentText;
@property (nonatomic,strong) UILabel *timeLable;
@property (nonatomic,strong) UIView *pointView;


@end

@implementation EDSMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(EDSStudentMsgModel *)model{
    _model = model;
    
    self.contentText.text = model.content;
    self.timeLable.text = model.date;
    
     NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.contentText.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.contentText.text length])];
    self.contentText.attributedText = attributedString;
//    self.contentText.lineBreakMode = NSLineBreakByCharWrapping;
    CGRect textReact = [self getSizeWithStr:model.content];
    if (textReact.size.height >= 29) {
        self.contentText.wz_height = 65;
    }else{
        self.contentText.wz_height = 30;
    }
    
    if ([model.msgType isEqualToString:@"0"]||[model.msgType isEqualToString:@"1"]) {
        self.leftImageV.image = [UIImage imageNamed:@"system_msg_img"];
    }else{
        self.leftImageV.image = [UIImage imageNamed:@"driver_msg_img"];
    }
    self.pointView.hidden = model.isRead == 1;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = TableColor;
        [self initView];
    }
    return self;
}
-(void)initView{
    [self.bgView addSubview:self.leftImageV];
    [self.bgView addSubview:self.contentText];
    [self.bgView addSubview:self.timeLable];
    [self.contentView addSubview:self.bgView];
}

-(void)layoutSubviews{
    CGRect textReact = [self getSizeWithStr:self.model.content];
    if (textReact.size.height >= 29) {
        self.contentText.wz_height = 65;
    }else{
        self.contentText.wz_height = 30;
    }
    self.timeLable.wz_y = self.contentText.wz_bottom + 10;
    self.bgView.wz_height = self.timeLable.wz_bottom + 10;
}

-(UILabel *)timeLable{
    if (!_timeLable) {
        
        _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(self.leftImageV.wz_right + 10, self.contentText.wz_bottom, kScreenWidth - self.leftImageV.wz_right - 10 - 20, 20)];
        _timeLable.textColor = ThirdColor;
        _timeLable.text = @"2018-89-90  84：222";
        _timeLable.font = [UIFont systemFontOfSize:13];
    }
    return _timeLable;
}
-(UILabel *)contentText{
    if (!_contentText) {
        _contentText = [[UILabel alloc]initWithFrame:CGRectMake(self.leftImageV.wz_right + 10, self.leftImageV.wz_y, kScreenWidth - self.leftImageV.wz_right - 10 - 20, 30)];
        _contentText.numberOfLines = 2;
        _contentText.textColor = FirstColor;
        _contentText.font = [UIFont systemFontOfSize:fontSize];
        _contentText.text = @"测试测试测试测试测试测试测试测试测试测试测试测试";
    }
    return _contentText;
}
-(UIImageView *)leftImageV{
    if (!_leftImageV) {
        _leftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(18, 18, 50, 50)];
        
        _leftImageV.image = [UIImage imageNamed:@"driver_msg_img"];
        self.pointView = [UIView new];
        self.pointView.backgroundColor = [UIColor redColor];
        self.pointView.layer.cornerRadius = 5;
        [_leftImageV addSubview:self.pointView];
        self.pointView.frame = CGRectMake(35, 5, 10, 10);
        
    }
    return _leftImageV;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth - 20, 80)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
-(CGRect )getSizeWithStr:(NSString *)str
{
    UIFont *font = [UIFont boldSystemFontOfSize:fontSize];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"[ _`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]|\n|\r|\t"];
    NSString *trimmedString = [str stringByTrimmingCharactersInSet:set];
//    NSString *newname = [[name componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];

    return [trimmedString boundingRectWithSize:CGSizeMake(kScreenWidth - 50+10+18+10+30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
}



@end
