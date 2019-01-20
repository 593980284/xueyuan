//
//  EDSSave.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSave.h"
#define kMessagePath(path) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:path]


@implementation EDSSave

+ (void)setObject:(id)value forKey:(NSString *)defaultName{
    //存储数据
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    //立刻同步
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    EDSAccount * a = [self account];
    [a setValue:value forKey:defaultName];
    [self save:a];
    
}

+ (id)objectForKey:(NSString *)defaultName
{
    //利用NSUserDefaults，就能直接访问软件的偏好设置（Lobarary/Preferences）
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}


/**
 *  存储帐号信息
 */
+ (void)save:(EDSAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:kMessagePath(@"account.plist")];
}

/**
 *  获得上次存储的帐号
 *
 */
+ (EDSAccount *)account
{
    EDSAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kMessagePath(@"account.plist")];
    
    return account;
}
@end
