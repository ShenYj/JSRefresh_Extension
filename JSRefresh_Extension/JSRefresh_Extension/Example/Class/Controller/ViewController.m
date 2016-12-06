//
//  ViewController.m
//  JSRefresh_Extension
//
//  Created by ShenYj on 2016/12/6.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "JSDemoTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"展示列表" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarButtonItem:)];
    
}

- (void)clickRightBarButtonItem:(UIBarButtonItem *)sender {
    JSDemoTableViewController *demoTableVC = [[JSDemoTableViewController alloc] init];
    [self.navigationController pushViewController:demoTableVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
