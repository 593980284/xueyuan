//
//  ViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "ViewController.h"
#import "CRequest.h"
@interface ViewController ()
@property(nonatomic ,strong)NSArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = WhiteColor;
//    CRequest *request = [CRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
//        
//    } failureBlock:^(NSError *error) {
//        
//    }];
//    [request startRequest];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
