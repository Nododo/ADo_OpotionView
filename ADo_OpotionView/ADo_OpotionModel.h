//
//  OpotionModel.h
//  OpotionView
//
//  Created by 杜维欣 on 15/10/20.
//  Copyright (c) 2015年 杜维欣. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    OpotionType_default,
    OpotionType_Input,
} OpotionType;

@interface ADo_OpotionModel : NSObject
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *summary;
@property (nonatomic,copy)NSString *detail;
@property (nonatomic,assign)OpotionType type;
@property (nonatomic,copy)void(^action)();
- (instancetype)initWithIcon:(NSString *)icon summary:(NSString *)summary detail:(NSString *)detail opotionType:(OpotionType)type;
@end
