//
//  ViewController.m
//  UI-复习
//
//  Created by liuxingchen on 16/9/1.
//  Copyright © 2016年 liuxingchen. All rights reserved.
//

#import "ViewController.h"
#import "ShopModel.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *shopView;
@property (weak, nonatomic) IBOutlet UILabel *hud;
/** 添加按钮 */
@property(nonatomic,strong)UIButton * addBtn ;

/** 删除按钮 */
@property(nonatomic,strong)UIButton * removeBtn ;
/** 数据源 */
@property(nonatomic,strong)NSArray * shopsArray ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addBtn = [self btnFram:CGRectMake(50, 40, 50, 50) normal:@"add" highlighted:@"add_highlighted" disabled:@"add_disabled" tag:10 action:@selector(add)];
    self.removeBtn = [self btnFram:CGRectMake(250, 40, 50, 50) normal:@"remove" highlighted:@"remove_highlighted" disabled:@"remove_disabled" tag:20 action:@selector(remove)];
    self.removeBtn.enabled  = NO;
}
-(NSArray *)shopsArray
{
    if (_shopsArray ==nil) {
        //拿到所有的数据源
        NSArray *shopArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"shops" ofType:@"plist"]];
        
        NSMutableArray *shopMarray = [NSMutableArray array];
        //遍历数据源
        for (NSDictionary *dict in shopArray) {
            //字典转模型
            ShopModel *shop = [[ShopModel alloc]initWithDict:dict];
            //把所有的模型加到可变的数组中
            [shopMarray addObject:shop];
        }
            //把可变数组赋值给数据源对象
        _shopsArray = shopMarray;
    }
    return _shopsArray;
}

-(UIButton *)btnFram:(CGRect)frame
              normal:(NSString *)normal
         highlighted:(NSString *)highlighted
            disabled:(NSString *)disabled
                 tag:(NSInteger)tag
              action:(SEL)action
{
    UIButton *btn =[[UIButton alloc]initWithFrame:frame];
    [btn setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:disabled] forState:UIControlStateDisabled];
    btn.tag = tag;
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}
-(void)add
{
    CGFloat shopW = 70;
    CGFloat shopH = 90;
    
    int cols = 3;
    
    CGFloat colsMargin  = (self.shopView.frame.size.width - shopW *cols)/(cols-1);
    NSUInteger index = self.shopView.subviews.count;
    
    int col = index % cols;
    
    CGFloat shopX = col *(colsMargin + shopW);
    
    
    CGFloat rowMargin = 10;
    NSUInteger row = index /cols;
    CGFloat shopY = row *(rowMargin +shopH);
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(shopX, shopY, shopW, shopH)];
    view.backgroundColor = [UIColor redColor];
    [self.shopView addSubview:view];
    
    ShopModel *sModel = self.shopsArray[index];

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, shopW, shopW)];
    imageView.image = [UIImage imageNamed:sModel.icon];
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, shopW, shopW, shopH-shopW)];
    label.text = sModel.name;
    label.backgroundColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:11];
    [view addSubview:label];
    [self buttonState];
}
-(void)remove
{
    [self.shopView.subviews.lastObject removeFromSuperview];
    [self buttonState];
    
}
-(void)buttonState
{
    self.addBtn.enabled = (self.shopView.subviews.count < self.shopsArray.count);
    self.removeBtn.enabled = (self.shopView.subviews.count > 0);
    
    NSString *text =  nil;
    if (self.addBtn.enabled ==NO) {
        text = @"加满了别买了";
    }else if (self.removeBtn.enabled ==NO){
        text = @"删光了买买买";
    }
    if (text ==nil)return;
    self.hud.alpha = 1.0;
    self.hud.text = text;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hud.alpha = 0.0;
    });
}
@end
