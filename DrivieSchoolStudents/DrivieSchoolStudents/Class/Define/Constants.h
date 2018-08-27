//
//  Constants.h
//  JianShiJia
//
//  Created by 卓森 on 2018/2/26.
//  Copyright © 2018年 卓森. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

//偏好设置
#define UserDefault                             [NSUserDefaults standardUserDefaults]

/*----------------颜色------------------------------------------------*/
#define RGBCOLOR(r, g, b)                       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)                   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//分割线颜色
#define SeparatorCOLOR                          [EDSToolClass getColorWithHexString:@"#dddddd"]

#define TableColor                              [EDSToolClass getColorWithHexString:@"#f9f9f9"]
//主题色
#define ThemeColor                              [EDSToolClass getColorWithHexString:@"#309cf5"]
#define ClearColor                              [UIColor clearColor]
#define WhiteColor                              [UIColor whiteColor]


#define FirstColor                              [EDSToolClass getColorWithHexString:@"333333"]   //一级标题颜色
#define SecondColor                             [EDSToolClass getColorWithHexString:@"666666"]  //二级标题颜色
#define ThirdColor                              [EDSToolClass getColorWithHexString:@"999999"]   //三级标题颜色


/*----------------占位图------------------------------------------------*/
#define AvatarPlaceholderImage                  [UIImage imageNamed:@"avar"]//头像占位图
#define PLACEHOLDERGOODSIMAGE                   [UIImage imageNamed:@"placeholderimg"]


#define NumPerPage @"10" //分页数据，每页的数量

#define APPDELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])



#endif /* Constants_h */
