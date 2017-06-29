//
//  ViewController.m
//  TestForNewEffect
//
//  Created by dvt04 on 17/5/3.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *testView;

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
//    [self.navigationController.navigationBar addSubview:view];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200-44, self.view.frame.size.width, self.view.frame.size.height - 200 - 20) style:UITableViewStylePlain];
    tableView.delegate =self;
    tableView.dataSource = self;
//    [self.view addSubview:tableView];
    
    NSArray *arr = @[@"1", @"2", @"3"];
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"test"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 测试排序
    /*
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
    */
     
    // 测试，请求参数为数组
    /*
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
    */
     
    // 测试数组置换位置
    /*
    NSArray *arrSort = @[@"1", @"2", @"5", @"4"];
    NSMutableArray *arrSortTmp = [NSMutableArray arrayWithArray:arrSort];
    for (NSString *str in arrSort) {
        if ([str isEqualToString:@"5"]) {
            [arrSortTmp exchangeObjectAtIndex:0 withObjectAtIndex:[arrSort indexOfObject:str]];
            break;
        }
    }
    NSLog(@"%@", arrSortTmp);
    */
     
    // 测试用NSString属性设置为copy和strong两种情况
    NSMutableString *strMutable = [NSMutableString stringWithFormat:@"mutableString"];
    self.strName = strMutable;
    [strMutable appendString:@"--appendString"];
    NSLog(@"%@", strMutable);
    NSLog(@"%@", self.strName);
    
    
    // 获取时间
    NSString* string = @"Thu Aug 04 02:47:40 CST 2016";
    string = [string stringByReplacingOccurrencesOfString:@"CST" withString:@"UTC"];
    NSDateFormatter* dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss zzz yyyy"];
    
    NSDate *currentDateStr = [dateFormatter dateFromString:string];
    NSLog(@"%@", currentDateStr);
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    NSString *strDate = [dateFormatter stringFromDate:currentDateStr];
    NSLog(@"%@", strDate);
    
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"start");
        sleep(5);
        dispatch_semaphore_signal(signal);
    });
    
    NSLog(@"wait");
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    NSLog(@"finish");
    
    
    _testView = [[UIView alloc] initWithFrame:CGRectMake(-200, 200, 200, 200)];
    _testView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_testView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(onHitBtnScroll:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    NSArray *array = @[@"name", @"w", @"aa", @"ZXPing"];
    NSLog(@"%@", [array valueForKeyPath:@"uppercaseString"]);
}

- (void)onHitBtnScroll:(id)sender
{
    if (_testView.transform.tx >= 200) {
        [UIView animateWithDuration:2.0 animations:^{
            _testView.transform = CGAffineTransformMakeTranslation(-200, 0);
        }];
    } else {
        [UIView animateWithDuration:2.0 animations:^{
            _testView.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width+200, 0);
        }];
    }
}

- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
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
