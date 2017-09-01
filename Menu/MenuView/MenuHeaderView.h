//
//  MenuHeaderView.h
//  Menu
//
//  Created by msy on 2017/8/31.
//  Copyright © 2017年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

#define fontSize 14 // 字体大小

@protocol MenuHeaderViewDelegate <NSObject>
// 选择某个按钮的代理
- (void)seletMenuIndex:(NSInteger)index;
@end

@interface MenuHeaderView : UIView

@property (nonatomic,weak) id <MenuHeaderViewDelegate> delegate;
// 标题数组
@property (nonatomic, strong) NSArray *titleArray;
// 标题颜色 (默认黑色)
@property (nonatomic, strong) UIColor *textColor;
// 选中标题颜色 (默认蓝色)
@property (nonatomic, strong) UIColor *selectTextColor;
// 线颜色 (默认蓝色)
@property (nonatomic, strong) UIColor *linelColor;
// 注: 设置属性后统一调用刷新方法;
// 刷新UI
- (void)reloadUI;
// 设置标题滚动后的状态
- (void)setSelectItemWithIndex:(NSInteger)index;

@end
