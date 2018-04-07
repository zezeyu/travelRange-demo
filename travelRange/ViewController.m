//
//  ViewController.m
//  travelRange
//
//  Created by 何泽的mac on 2018/4/4.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

#import "ViewController.h"
#import "dayTravelRangeView.h"
#import "travelRangeTableView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@property(nonatomic,strong)travelRangeTableView * travelTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self _loadTravelTableView];
}

-(void)_loadTravelTableView{
    self.travelTableView = [[[NSBundle mainBundle] loadNibNamed:@"travelRangeTableView" owner:self options:nil] lastObject];
    self.travelTableView.frame = CGRectMake(0, 100, kScreenWidth-20, 15 * 7 * 2 + 60);
    [self.view addSubview:self.travelTableView];
}

-(travelRangeTableView *)travelTableView{
    if (!_travelTableView) {
        _travelTableView = [[travelRangeTableView alloc]init];
    }
    return _travelTableView;
}


#pragma -- mark 重新加载 测试动画有没有问题
- (IBAction)OverLoading:(UIButton *)sender {
    [self.travelTableView removeFromSuperview];
    [self _loadTravelTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
