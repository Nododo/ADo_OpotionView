//
//  OpotionModel.m
//  OpotionView
//
//  Created by 杜维欣 on 15/10/20.
//  Copyright (c) 2015年 杜维欣. All rights reserved.
//

#import "ADo_OpotionModel.h"

@implementation ADo_OpotionModel
- (instancetype)initWithIcon:(NSString *)icon summary:(NSString *)summary detail:(NSString *)detail opotionType:(OpotionType)type
{
    self = [super init];
    if (self) {
        self.icon = icon;
        self.summary = summary;
        self.detail = detail;
        self.type = type;
    }
    return self;
}
@end
