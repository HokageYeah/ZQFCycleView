//
//  ViewController.m
//  ZQFCycleViewDemo
//
//  Created by zqf on 15/11/15.
//  Copyright © 2015年 zengqingfu. All rights reserved.
//

#import "ViewController.h"
#import "ZQFCycleView.h"

@interface ViewController ()<ZQFCycleViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataArr;
@property (strong, nonatomic) ZQFCycleView *cycleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataArr = [NSMutableArray arrayWithCapacity:7];
    for (NSInteger i = 0; i < 8; i++) {//创建数据源
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", i]];
        [self.dataArr addObject:img];
    }
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.cycleView = [[ZQFCycleView alloc] initWithFrame:CGRectMake(0, 20, width, 180) delegate:self];
    _cycleView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_cycleView];
    
    //如果不在viewWillDisappear 和 viewWillAppear控制播放的话，应该使用下面一行手动播放
    //[_cycleView startPlayWithTimeInterval:5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.cycleView startPlayWithTimeInterval:5];//轮播图开始播放
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.cycleView stopPlay];//控制器消失的时候记得停止轮播图的定时器，否则可能出现内存泄露
}


//返回图片的个数

- (NSInteger)countOfCycleView:(ZQFCycleView *)cycleView{
    return self.dataArr.count;
}


- (void)cycleView:(ZQFCycleView *)cycleView didTouchImageView:(UIImageView *)imageView  titleLabel:(UILabel *)titleLabel index:(NSInteger)index
{
    NSLog(@"点击了%ld",index);
}


//设置imageview
- (void)cycleView:(ZQFCycleView *)cycleView willDisplayImageView:(UIImageView *)imageView index:(NSInteger)index{
    //如果需要网络加载，这里可以使用第三方，比如SDImage等等
    imageView.image = self.dataArr[index];
}

//滑动停止的时候显示标签
- (void)cycleView:(ZQFCycleView *)cycleView didDisplayTitleLabel:(UILabel *)titleLabel index:(NSInteger)index{
    titleLabel.text = [NSString stringWithFormat:@"当前的索引是：%ld", index];
}

@end
