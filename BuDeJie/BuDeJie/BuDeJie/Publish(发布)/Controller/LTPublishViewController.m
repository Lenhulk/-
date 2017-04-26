//
//  LTPublishViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/15.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTPublishViewController.h"
#import "XQCenterTitleBtn.h"

@interface LTPublishViewController ()
@property (nonatomic, weak) UIButton *closeBtn;
@property (nonatomic, weak) UIImageView *headerSloganImgV;
@end

@implementation LTPublishViewController

#pragma mark - ViewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建需要的毛玻璃特效类型
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //创建毛玻璃视图
    UIVisualEffectView *visualV = [[UIVisualEffectView alloc] init];
    visualV.frame = self.view.bounds;
    //可以通过透明度来达到模糊程序的改变.
//    visualV.effect = nil;
    [UIView animateWithDuration:0.01 animations:^{
        visualV.effect = blur;
    }];
    [self.view addSubview:visualV];
    
    //创建slogan图片
    UIImageView *headerImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    headerImgView.center = CGPointMake(KScreenW * 0.5, 120);
    headerImgView.transform = CGAffineTransformMakeTranslation(0, -202);  //移动到顶部屏幕外
    self.headerSloganImgV = headerImgView;
    [self.view addSubview:headerImgView];
    
    XQCenterTitleBtn *btn1 = [XQCenterTitleBtn centerTitleBtnWithImageName:@"publish-video" titleName: @"视频"];
    XQCenterTitleBtn *btn3 = [XQCenterTitleBtn centerTitleBtnWithImageName:@"publish-picture" titleName: @"照片"];
    XQCenterTitleBtn *btn4 = [XQCenterTitleBtn centerTitleBtnWithImageName:@"publish-text" titleName: @"文字"];
    XQCenterTitleBtn *btn6 = [XQCenterTitleBtn centerTitleBtnWithImageName:@"publish-audio" titleName: @"声音"];
    XQCenterTitleBtn *btn7 = [XQCenterTitleBtn centerTitleBtnWithImageName:@"publish-review" titleName: @"已收藏"];
    XQCenterTitleBtn *btn9 = [XQCenterTitleBtn centerTitleBtnWithImageName:@"publish-offline" titleName: @"已下载"];
    
    NSArray *btnArray = @[btn1,btn3,btn4,btn6,btn7,btn9];
    int coloumn = 3;
    CGFloat btnWH = 120;
    CGFloat margin = (self.view.lh_width - coloumn * btnWH) / (coloumn + 1);
    CGFloat x = 0;
    CGFloat y = 0;
    int curL = 0;
    int curR = 0;
    CGFloat oriY = 200;
    
    for (int i = 0; i < btnArray.count; i++) {
        UIButton *btn = btnArray[i];
        btn.tag = i;
        
        curL = i % coloumn;
        curR = i / coloumn;;
        x = margin + (margin + btnWH) * curL;
        y = oriY + (margin + btnWH) * curR;
        btn.frame = CGRectMake(x, y, btnWH, btnWH);
        [self.view addSubview:btn];
        
        btn.transform = CGAffineTransformMakeTranslation(0, KScreenH);   //添加按钮时,把所有的按钮移至底部界面外

        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //询问条
    UIView *bottomV = [[UIView alloc] init];
    bottomV.backgroundColor = [UIColor clearColor];
    CGFloat btnH = 49;
    bottomV.frame = CGRectMake(0, KScreenH - btnH, KScreenW, btnH);
    [self.view addSubview:bottomV];
    
    //关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.userInteractionEnabled = NO;
    [closeBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:UIControlStateNormal];
    CGFloat closeBtnW = 25;
    closeBtn.frame = CGRectMake((bottomV.lh_width - closeBtnW) * 0.5, (bottomV.lh_height - closeBtnW) * 0.5, closeBtnW, closeBtnW);
    [bottomV addSubview:closeBtn];
    self.closeBtn = closeBtn;
    self.closeBtn.transform = CGAffineTransformMakeRotation(-M_PI_4);
    
}

#pragma - mark View 即将显示做动画

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //在即将显示的时候,添加按钮动画
    for (int i = 0; i < self.view.subviews.count; i++) {
        
        UIView *view = self.view.subviews[i];
        
        if ([view isKindOfClass:[XQCenterTitleBtn class]]) {
            //把所有按钮从底部移上来,利用清空形变复原按钮原本的位置
            //给每一个按钮添加渐变的延时时间.
            //UIView动画中usingSpringWithDamping可添加弹簧效果
            [UIView animateWithDuration:0.5 delay: i * 0.05 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                //清空形变
                view.transform = CGAffineTransformIdentity;
            } completion:nil];
        }
        
        if ([view isKindOfClass:[UIImageView class]]) {
            //Slogan清空形变
            [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.headerSloganImgV.transform = CGAffineTransformIdentity;
            } completion:nil];
        }
    }
    
    //TabBar按钮旋转
    [UIView animateWithDuration:0.25 animations:^{
        self.closeBtn.transform = CGAffineTransformIdentity;
    }];
}


#pragma -mark 点击按钮

- (void)btnClick:(UIButton *)btn {
    //根据按钮的Tag可以得知当前点击的是第几个按钮
    //按钮动画
    for (int i = 0; i < self.view.subviews.count; i++) {
        UIView *view = self.view.subviews[i];
        NSLog(@"%d",i);
        if ([view isKindOfClass:[XQCenterTitleBtn class]]) {
            //判断如果是当前点击的按钮, 让按钮这么大
            if (btn == view) {
                
                [UIView animateWithDuration:0.5 animations:^{
                    //放大按钮
                    btn.layer.transform = CATransform3DMakeScale(3.0, 3.0, 1);
                    //让大同时,变为透明
                    btn.alpha = 0;
                }completion:^(BOOL finished) {
                    //关闭
                    [UIView animateWithDuration:0.25 animations:^{
                        self.view.alpha = 0;
                    }completion:^(BOOL finished) {
                        self.closeTask();
                    }];
                }];
            }else {
                //不是当前点击的按钮,让其全部缩小
                [UIView animateWithDuration:0.5 animations:^{
                    view.transform = CGAffineTransformMakeScale(0.001, 0.001);
                    view.alpha = 0;
                }];
            }
        }
    }
}


#pragma -mark 点击关闭

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self close];
}

- (void)close {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.closeBtn.transform = CGAffineTransformMakeRotation(-M_PI_4);
    }];
    
    NSArray *subView = self.view.subviews;
    NSArray *array = [[subView reverseObjectEnumerator] allObjects];   //反转数组
  
    //在即将关闭的时候,添加动画
    for (int i = 0; i < array.count; i++) {
        UIView *view = array[i];
        
        if ([view isKindOfClass:[XQCenterTitleBtn class]]) {
            //把所有按钮逆序移到底部
            //每一个动画添加一个延时时间.
            [UIView animateWithDuration:0.5 delay: i * 0.05 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                
                view.transform = CGAffineTransformMakeTranslation(0, KScreenH);
                
            } completion:nil];
        }
        
        if ([view isKindOfClass:[UIImageView class]]) {
            //把Slogan图片移到顶部
             [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                 
                 view.transform = CGAffineTransformMakeTranslation(0, -202);
                 
             } completion:nil];
        }
    }
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.view.alpha = 0;
            
        }completion:^(BOOL finished) {
            
            self.closeTask();
            
        }];
    });
}

- (void)dealloc{
    LTLog(@"销毁发布界面");
}


@end
