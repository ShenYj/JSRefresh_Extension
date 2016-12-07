//
//  JSDemoTableViewController.m
//  JSRefresh_Extension
//
//  Created by ShenYj on 2016/12/6.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSDemoTableViewController.h"
#import "JSRefreshControl.h"

static NSString * const demoTableViewCellId = @"demoTableViewCellId";

@interface JSDemoTableViewController ()

@property (nonatomic) NSArray *data;
@property (nonatomic) JSRefreshControl *refreshControl;

@end

@implementation JSDemoTableViewController

@synthesize refreshControl = _refreshControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.tableView.backgroundColor = [UIColor colorWithRed:255/255.0 green:116/255.0 blue:103/255.0 alpha:1.0];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:demoTableViewCellId];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(loadData:) forControlEvents:UIControlEventValueChanged];
    
    // 视图控制器一起动,就加载一次数据
    [self loadData:self.refreshControl];
    
}

- (void)loadData:(JSRefreshControl *)refreshControl {
    
    [self.refreshControl beginRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *mArr = [NSMutableArray array];
        NSNumber *lastNumber = self.data.lastObject;
        for (int i = lastNumber.intValue + 1; i <= lastNumber.intValue + 10; i ++) {
            [mArr addObject:@(i)];
        }
        self.data = [self.data arrayByAddingObjectsFromArray:mArr.copy];
        [self.refreshControl endRefresh];
        [self.tableView reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:demoTableViewCellId forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).description;
    return cell;
}


- (NSArray *)data {
    if (!_data) {
        NSMutableArray *mArr = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            @autoreleasepool {
                [mArr addObject:@(i)];
            }
        }
        _data = mArr.copy;
    }
    return _data;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark
#pragma mark - lazy
- (JSRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[JSRefreshControl alloc] init];
    }
    return _refreshControl;
}
@end
