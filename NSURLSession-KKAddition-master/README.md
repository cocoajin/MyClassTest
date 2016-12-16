NSURLSession-KKAddition
=======================

NSURLSession Category with GET,POST,Download File,JSON operation

### 可用api
```objective-c
//GET 请求
+ (NSOperation *)GET:(NSString *)path
             pararms:(NSDictionary *)parms
           completed:(KKCompletedBlock )compleBlock
              failed:(KKFailedBlock )failBlock;

//POST 请求
+ (NSOperation *)POST:(NSString *)path
             pararms:(NSDictionary *)parms
           completed:(KKCompletedBlock )compleBlock
              failed:(KKFailedBlock )failBlock;

//下载文件
//Path 不需要添加文件名：如 ~/Desktop/
+ (NSOperation *)Download:(NSString *)file
                   saveTo:(NSString *)path
                 progress:(KKProgressBlock )progressBlock
                completed:(KKFileBlock )compleBlock
                   failed:(KKFailedBlock )failBlock;

//打印字符
+ (void)printDataToString:(NSData *)data;

//解析json
+ (id)parseJSONData:(NSData *)data;

```

### Demo

```objective-c
    //GET
    [NSURLSession GET:@"http://httpbin.org/get" pararms:@{@"name": @"jkk",@"age":@"24"} completed:^(NSData *data) {
        
        //NSLog(@"%@",data);
        [NSURLSession printDataToString:data];
        
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];


	//POST
    [NSURLSession POST:@"http://httpbin.org/post" pararms:@{@"key": @"value",@"name":@"jkk"} completed:^(NSData *data) {
        
        [NSURLSession printDataToString:data];
        
    } failed:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    



    
    //文件下载
    NSString *file = @"http://dl.360safe.com/360zip_setup_3.1.0.2061.exe";
    NSString *savePath = @"/Users/user/Desktop/";
    [NSURLSession Download:file saveTo:savePath progress:^(CGFloat progress) {
        
        NSLog(@"---- %f ",progress);
        
    } completed:^() {
        
        NSLog(@"下载完成");
        
    } failed:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
    
    
    //json
    [NSURLSession GET:@"http://httpbin.org/post" pararms:nil completed:^(NSData *data) {
        
        NSLog(@"%@",[NSURLSession parseJSONData:data]);
        
    } failed:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];

```

### NSURLSession Note
[http://www.cnblogs.com/cocoajin/p/3708809.html](http://www.cnblogs.com/cocoajin/p/3708809.html)