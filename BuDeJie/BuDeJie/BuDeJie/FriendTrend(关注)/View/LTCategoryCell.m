//
//  LTCategoryCell.m
//  BuDeJie
//
//  Created by Lenhulk on 2016/11/3.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTCategoryCell.h"
#import "LTCategoryItem.h"

@interface LTCategoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *indecatorView;

@end

@implementation LTCategoryCell

- (void)setCategoryItem:(LTCategoryItem *)categoryItem{
    _categoryItem = categoryItem;
    _nameLabel.text = categoryItem.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // 取消选中样式
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

//这个方法在cell被选中以及取消选中的时候调用
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.indecatorView.hidden = !selected;
    self.nameLabel.textColor = selected?[UIColor redColor]:[UIColor blackColor];
}

@end
