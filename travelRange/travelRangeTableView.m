//
//  travelRangeTable.m
//  travelRange
//
//  Created by 何泽的mac on 2018/4/7.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

#import "travelRangeTableView.h"
#import "dayTravelRangeView.h"

#define Spacing 10.f // 间距 也是label高度
#define kselfWidth self.frame.size.width
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation travelRangeTableView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
}
*/
///获取7天时间
-(NSMutableArray *)getBefore_7_date{
    NSMutableArray *sevenArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 7; i ++) {
        //从现在开始的24小时
        NSTimeInterval secondsPerDay = -i * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"M-d"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        //组合时间
        [sevenArr addObject:dateStr];
    }
    
    return sevenArr;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSDictionary * dics = [self requestDataWithName:@"data"];
        for (int i = 0; i < [self getBefore_7_date].count; i++) {
            UILabel * label = (UILabel *)[self viewWithTag:16-i];
            label.text = [self getBefore_7_date][i];
        }
        
        ///每天的每分钟行驶速度
        for (int i = 0; i < 7; i++) {
            dayTravelRangeView * day = [[dayTravelRangeView alloc]initWithFrame:CGRectMake(62, Spacing + Spacing*2 * i, kScreenWidth - 63 - 20, Spacing)];
            dayTravelRangeModel * model = [[dayTravelRangeModel alloc]init];
            model.redArray = dics[@"data"][i][@"red"];
            model.blueArray = dics[@"data"][i][@"blue"];
            model.greenArray = dics[@"data"][i][@"green"];
            day.model = model;
            day.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self addSubview:day];
        }
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
}

- (id)requestDataWithName:(NSString *)jsonName{
    
    //获取路径  拿到的是 传递进来的 json文件的路径
    NSString * path = [[NSBundle mainBundle]pathForResource:jsonName ofType:@"json"];
    
    //存到 data对象中
    NSData * data = [NSData dataWithContentsOfFile:path];
    
    //解析 data
    id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return jsonData;
}


@end
