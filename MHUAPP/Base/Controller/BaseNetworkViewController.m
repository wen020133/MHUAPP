//
//  BaseNetworkViewController.m
//  PrinterCompany
//
//  Created by 今日电器 on 15/9/18.
//  Copyright (c) 2015年 今日电器. All rights reserved.
//

#import "BaseNetworkViewController.h"
#import "JSONKit.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "Reachability.h"

@interface BaseNetworkViewController ()

@end

@implementation BaseNetworkViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
   
//    [_client setOnError:@selector(errorHandler:withException:)];
}
- (void)requestAPIWithServe:(NSString *)service andInfos:(NSDictionary *)infos
{
    if([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus]!=NotReachable ||[[Reachability reachabilityForInternetConnection] currentReachabilityStatus]!=NotReachable)
    {
    
        NSLog(@"service====%@",service);
       
        
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
        NSString *timeString = [NSString stringWithFormat:@"%.0f",a ]; //转为字符型

        [infos setValue:[[NSString stringWithFormat:@"mhupro_%@_mhupro",[timeString md5]] md5] forKey:@"token"];
        [infos setValue:timeString forKey:@"time"];
        NSLog(@"parameters====%@",infos);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 20.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html",nil];
        // post请求
        [manager POST:service parameters:infos constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
           
         } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) { // 成功，关闭网络指示器
             NSLog(@"responseObject====%@",responseObject);
             [SVProgressHUD dismiss];
             self.results = responseObject;
             [self processData];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { // 失败，关闭网络指示器
             NSLog(@"ada===%@",[error localizedDescription]);
             NSString *str_error = [error localizedDescription];
             [SVProgressHUD dismiss];
             [self requestFailed:str_error];
             [self requestFailedDisMJFoot];
                  }];
       
       }

}
- (void)processData
{
    NSLog(@"返回数据====%@",_results);
}
-(void)requestFailedDisMJFoot
{
    
}
- (void)requestGetAPIWithServe:(NSString *)urlString
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil];


//    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
//    NSString *timeString = [NSString stringWithFormat:@"%.0f",a ]; //转为字符型
//
//    NSString *token = [[NSString stringWithFormat:@"mhupro_%@_mhupro",[timeString md5]] md5];
//
//    if ([urlString containsString:@"id="]) {
//      urlString  = [NSString stringWithFormat:@"%@&time=%@&token=%@",urlString,timeString,token];
//    }
//    else
//    {
//        urlString = [NSString stringWithFormat:@"%@?time=%@&token=%@",urlString,timeString,token];
//
//    }

    NSLog(@"urlString====%@",urlString);

    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject====%@",responseObject);
        [SVProgressHUD dismiss];
        self.results = responseObject;
        [self getProcessData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败，关闭网络指示器
        NSLog(@"ada===%@",[error localizedDescription]);
        NSString *str_error = [error localizedDescription];
        [SVProgressHUD dismiss];
        [self requestFailed:str_error];
        [self requestFailedDisMJFoot];
    }];

}


- (void)requestDeleteAPIWithServe:(NSString *)urlString
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil];


