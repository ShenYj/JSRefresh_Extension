# JSRefresh_Extension
自定义下拉刷新控件

>>自定义下拉刷新控件

![Demo](https://github.com/ShenYj/JSRefresh_Extension/blob/master/下拉刷新控件.gif?raw=true)

>> 说明:
>>> 1.JSRefreshControl负责自定义下拉刷新控件的一些逻辑处理<br>
>>> 2.JSRefreshView负责自定义下拉刷新控件的视图展示<br>
>>> 3.使用了苹果原生自动布局,不存在任何第三方类库依赖<br>

>> 示例代码:(refreshControl这里使用了懒加载)
```
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(loadData:) forControlEvents:UIControlEventValueChanged];
```

