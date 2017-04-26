//
//  LTLoginViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/21.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTLoginViewController.h"
#import "LTLoginRegisterView.h"

@interface LTLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewLeading;

@end

@implementation LTLoginViewController

#pragma mark - TopView
- (IBAction)registerClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    //移动中间的view
    _middleViewLeading.constant =  _middleViewLeading.constant==0?-KScreenW:0;
    //刷新页面
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)dismissClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    LTLoginRegisterView *loginV = [LTLoginRegisterView loginView];
    [_middleView addSubview:loginV];
    
    LTLoginRegisterView *registerV = [LTLoginRegisterView registerView];
    registerV.lh_x = KScreenW;
    [_middleView addSubview:registerV];
}

//最好在viewDidLayoutSubviews中 确认子控件的尺寸和位置
- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    _middleView.subviews[0].frame = CGRectMake(0, 0, _middleView.lh_width * 0.5, _middleView.lh_height);
    _middleView.subviews[1].frame = CGRectMake(_middleView.lh_width * 0.5, 0, _middleView.lh_width * 0.5, _middleView.lh_height);
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
