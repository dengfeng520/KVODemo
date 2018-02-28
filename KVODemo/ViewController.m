//
//  ViewController.m
//  KVODemo
//
//  Created by rp.wang on 2018/2/26.
//  Copyright © 2018年 兰州北科维拓科技股份有限公司. All rights reserved.
//

#import "ViewController.h"
#import "person.h"
#import "NSObject+CM_KVO.h"
@interface ViewController ()
@property (strong, nonatomic) person *pmodel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    person *p = [[person alloc]init];
    
    //KVO的本质是监听一个对象是否调用set方法
    /**
     KVO底层实现原理
     1.自定义父类的一个子类
     2.重写父类对象的set方法,在内部恢复父类的做法 通知观察者
     3.如何让外界调用自定义父类的子类方法,修改当前对象的isa指针,指向自定义的子类
     */
    
    
//    [p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    //
    [p CM_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    self.pmodel = p;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%@",self.pmodel.name);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int i = 0;
    i++;
    self.pmodel.name = [NSString stringWithFormat:@"%d",i];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
