//
//  MenuView.m
//  Menu
//
//  Created by msy on 2017/8/31.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "MenuView.h"
#import "MenuHeaderView.h"
#import "UIView+Extension.h"

@interface MenuView()<UIScrollViewDelegate,MenuHeaderViewDelegate>
@property (nonatomic, strong) MenuHeaderView *menuHead;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation MenuView

- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate andTitlArr:(NSArray *)titleArray {
    
    if (self = [super initWithFrame:frame]) {
        _titleArray = titleArray;
        _delegate = delegate;
        [self createUI];
    }
    return self;
}

#pragma mark -  创建界面
- (void)createUI {
    // 菜单视图
    self.menuHead = [[MenuHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
    self.menuHead.titleArray = self.titleArray;
    [self.menuHead reloadUI];
    [self addSubview:self.menuHead];
    
    self.menuHead.delegate = self;
    
    // 下面的滚动视图
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.x, CGRectGetMaxY(self.menuHead.frame), self.width, self.height-self.menuHead.height)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    UIView *lastView = nil;
    for (int i = 0 ; i < [self.titleArray count]; i++) {
        // 添加子视图
        UIViewController *baseVC = [self.delegate subViewControllerWithIndex:i];
        [[self.delegate superViewController] addChildViewController:baseVC];
        baseVC.view.frame = CGRectMake(self.width*i, 0, self.width, self.height-self.menuHead.height);
        [self.scrollView addSubview:baseVC.view];
        lastView = baseVC.view;
        
    }
    self.scrollView.contentSize = CGSizeMake(self.width*self.titleArray.count, self.height-self.menuHead.height);
}

#pragma mark - 视图滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.menuHead setSelectItemWithIndex:scrollView.contentOffset.x / [[UIScreen mainScreen] bounds].size.width];
}

#pragma mark - 菜单选择代理
- (void)selectWithIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake([[UIScreen mainScreen] bounds].size.width * index, 0) animated:NO];
    if (self.delegate && [self.delegate respondsToSelector:@selector(headTitleSelectWithIndex:)]) {
        [self.delegate headTitleSelectWithIndex:index];
    }
}

#pragma mark - 菜单选中标题颜色
- (void)setHeadViewTextLabelColor:(UIColor *)headViewTextLabelColor {
    _headViewTextLabelColor = headViewTextLabelColor;
    self.menuHead.selectTextColor = headViewTextLabelColor;
    [self.menuHead reloadUI];
}

#pragma mark - 滚动条颜色
- (void)setHeadViewLinelColor:(UIColor *)headViewLinelColor {
    _headViewLinelColor = headViewLinelColor;
    self.menuHead.linelColor = headViewLinelColor;
    [self.menuHead reloadUI];
}

#pragma mark - 菜单代理
- (void)seletMenuIndex:(NSInteger)index{
    [self.scrollView setContentOffset:CGPointMake([[UIScreen mainScreen] bounds].size.width*index,0) animated:NO];
    if ([self.delegate respondsToSelector:@selector(headTitleSelectWithIndex:)]){
        [self.delegate headTitleSelectWithIndex:index];
    }
}

@end
