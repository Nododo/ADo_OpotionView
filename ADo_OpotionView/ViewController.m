//
//  ViewController.m
//  OpotionView
//
//  Created by 杜维欣 on 15/10/16.
//  Copyright (c) 2015年 杜维欣. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Tool.h"
#import "ADo_OpotionView.h"
#import "ADo_OpotionModel.h"

/** 获取屏幕 宽度、高度 */
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
/** 判断6p */
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
/** 获取随机色 */
#define kRandomColor ([UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0f])

#define spaceH 20
/** cell重用 */
static NSString *reuseID = @"opotion";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)NSMutableArray *opotionArray;
@property (nonatomic,strong)NSIndexPath *selectedPath;
@property (nonatomic,weak)UITableView *listView;
@property (nonatomic,assign)CGFloat keboardH;
@property (nonatomic,assign )CGFloat offsetY;

@end

@implementation ViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellTextChange:) name:@"textChange" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**键盘弹出*/
- (void)keyboardWillShow:(NSNotification *)note
{
    CGRect tempFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 键盘高度
    CGFloat keyboardHeight = tempFrame.size.height;
    
    //    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //
    //    int curve = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    self.keboardH = keyboardHeight;
    
}

/**键盘收起*/
- (void)keyboardWillHide:(NSNotification *)note
{
    //    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (!self.listView.tracking) {
        
        [self.listView setContentOffset:CGPointMake(0, self.offsetY)];
    }
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self creatList];
    
    [self initializeData];
}

- (void)creatList
{
    UITableView *listView = [[UITableView alloc] init];
    listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    listView.tableFooterView = [[UIView alloc] init];
    [listView registerClass:[ADo_OpotionView class] forCellReuseIdentifier:reuseID];
    listView.delegate = self;
    listView.dataSource = self;
    listView.X = 0;
    listView.Y = 0;
    listView.width = SCREEN_WIDTH;
    listView.height = SCREEN_HEIGHT - 40;
    [self.view addSubview:listView];
    self.listView = listView;
}


- (NSMutableArray *)opotionArray
{
    if (!_opotionArray) {
        self.opotionArray = [NSMutableArray array];
    }
    return _opotionArray;
}

- (void)initializeData
{
    ADo_OpotionModel *model1 =[[ADo_OpotionModel alloc] initWithIcon:@"1" summary:@"aaa" detail:@"AAA" opotionType:OpotionType_default];
    ADo_OpotionModel *model2 =[[ADo_OpotionModel alloc] initWithIcon:@"2" summary:@"bbb" detail:@"BBB" opotionType:OpotionType_Input];
    ADo_OpotionModel *model3 =[[ADo_OpotionModel alloc] initWithIcon:@"3" summary:@"ccc" detail:@"CCC" opotionType:OpotionType_default];
    ADo_OpotionModel *model4 =[[ADo_OpotionModel alloc] initWithIcon:@"4" summary:@"ddd" detail:@"" opotionType:OpotionType_Input];
    ADo_OpotionModel *model5 =[[ADo_OpotionModel alloc] initWithIcon:@"1" summary:@"eee" detail:@"EEE" opotionType:OpotionType_default];
    ADo_OpotionModel *model6 =[[ADo_OpotionModel alloc] initWithIcon:@"2" summary:@"fff" detail:@"FFF" opotionType:OpotionType_Input];
    ADo_OpotionModel *model7 =[[ADo_OpotionModel alloc] initWithIcon:@"3" summary:@"ggg" detail:@"GGG" opotionType:OpotionType_default];
    ADo_OpotionModel *model8 =[[ADo_OpotionModel alloc] initWithIcon:@"4" summary:@"hhh" detail:@"" opotionType:OpotionType_Input];
    [self.opotionArray addObject:model1];
    [self.opotionArray addObject:model2];
    [self.opotionArray addObject:model3];
    [self.opotionArray addObject:model4];
    [self.opotionArray addObject:model5];
    [self.opotionArray addObject:model6];
    [self.opotionArray addObject:model7];
    [self.opotionArray addObject:model8];
}

#pragma mark - table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.opotionArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ADo_OpotionView *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    cell.model = self.opotionArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ADo_OpotionModel *model = self.opotionArray[indexPath.row];
    if (model.action) {
        model.action();
        return;
    }
    ADo_OpotionView *cell = (ADo_OpotionView *)[tableView cellForRowAtIndexPath:indexPath];
    cell.cellIndexPath = indexPath;
    if (model.type == OpotionType_Input) {
        [cell canInput];
        CGFloat offsetY = self.listView.contentOffset.y;
        self.offsetY = offsetY;
        CGFloat trueCellMaxY = CGRectGetMaxY(cell.frame) - offsetY;
        CGFloat keyboardMinY = SCREEN_HEIGHT - self.keboardH;
        if (trueCellMaxY > keyboardMinY) {
            CGFloat deltaY = trueCellMaxY - keyboardMinY;
            [self.listView setContentOffset:CGPointMake(0, offsetY + deltaY + spaceH)];
        }
        
    }else
    {
        [self.view endEditing:YES];
    }
}

#pragma mark - 通知
- (void)cellTextChange:(NSNotification *)note
{
    NSIndexPath *changedPath = note.userInfo[@"indexPath"];
    NSInteger row = changedPath.row;
    ADo_OpotionModel *changeModel = self.opotionArray[row];
    changeModel.detail = note.userInfo[@"text"];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
