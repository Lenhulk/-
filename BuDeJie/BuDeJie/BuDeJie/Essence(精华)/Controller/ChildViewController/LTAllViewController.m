//
//  LTAllViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/23.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTAllViewController.h"
#import "LTTopicCell.h"
#import "LTTopicItem.h"
#import <MJExtension/MJExtension.h>
#import "LTTopicViewModel.h"

static NSString *const ID = @"cell";

@interface LTAllViewController ()
@property (nonatomic, strong) NSMutableArray *topicsVM;
@end

@implementation LTAllViewController

- (NSMutableArray *)topicsVM{
    if (_topicsVM == nil) {
        _topicsVM = [NSMutableArray array];
    }
    return _topicsVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 只要通过registerClass，TableViewCell就是通过initWithStyle
    [self.tableView registerClass:[LTTopicCell class] forCellReuseIdentifier:ID];
    
    //网络数据
    [self loadData];
}

- (void)loadData{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager lh_manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(LTTopicItemTypeVoice);
    
    [manager GET:KBaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        
        //字典数组 转 模型数组
        NSArray *topics = [LTTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //模型 转 视图模型
        for (LTTopicItem *item in topics) {
            LTTopicViewModel *topicVm = [[LTTopicViewModel alloc] init];
            topicVm.item = item;            //赋值，在set方法计算cell高度
            [self.topicsVM addObject:topicVm];  //保存记录VM
        }
        
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LTLog(@"ERROR-%@", error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicsVM.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LTTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];

//    cell.item = [self.topics[indexPath.row] item];
    cell.vm = self.topicsVM[indexPath.row] ;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_topicsVM[indexPath.row] cellH];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