//    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
//    NSString *timeString = [NSString stringWithFormat:@"%.0f",a ]; //转为字符型
//
//    NSString *token = [[NSString stringWithFormat:@"mhupro_%@_mhupro",[timeString md5]] md5];
//
//    if ([urlString containsString:@"id="]) {
//        urlString  = [NSString stringWithFormat:@"%@&time=%@&token=%@",urlString,timeString,token];
//    }
//    else
//    {
//        urlString = [NSString stringWithFormat:@"%@?time=%@&token=%@",urlString,timeString,token];
//
//    }

    NSLog(@"urlString====%@",urlString);

    [manager DELETE:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSLog(@"delete responseObject====%@",responseObject);
        [SVProgressHUD dismiss];
        self.results = responseObject;
        [self deleteProcessData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败，关闭网络指示器
        NSLog(@"ada===%@",[error localizedDescription]);
        NSString *str_error = [error localizedDescription];
        [SVProgressHUD dismiss];
        [self requestFailed:str_error];
        [self requestFailedDisMJFoot];
    }];
}
- (void)getProcessData
{

}
-(void)deleteProcessData
{

}
// Connected failed
- (void)requestFailed:(NSString *)error
{
    [SVProgressHUD dismiss];
    [self jxt_showAlertWithTitle:@"消息提示" message:error appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"确定");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        if (buttonIndex == 0) {
            NSLog(@"cancel");
        }

        NSLog(@"%@--%@", action.title, action);
    }];

}
- (void)requestAPIWithServe:(NSString *)service andInfos:(NSDictionary *)infos andImageDataArr:(NSArray *)imageDataArr andImageName:(NSString *)imagenName
{
    if([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus]!=NotReachable ||[[Reachability reachabilityForInternetConnection] currentReachabilityStatus]!=NotReachable)
    {
        
        NSLog(@"service====%@",service);
        
        
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
        NSString *timeString = [NSString stringWithFormat:@"%.0f",a ]; //转为字符型
        
        [infos setValue:[[NSString stringWithFormat:@"mhupro_%@_mhupro",[timeString md5]] md5] forKey:@"token"];
        [infos setValue:timeString forKey:@"time"];
        NSLog(@"parameters====%@",infos);
		AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
        [securityPolicy setAllowInvalidCertificates:YES];
		
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 60.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/plain", nil ];
		[manager setSecurityPolicy:securityPolicy];
        // post请求
        [manager POST:service parameters:infos constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
            NSLog(@"arr.count===%ld",imageDataArr.count);
			NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
			formatter.dateFormat =@"yyyyMMddHHmmss";
			NSString *str = [formatter stringFromDate:[NSDate date]];
            for (int a=0; a<imageDataArr.count; a++) {
            [formData appendPartWithFileData:[imageDataArr objectAtIndex:a] name:imagenName fileName:[NSString stringWithFormat:@"%@%d.jpg",str,a] mimeType:@"image/jpg"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) { // 成功，关闭网络指示器
            NSLog(@"responseObject====%@",responseObject);
            self.results = responseObject;
            [self processData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { // 失败，关闭网络指示器
            NSLog(@"ada===%@",error);
            NSString *adasa = [NSString stringWithFormat:@"%@", error];
            [self requestFailed:adasa];
            [self requestFailedDisMJFoot];
        }];
        
    }
}




- (NSDictionary *)getJSONDataWithObject:(id)JSON {
    NSDictionary * ret;
    if ([JSON isKindOfClass:[NSString class]]){
        ret = MSDynamicCast(NSDictionary, [[JSONDecoder decoder] objectFromJSONString]);
    }else{
        ret = MSDynamicCast(NSDictionary, JSON);
    }
    return ret;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0,
                                                      [outputStr length])];
    
    return
    [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}
- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    NSLog(@"destDateString====%@",destDateString);
    return destDateString;
}

- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize { //先判断当前质量是否满足要求，不满足再进行压缩
	__block NSData *finallImageData = UIImageJPEGRepresentation(source_image,1.0);
	NSUInteger sizeOrigin = finallImageData.length;
	NSUInteger sizeOriginKB = sizeOrigin / 1024;
	if (sizeOriginKB <= maxSize) {
		return finallImageData;
	}
	//先调整分辨率
	CGSize defaultSize = CGSizeMake(1024, 1024);
	UIImage *newImage = [self newSizeImage:defaultSize image:source_image];
	finallImageData = UIImageJPEGRepresentation(newImage,1.0);
	//保存压缩系数
	NSMutableArray *compressionQualityArr = [NSMutableArray array];
	CGFloat avg = 1.0/250; CGFloat value = avg;
	for (int i = 250; i >= 1; i--) {
		value = i*avg; [compressionQualityArr addObject:@(value)];
	}
	//思路：使用二分法搜索
	finallImageData = [self halfFuntion:compressionQualityArr image:newImage sourceData:finallImageData maxSize:maxSize];
	//如果还是未能压缩到指定大小，则进行降分辨率
	while (finallImageData.length == 0) {
		//每次降100分辨率
		if (defaultSize.width-100 <= 0 || defaultSize.height-100 <= 0) { break;
		}
		defaultSize = CGSizeMake(defaultSize.width-100, defaultSize.height-100);
		UIImage *image = [self newSizeImage:defaultSize image:[UIImage imageWithData:UIImageJPEGRepresentation(newImage,[[compressionQualityArr lastObject] floatValue])]];
		finallImageData = [self halfFuntion:compressionQualityArr image:image sourceData:UIImageJPEGRepresentation(image,1.0) maxSize:maxSize];
	}
	return finallImageData;
}
#pragma mark 调整图片分辨率/尺寸（等比例缩放）
- (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)source_image {
	CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
	CGFloat tempHeight = newSize.height / size.height;
	CGFloat tempWidth = newSize.width / size.width;
	if (tempWidth > 1.0 && tempWidth > tempHeight)
	{
		newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
	}
	else if (tempHeight > 1.0 && tempWidth < tempHeight)
	{
		newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
	}
	UIGraphicsBeginImageContext(newSize);
	[source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext(); UIGraphicsEndImageContext(); return newImage;
}

#pragma mark 二分法
- (NSData *)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize {
	NSData *tempData = [NSData data];
	NSUInteger start = 0;
	NSUInteger end = arr.count - 1;
	NSUInteger index = 0;
	NSUInteger difference = NSIntegerMax;
	while(start <= end) {
		index = start + (end - start)/2;
		finallImageData = UIImageJPEGRepresentation(image,[arr[index] floatValue]);
		NSUInteger sizeOrigin = finallImageData.length;
		NSUInteger sizeOriginKB = sizeOrigin / 1024;
		NSLog(@"当前降到的质量：%ld", (unsigned long)sizeOriginKB); NSLog(@"\nstart：%zd\nend：%zd\nindex：%zd\n压缩系数：%lf", start, end, (unsigned long)index, [arr[index] floatValue]);
		if (sizeOriginKB > maxSize) {
			start = index + 1;
		}
		else if (sizeOriginKB < maxSize) {
			if (maxSize-sizeOriginKB < difference) {
				difference = maxSize-sizeOriginKB; tempData = finallImageData;
			}
			if (index<=0) {
				break;
			}
			end = index - 1;
		} else {
			break;
		}
	}
	return tempData;
}
#pragma mark - 消失

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
