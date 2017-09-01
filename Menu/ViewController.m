//
//  ViewController.m
//  Menu
//
//  Created by msy on 2017/8/31.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "ViewController.h"
#import "MenuView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()<MenuViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *naVlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    naVlabel.text = @"假装这是Nav";
    naVlabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:naVlabel];
    
    NSArray *array = [NSArray arrayWithObjects:@"我",@"喔喔",@"我的",@"哈哈哈啊哈哈",@"打啊",@"2",@"a",@"2", nil];
    MenuView *view = [[MenuView alloc] initWithFrame:CGRectMake(0,64, ScreenWidth,ScreenHeight-64-49) andDelegate:self andTitlArr:array];
    view.delegate = self;
    
    // 菜单选中颜色 (默认蓝色)
    // view.headViewTextLabelColor = [UIColor redColor];
    
    // 滚动条颜色 (默认蓝色)
    // view.headViewLinelColor = [UIColor redColor];
    
    [self.view addSubview:view];
    
    UILabel *tablabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenHeight -49, ScreenWidth, 49)];
    tablabel.text = @"假装这是Tab";
    tablabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tablabel];
}

- (UIViewController *)superViewController {
    return self;
}
- (UIViewController *)subViewControllerWithIndex:(NSInteger)index {
    
    // 注: 以下控制器都需要重新设置frame属性 详情见FirstViewController
    if (index%2 == 0){
        FirstViewController *vc = [FirstViewController new];
        return vc;
    }else{        
        SecondViewController *vc = [SecondViewController new];
        return vc;
    }
}

// 根据需要可以不实现
- (void)headTitleSelectWithIndex:(NSInteger)index{
    NSLog(@"选择了第%ld个菜单",index);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
