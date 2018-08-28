//
//  EDSHomeRollPictureRequest.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSHomeRollPictureRequest.h"

@implementation EDSHomeRollPictureRequest

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (NSString *)requestURLPath
{
    return @"/app/lexiang/homePage/homeRollPicture";
}

- (NSDictionary *)requestArguments
{
    return @{};
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    NSArray *arr = [data valueForKey:@"list"];
    NSMutableArray *mulArr = [[NSMutableArray alloc] init];
    for (NSString *string in arr) {
        
        [mulArr addObject:[LINEURL stringByAppendingPathComponent:string]];
    }
    
    if (self.successBlock) {
        
        self.successBlock(resCode, data, mulArr);
    }
}
@end
