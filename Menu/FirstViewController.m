//
//  FirstViewController.m
//  Menu
//
//  Created by msy on 2017/8/31.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "FirstViewController.h"
#import "UIView+Extension.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = CGRectMake(0, 0, self.view.width, self.view.height-64-40-49);
    self.view.backgroundColor = [UIColor orangeColor];
    // 底部线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height-50, self.view.width,50)];
    line.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:line];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
