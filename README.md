# JSRefresh_Extension
自定义下拉刷新控件

>>自定义下拉刷新控件

![Demo]()

>> 说明:
>>> 1.JSRefreshControl负责自定义下拉刷新控件的一些逻辑处理
>>> 2.JSRefreshView负责自定义下拉刷新控件的视图展示

>> 示例代码:(refreshControl这里使用了懒加载)
```
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(loadData:) forControlEvents:UIControlEventValueChanged];
```

