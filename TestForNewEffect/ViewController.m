//
//  ViewController.m
//  TestForNewEffect
//
//  Created by dvt04 on 17/5/3.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // test
    NSArray *arrAll = @[@"1", @"2", @"3", @"4"];
    NSArray *subArray = [arrAll subarrayWithRange:NSMakeRange(2, 2)];
    NSLog(@"%@", subArray);

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    view.backgroundColor = [UIColor redColor];
    [self.navigationController.navigationBar addSubview:view];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200-44, self.view.frame.size.width, self.view.frame.size.height - 200 - 20) style:UITableViewStylePlain];
    tableView.delegate =self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    

    
    NSArray *arr = @[@"1", @"2", @"3"];
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"test"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    NSMutableArray *arrTmp = [NSMutableArray array];
    
    [arrTmp addObject:@2];
    [arrTmp addObject:@1];
    [arrTmp addObject:@5];
    [arrTmp addObject:@3];
    [arrTmp addObject:@4];
    
    //此方法是直接对arr排序，若要生成新数组排序则调用sortedArrayUsingComparator:
    //若明确知道数组中元素的类型，也可以直接将id改为某确定类型
    [arrTmp sortUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2)
    {
        //此处的规则含义为：若前一元素比后一元素小，则返回降序（即后一元素在前，为从大到小排列）
        if ([obj1 integerValue] < [obj2 integerValue])
        {
            return NSOrderedAscending;
        }
        else
        {
            return NSOrderedDescending;
        }
    }];
    
    NSLog(@"------------- %@", arrTmp);


    NSInteger number = 4;
    NSInteger count = 2;
    
    CGFloat offset = count%number;
    NSLog(@"%f", offset);
    
    // 测试，请求参数为数组
    NSArray *dataArr = @[@{@"count":@"1"}, @{@"count":@"2"}, @{@"count":@"3"}];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in dataArr) {
        [array addObject:dict];
    }
    //转换成data
    NSMutableDictionary *dictRequest = [NSMutableDictionary dictionaryWithCapacity:0];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    [dictRequest setObject:[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding] forKey:@"list"];

    NSLog(@"%@", dictRequest);

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.textLabel.textColor = [UIColor blueColor];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
