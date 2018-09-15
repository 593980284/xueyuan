//
//  EDSSubjectTwoView.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/15.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSubjectTwoView.h"
@interface EDSSubjectTwoView ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation EDSSubjectTwoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSSubjectTwoView" owner:self options:nil] lastObject];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://111.39.245.156:8087/lexiang/dist/index.html#/theoryStudy2"]]];
}
@end
