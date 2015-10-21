//
//  OpotionView.m
//  OpotionView
//
//  Created by 杜维欣 on 15/10/16.
//  Copyright (c) 2015年 杜维欣. All rights reserved.
//

#import "ADo_OpotionView.h"

/** 获取随机色 */
#define kRandomColor ([UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0f])
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#define paddingW 5
#define arrowW 20
#define labelH 30
#define textfieldH 45
@interface ADo_OpotionView ()<UITextFieldDelegate>
@property (nonatomic,weak)UIImageView *iconView;

@property (nonatomic,weak)UILabel *summaryLabel;
@property (nonatomic,assign)BOOL isEditing;

@end

@implementation ADo_OpotionView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeSubviews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)initializeSubviews
{
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.backgroundColor = kRandomColor;
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *summaryLabel = [[UILabel alloc] init];
    summaryLabel.font = [UIFont systemFontOfSize:22];
    summaryLabel.backgroundColor = kRandomColor;
    [self.contentView addSubview:summaryLabel];
    self.summaryLabel = summaryLabel;
    
    UITextField *detailField = [[UITextField alloc] init];
//    detailField.hidden = NO;
    detailField.userInteractionEnabled = NO;
    detailField.delegate = self;
//        detailField.backgroundColor = kRandomColor;
    [self.contentView addSubview:detailField];
    self.detailField = detailField;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(paddingW);
        make.size.equalTo(CGSizeMake(90, 90));
    }];
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.right).offset(paddingW);
        make.top.equalTo(paddingW);
        make.right.equalTo(- arrowW - paddingW - paddingW);
        make.height.equalTo(labelH + textfieldH + paddingW);
    }];
    
    [self.detailField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.right).offset(paddingW);
        make.top.equalTo(paddingW + paddingW + labelH);
        make.right.equalTo(- arrowW - paddingW - paddingW);
        make.height.equalTo(textfieldH);
    }];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.isEditing = YES;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        
        [self layoutIfNeeded];
    }];
}

- (void)updateConstraints
{
    if (self.isEditing) {
        
        [self.summaryLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.right).offset(paddingW);
            make.top.equalTo(paddingW);
            make.right.equalTo(- arrowW - paddingW - paddingW);
            make.height.equalTo(labelH);
            _summaryLabel.font = [UIFont systemFontOfSize:10];
        }];
        
        
    }else
    {
        
        [self.summaryLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.right).offset(paddingW);
            make.top.equalTo(paddingW);
            make.right.equalTo(- arrowW - paddingW - paddingW);
            make.height.equalTo(labelH + textfieldH + paddingW);
            _summaryLabel.font = [UIFont systemFontOfSize:17];
        }];

    }
    [super updateConstraints];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"textChange" object:nil userInfo:@{@"text" : textField.text,@"indexPath" : self.cellIndexPath}];
    self.detailField.userInteractionEnabled = NO;
    [self.detailField resignFirstResponder];
    self.isEditing = NO;
    if (textField.text.length > 0) {
        return;
    }else
    {
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            
            [self layoutIfNeeded];
        }];
    }
}

-(void)setModel:(ADo_OpotionModel *)model
{
    _model = model;
    self.iconView.image = [UIImage imageNamed:model.icon];
    self.summaryLabel.text = _model.summary;
    self.detailField.text =  _model.detail;
    if (_model.detail.length > 0) {
        self.isEditing = YES;
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        
        [self layoutIfNeeded];
    }else
    {
        self.isEditing = NO;
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        
        [self layoutIfNeeded];
    }
}

- (void)canInput{
    self.detailField.userInteractionEnabled = YES;
    [self.detailField becomeFirstResponder];
    [self textFieldDidBeginEditing:_detailField];
}

@end
