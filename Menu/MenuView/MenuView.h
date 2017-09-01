//
//  MenuView.h
//  Menu
//
//  Created by msy on 2017/8/31.
//  Copyright © 2017年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewDelegate <NSObject>

@required
// 指明父控制器
- (UIViewController *)superViewController;

// 导航栏index 对应的子控制器
- (UIViewController *)subViewControllerWithIndex:(NSInteger)index;
@optional

// 点击导航栏的回调
- (void)headTitleSelectWithIndex:(NSInteger)index;

@end


@interface MenuView : UIView

@property (nonatomic, weak) id<MenuViewDelegate> delegate;

// 设置导航条选中文字颜色
@property (nonatomic, copy) UIColor *headViewTextLabelColor;

// 设置导航条下滑线颜色
@property (nonatomic, copy) UIColor *headViewLinelColor;

- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate andTitlArr:(NSArray *)titleArr;
@end
