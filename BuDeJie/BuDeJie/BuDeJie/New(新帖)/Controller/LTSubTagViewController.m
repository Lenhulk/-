//
//  LTSubTagViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/20.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTSubTagViewController.h"
#import "LTSubTagItem.h"
#import "LTTagCell.h"
#import <MJExtension/MJExtension.h>

@interface LTSubTagViewController ()
@property (nonatomic, strong) NSArray *tags;
@end

static NSString *const ID = @"cell1";

@implementation LTSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载网络数据
    [self loadData];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LTTagCell" bundle:nil] forCellReuseIdentifier:ID];
}

- (void)loadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    parameters[@"action"] = @"sub";
    
    [manager GET:KBaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray * _Nullable responseObject) {
        
//        LTLog(@"%@", responseObject);
//        [responseObject writeToFile:@"/Users/Lenhulk/Desktop/sub.plist" atomically:YES];
        
        //通过查看数据可知responseObject原来是数组类型，直接在上面参数中修改为NSArray
        _tags = [LTSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LTLog(@"%@", error);
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LTTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.subTagItem = _tags[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
