//
//  LXCacheManager.h
//  LXCoach
//
//  Created by GDD on 2018/9/11.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXCacheManager : NSObject
/**
 根据key存储object
 
 @param object 存储内容
 @param key 存储key
 */
+ (void)storeObject:(id<NSCoding>)object forKey:(NSString *)key;

/**
 根据key来读取内容
 
 @param key 要读取内容的key
 @return 内容
 */
+ (id)objectForKey:(NSString *)key;

/**
 根据key来移除内容
 
 @param key 需移除内容的key
 */
+ (void)removeStoreObjectForKey:(NSString *)key;



/**
 读取缓存大小
 
 @return 返回缓存大小 单位：M
 */
+ (NSString  *)readCacheSize;

/**
 清除缓存
 
 @return 返回清除后的缓存
 */
+ (void)cleanCacheSize;
@end
