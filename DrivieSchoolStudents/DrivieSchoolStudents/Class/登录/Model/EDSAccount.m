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
        _state = [NSString stringWithFormat:@"%@",dict[@"state"]];
        _touristState = [NSString stringWithFormat:@"%@",dict[@"touristState"]];
        _userID = @"1";
    }
    return self;
}

- (NSString *)showPicUrl
{
    return [LINEURL stringByAppendingPathComponent:_picUrl];
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
