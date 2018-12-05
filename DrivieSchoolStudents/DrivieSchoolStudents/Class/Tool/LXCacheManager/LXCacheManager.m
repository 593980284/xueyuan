//
//  LXCacheManager.m
//  LXCoach
//
//  Created by GDD on 2018/9/11.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCacheManager.h"
#import <YYCache/YYCache.h>

static NSString *const LXCacheManagerFile = @"LXStudentManagerFile";

@interface LXCacheManager ()

@property (nonatomic,strong)YYCache *yyCache;

@end

@implementation LXCacheManager

+ (instancetype)shareCache  {
    static LXCacheManager *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[LXCacheManager alloc]init];
        NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [cacheFolder stringByAppendingPathComponent:LXCacheManagerFile];
        cache.yyCache = [[YYCache alloc]initWithPath:path];
    });
    return cache;
}

/**
 根据key存储object
 
 @param object 存储内容
 @param key 存储key
 */
+ (void)storeObject:(id<NSCoding>)object forKey:(NSString *)key {
    YYCache *cacheManager = [[self shareCache] yyCache];
    [cacheManager setObject:object forKey:key];
}

/**
 根据key来读取内容
 
 @param key 要读取内容的key
 @return 内容
 */
+ (id)objectForKey:(NSString *)key {
    
    YYCache *cacheManager = [[self shareCache] yyCache];
    return [cacheManager objectForKey:key];
}

/**
 根据key来移除内容
 
 @param key 需移除内容的key
 */
+ (void)removeStoreObjectForKey:(NSString *)key {
    YYCache *cacheManager = [[self shareCache] yyCache];
    [cacheManager removeObjectForKey:key];
}


/**
 清除缓存
 
 @return 返回清除后的缓存
 */
+ (void)cleanCacheSize;
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
    //清除后读取缓存大小
//    return [self readCacheSize];
}


#pragma mark - 读取缓存大小
//获取缓存文件的大小
+(NSString  *)readCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    CGFloat cacheSize = [ self folderSizeAtPath :cachePath];
    return [NSString stringWithFormat:@"%.2fM",cacheSize];
}

// 遍历文件夹获得文件夹大小，返回多少 M
+ ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize/( 1024.0 * 1024.0);
}

// 计算 单个文件的大小
+ ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}

@end
