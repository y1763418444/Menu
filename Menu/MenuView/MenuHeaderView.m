//
//  MenuHeaderView.m
//  Menu
//
//  Created by msy on 2017/8/31.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "MenuHeaderView.h"
#import "UIView+Extension.h"

@interface MenuHeaderView(){
    BOOL isAverage; // 是否均分
    UIButton *lastButton; // 上一个选中的button
}

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIView *selectLine;
@end

@implementation MenuHeaderView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
    }
    return self;
}

#pragma mark - 刷新UI
- (void)reloadUI{
    [self createUI];
}

#pragma mark - 创建界面
- (void)createUI{
    
    if (!self.titleArray.count){
        return;
    }
    
    [self.scrollView removeFromSuperview];
    
    // 滚动View
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    // 标题颜色
    if (!self.textColor){
        self.textColor = [UIColor blackColor];
    }
    
    // 选中标题颜色
    if (!self.selectTextColor) {
        self.selectTextColor = [UIColor blueColor];
    }
    
    // 设置scrollview的偏移量
    CGFloat maxWidth = 0;
    
    // 是否均分屏幕
    isAverage = YES;
    for (int i=0;i<self.titleArray.count;i++){
        CGFloat w = [self returnStringWidth:self.titleArray[i]];
        maxWidth = maxWidth + w + 40;
        if (maxWidth >= [[UIScreen mainScreen] bounds].size.width){
            isAverage = NO;
            break;
        }
    }

    // 设置button
    CGFloat width = 0;
    CGFloat titleWidth = 0;
    for (int i=0;i<self.titleArray.count;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (isAverage){
            titleWidth = [[UIScreen mainScreen] bounds].size.width/self.titleArray.count;
        }else{
            titleWidth = [self returnStringWidth:self.titleArray[i]] + 40;
        }
        button.frame = CGRectMake(width, 0, titleWidth, self.height);
        button.tag = 1000+i;
        // 标题
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitle:self.titleArray[i] forState:UIControlStateHighlighted];
        // 标题颜色
        [button setTitleColor:self.textColor forState:UIControlStateNormal];
        [button setTitleColor:self.textColor forState:UIControlStateHighlighted];
        if (i == 0){
            [button setTitleColor:self.selectTextColor forState:UIControlStateNormal];
            [button setTitleColor:self.selectTextColor forState:UIControlStateHighlighted];
            lastButton = button;
        }
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:button];
        width = width + titleWidth;
    }
    self.scrollView.contentSize = CGSizeMake(width, self.height);
    
    if (isAverage){
        titleWidth = [[UIScreen mainScreen] bounds].size.width/self.titleArray.count;
    }else{
        titleWidth = [self returnStringWidth:self.titleArray.firstObject] + 40;
    }
    // 选择线
    self.selectLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-2, titleWidth, 2)];
    // 线的颜色
    if (!self.linelColor){
        self.linelColor = [UIColor blueColor];
    }
    self.selectLine.backgroundColor = self.linelColor;
    [self.scrollView addSubview:self.selectLine];
    
    // 底部线
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, self.width, 0.5)];
//    line.backgroundColor = [UIColor grayColor];
//    [self addSubview:line];
}

#pragma mark - 标题按钮点击事件
- (void)buttonClick:(UIButton *)button{
    NSLog(@"%@",NSStringFromCGPoint(button.center));
    if (lastButton == button){
        return;
    }
    
    // 恢复上一个选择按钮的颜色
    [lastButton setTitleColor:self.textColor forState:UIControlStateNormal];
    [lastButton setTitleColor:self.textColor forState:UIControlStateHighlighted];
    
    // 设置当前选择的颜色
    [button setTitleColor:self.selectTextColor forState:UIControlStateNormal];
    [button setTitleColor:self.selectTextColor forState:UIControlStateHighlighted];
    
    lastButton = button;
    
    // 移动下面的滚动条
    NSInteger index = button.tag-1000;
    
    [self setMenuEffect:index];
    [self.delegate seletMenuIndex:index];
    [self setMenuScorll:button];
}

#pragma mark - 设置滚动或选择后的菜单栏效果
- (void)setMenuEffect:(NSInteger)index{
    CGFloat titleWidth = 0;
    CGFloat totalWidth = 0;
    if (isAverage){
        titleWidth = [[UIScreen mainScreen] bounds].size.width/self.titleArray.count * index;
    }else{
        titleWidth = [self returnStringWidth:self.titleArray[index]]+40;
        for (int i=0; i<index; i++) {
            totalWidth = totalWidth + [self returnStringWidth:self.titleArray[i]] + 40;
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.selectLine.frame = CGRectMake(totalWidth, self.height-2, titleWidth, 2);
    }];
}

#pragma mark - 滚动页面后设置滚动的标题
- (void)setSelectItemWithIndex:(NSInteger)index {
    // 恢复上一个选择按钮的颜色
    [lastButton setTitleColor:self.textColor forState:UIControlStateNormal];
    [lastButton setTitleColor:self.textColor forState:UIControlStateHighlighted];
    
    UIButton *button = (UIButton *)[self.scrollView viewWithTag:index+1000];
    // 设置当前选择的颜色
    [button setTitleColor:self.selectTextColor forState:UIControlStateNormal];
    [button setTitleColor:self.selectTextColor forState:UIControlStateHighlighted];
    
    lastButton = button;
    [self setMenuEffect:index];
    [self setMenuScorll:button];
}

#pragma mark - 设置菜单滚动
- (void)setMenuScorll:(UIButton *)button{
    if (!isAverage) {
        if (button.x >= self.width / 2 && button.centerX <= self.scrollView.contentSize.width - self.width/2) {
            [UIView animateWithDuration:0.3 animations:^{
                self.scrollView.contentOffset = CGPointMake(button.centerX - self.width / 2, 0);
            }];
        }else if (button.frame.origin.x < self.width / 2){
            [UIView animateWithDuration:0.3 animations:^{
                self.scrollView.contentOffset = CGPointMake(0, 0);
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width - self.width, 0);
            }];
        }
    }
}

// 返回字符串宽度
- (CGFloat)returnStringWidth:(NSString *)string{
    return [string boundingRectWithSize:CGSizeMake(MAXFLOAT, self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.width;
}

@end
