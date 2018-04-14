//
//  BaseNetworkViewController.h
//  PrinterCompany
//
//  Created by 今日电器 on 15/9/18.
//  Copyright (c) 2015年 今日电器. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface BaseNetworkViewController : UIViewController

- (void)requestAPIWithServe:(NSString *)service andInfos:(NSDictionary *)infos ; //POST上传普通数据

- (void)requestGetAPIWithServe:(NSString *)urlString; //Get请求数据

@property (nonatomic, retain) NSDictionary              *results;




- (NSDictionary *)getJSONDataWithObject:(id)JSON;
//urlDecode
- (NSString *)decodeFromPercentEscapeString: (NSString *) input;
- (NSString *)getIPAddress;//获取IP地址
- (NSString *)stringFromDate:(NSDate *)date;

- (void)requestAPIWithServe:(NSString *)service andInfos:(NSDictionary *)infos andImageDataArr:(NSArray *)imageDataArr andImageName:(NSString *)imagenName; //上传图文

- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize; //压缩图片


@end
