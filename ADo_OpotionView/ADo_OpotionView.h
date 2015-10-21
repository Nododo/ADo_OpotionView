//
//  OpotionView.h
//  OpotionView
//
//  Created by 杜维欣 on 15/10/16.
//  Copyright (c) 2015年 杜维欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADo_OpotionModel.h"



@interface ADo_OpotionView : UITableViewCell
@property (nonatomic,weak)UITextField *detailField;
@property (nonatomic,strong)ADo_OpotionModel *model;
@property (nonatomic,strong)NSIndexPath *cellIndexPath;
- (void)canInput;

@end
