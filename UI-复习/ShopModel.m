//
//  ShopModel.m
//  UI-复习
//
//  Created by liuxingchen on 16/9/1.
//  Copyright © 2016年 liuxingchen. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _name  = dict[@"name"];
        _icon  = dict[@"icon"];
    }
    return self;
}
+(instancetype)shopWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
