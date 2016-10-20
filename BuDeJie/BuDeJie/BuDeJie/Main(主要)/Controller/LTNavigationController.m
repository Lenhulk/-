//
//  LTNavigationController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/17.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTNavigationController.h"
#import "LTNavigationBar.h"
#import "LTBackView.h"

@interface LTNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LTNavigationController

+ (void)load{
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //导航条字体
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    bar.titleTextAttributes = attr;
    
    //导航条背景
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //清空系统手势代理，不让它把滑动返回失效
//    self.interactivePopGestureRecognizer.delegate = self;
    
    //不要系统手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
    //获取系统的代理（负责滑动返回）
    id target = self.interactivePopGestureRecognizer.delegate;
    
    //自己创建Pan手势（用系统实现好的滑动返回方法--打印的信息中找）
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
    //创建自定义导航条
    LTNavigationBar *bar = [[LTNavigationBar alloc] initWithFrame:self.navigationBar.frame];
    //导航条控件是只读的（没有setter方法），通过KVC设置替换
//    self.navigationBar = bar;
    [self setValue:bar forKey:@"navigationBar"];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    //控制手势在非根控制器的时候触发
    return self.childViewControllers.count > 1;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //只有非根控制器才设置"返回"按钮
    if (self.childViewControllers.count > 0) {
        LTBackView *backView = [LTBackView backViewWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highLightedImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
        
        viewController.hidesBottomBarWhenPushed = YES;  // 隐藏底部条
        
        //打印页面的手势滑动信息
//        LTLog(@"%@", self.interactivePopGestureRecognizer);
    }
    
    //在父类做事(真正的push)之前创建"返回"按钮
    [super pushViewController:viewController animated:animated];
    
}

- (void)back{
    [self popViewControllerAnimated:YES];
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
