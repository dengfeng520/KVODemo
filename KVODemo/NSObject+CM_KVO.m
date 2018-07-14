//
//  NSObject+CM_KVO.m
//  KVODemo
//
//  Created by rp.wang on 2018/2/28.
//  Copyright © 2018年 兰州北科维拓科技股份有限公司. All rights reserved.
//

#import "NSObject+CM_KVO.h"
#import <objc/message.h>

@implementation NSObject (CM_KVO)
- (void)CM_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context{
    //动态生成一个类 拼接类名
    NSString *oldClassName = NSStringFromClass([self class]);
    NSString *newClassName = [@"CMKVO" stringByAppendingString:oldClassName];
    //创建一个类
    Class MyClass = objc_allocateClassPair([self class],newClassName.UTF8String, 0);
    //添加Set方法 重写
    class_addMethod(MyClass, @selector(setName:), (IMP)setName, "v@:@");
    //注册类
    objc_registerClassPair(MyClass);
    //修改被观察isa指针
    object_setClass(self, MyClass);
    //保存观察者对象
    objc_setAssociatedObject(self, @"objc", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //    class_getMethodImplementation([self class], @selector(setName:));
}

//oc 底层调用 都会有默认两个 参数 调用者 方法编号 第三个参数才是要调用的
//调用super的set方法 通知外界
void setName(id self, SEL _cmd, NSString *str){
    //    NSLog(@"重写的监听事件%@",str);
    //保存子类类型
    id class = [self class];
    //修改self的isa指针
    object_setClass(self, class_getSuperclass(class));
    //调用父类set方法
    objc_msgSend(self, @selector(setName:),str);
    //拿到观察者
    id objc = objc_getAssociatedObject(self, @"objc");
    //通知观察者
    objc_msgSend(objc, @selector(observeValueForKeyPath:ofObject:change:context:),self,@"name",nil,nil);
    //修改回子类类型
    object_setClass(self, class);
}
@end
