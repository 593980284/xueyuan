//
//  EDSStudentMsgModel.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/13.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentMsgModel.h"
#define fontSize 14

@implementation EDSStudentMsgModel

-(CGFloat)cellHeight{
    CGFloat cotentHeight =  [self getSizeWithStr:self.content].size.height;
//    NSLog(@"内容---%@",self.content);
//    NSLog(@"cell高度 ---- %lf",cotentHeight);
    
    return [self getSizeWithStr:self.content].size.height>=29?130:100 ;
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
