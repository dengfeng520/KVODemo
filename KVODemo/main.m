//
//  main.m
//  KVODemo
//
//  Created by rp.wang on 2018/2/26.
//  Copyright © 2018年 兰州北科维拓科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <objc/message.h>
#import <objc/runtime.h>

@class testclass;

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        //==============================
        testclass *test = [[NSClassFromString(@"testclass") alloc]init];
        //调用实例方法
        objc_msgSend(test,@selector(setTestchar:),@"data");
        //==============================
        Class personclass = [NSClassFromString(@"testclass") class];
         //调用类方法 并传值
        [personclass performSelector:@selector(testclassobject:) withObject:@"the calss object"];
        //
        [personclass performSelector:@selector(testclasspopobject)];
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}


@interface testclass : NSObject

@property (strong, nonatomic) NSString *testchar;

@end

@implementation testclass

-(void)setTestchar:(NSString *)testchar
{
    NSLog(@"\ntestchar=============%@",testchar);
}

+(void)testclassobject:(NSString *)objectchar
{
    NSLog(@"\nobjectchar==============%@",objectchar);
}

+(void)testclasspopobject
{
    printf("\n===============testclasspopobject");

}

@end
