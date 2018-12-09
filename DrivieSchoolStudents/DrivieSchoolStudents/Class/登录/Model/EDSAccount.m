//
//  EDSAccount.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSAccount.h"

@implementation EDSAccount

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
    
        _phone = [NSDictionary changeType:dict[@"phone"]];
        _schoolId = [NSDictionary changeType:dict[@"schoolId"]];
        _userID = [NSDictionary changeType:dict[@"id"]];
        _learnProgress = [NSDictionary changeType:dict[@"learnProgress"]];
        _schoolName = [NSDictionary changeType:dict[@"schoolName"]];
        _photo = [NSString stringWithFormat:@"%@",[LINEURL stringByAppendingPathComponent:dict[@"photo"]]];;
        _state = [NSDictionary changeType:dict[@"state"]];
        _applyDriveCar = [NSDictionary changeType:dict[@"applyDriveCar"]];
        _studentId = [NSDictionary changeType:dict[@"studentId"]];
        _bookingExamUrl = [NSDictionary changeType:dict[@"bookingExamUrl"]];
        _touristState = [NSDictionary changeType:dict[@"touristState"]];
    }
    return self;
}

- (NSString *)learnProgress
{
    if ([_learnProgress isEqual:@"1"]) {
        
        return @"科目一";
    }else if ([_learnProgress isEqual:@"2"]){
        
        return @"科目二";
    }else if ([_learnProgress isEqual:@"3"]){
        
        return @"科目三";
    }else if ([_learnProgress isEqual:@"4"]){
        
        return @"文明驾驶";
    }
    return @"";
}

- (NSString *)touristState
{
    return [NSString stringWithFormat:@"%@",_touristState];
}

- (NSString *)userID
{
    return [NSString stringWithFormat:@"%@",_userID];
}


+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([EDSAccount class], &count);
    for (int index = 0; index < count; index ++) {
        Ivar ivar = ivars[index];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([EDSAccount class], &count);
        for (int index = 0; index < count; index ++) {
            Ivar ivar = ivars[index];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
    }
    return self;
}


@end
