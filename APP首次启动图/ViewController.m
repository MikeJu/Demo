//
//  ViewController.m
//  APP首次启动图
//
//  Created by Michael_Ju on 15/11/25.
//  Copyright (c) 2015年 Michael_Ju. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:1];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(100, 100, 100, 50);
    [btn setTitle:@"查看简介" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
    //沙盒判断是否存在
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLanch"]) {
        return;
    }
    else{
        [self firstLanch];

    }

}
- (void)check
{
    [self firstLanch];
}
- (void)firstLanch
{
    //不允许自动嵌套
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    NSLog(@"%f",self.view.bounds.size.width);
    sv.contentSize = CGSizeMake(sv.bounds.size.width * 4, 0);
    sv.showsHorizontalScrollIndicator = NO;
    sv.pagingEnabled = YES;
    sv.bounces = NO;
    sv.tag = 100;
    [self.view addSubview:sv];
    
    for (int i = 0; i < 4; i++) {
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(sv.bounds.size.width * i, 0, sv.bounds.size.width, sv.bounds.size.height)];
        iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"first_guide%d.jpg",i+1]];
        [sv addSubview:iv];
        
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"进入>" forState:UIControlStateNormal];
    btn.frame = CGRectMake(sv.bounds.size.width * 4 - 60, sv.bounds.size.height - 50, 60, 40);
    [btn addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
    
    [sv addSubview:btn];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"firstLanch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)enter
{
    UIView *v = [self.view viewWithTag:100];
    [UIView animateWithDuration:2 animations:^{
        // 缩放仿色变换
        v.transform = CGAffineTransformScale(v.transform, 2, 2);

    } completion:^(BOOL finished) {
        // 移除ScrollView
        [v removeFromSuperview];
        
        // 显示导航和TabBar
        self.navigationController.navigationBarHidden = NO;
        self.tabBarController.tabBar.hidden = NO;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
