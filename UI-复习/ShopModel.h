//
//  ShopModel.h
//  UI-复习
//
//  Created by liuxingchen on 16/9/1.
//  Copyright © 2016年 liuxingchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject
/** 商品名 */
@property(nonatomic,copy)NSString * name ;
/** 商品图 */
@property(nonatomic,copy)NSString * icon ;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)shopWithDict:(NSDictionary *)dict;
@end
