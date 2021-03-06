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
    if (self.is) {
         return @"/app/lexiang/homePage/brandSchoolRollPicture";
    }
    return @"/app/lexiang/homePage/homeRollPicture";
}

- (NSDictionary *)requestArguments
{
    if ([EDSToolClass isBlankString:[EDSSave account].phone]) {
        
        return @{};
    }else{
        
        return @{@"phone":[EDSSave account].phone};
    }
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    NSArray *arr = [data valueForKey:@"list"];
    NSMutableArray *mulArr = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < arr.count ; i++ ) {

        if (_is) {
            
            NSDictionary *dict = @{
                                   @"homeRollPicture":[LINEURL stringByAppendingPathComponent:arr[i][@"brandSchoolRollPicture"]],
                                   //                               @"interactiveContent":arr[i][@"interactiveContent"],
                                   //                               @"isInteractive":arr[i][@"isInteractive"],
                                   };
            [mulArr addObject:dict];
            
        }else{
            NSString * interactiveContent = arr[i][@"interactiveContent"] ? arr[i][@"interactiveContent"] : @"";
            NSDictionary *dict = @{
                                   @"homeRollPicture":[LINEURL stringByAppendingPathComponent:arr[i][@"homeRollPicture"]],
                                                                  @"interactiveContent":interactiveContent,
                                                                  @"isInteractive":arr[i][@"isInteractive"],
                                   };
            [mulArr addObject:dict];
        }
    }
    
    if (self.successBlock) {
        
        self.successBlock(resCode, data, mulArr);
    }
}
@end
