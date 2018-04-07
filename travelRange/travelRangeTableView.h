//
//  travelRangeTable.h
//  travelRange
//
//  Created by 何泽的mac on 2018/4/7.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dayTravelRangeModel.h"
@interface travelRangeTableView : UIView

///假数据
@property(nonatomic,strong)dayTravelRangeModel * model;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *dayLabelArray;

@end
