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
///
@property (strong, nonatomic) person *pmodel;
///
@property (strong, nonatomic) UIButton *leftbtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"HOME PAGE";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
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
    
    
    _leftbtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 40, self.view.frame.size.height / 2 - 22.5, 80, 45)];
    [self.view addSubview:_leftbtn];
    [_leftbtn addTarget:self action:@selector(RuntimepushBtn :) forControlEvents:UIControlEventTouchUpInside];
    _leftbtn.backgroundColor = [UIColor redColor];
}
//通过Runtime跳转  并传值
-(void)RuntimepushBtn:(UIButton *)button
{
    _leftbtn.enabled = NO;
    //防止按钮被重复点击
    [self performSelector:@selector(touchchangestatus) withObject:nil afterDelay:1.f];
    
    UIViewController* MeetingDetailsView = [[NSClassFromString(@"PushViewController") alloc] init];
    SEL aSelector = NSSelectorFromString(@"setPerModel:");
    if ([MeetingDetailsView respondsToSelector:aSelector]) {
        IMP aIMP = [MeetingDetailsView methodForSelector:aSelector];
        void (*setter)(id, SEL, person*) = (void(*)(id, SEL, person*))aIMP;
        setter(MeetingDetailsView, aSelector,_pmodel);
    }
    [self.navigationController pushViewController:MeetingDetailsView animated:YES];
}

// MARK: 修改按钮状态防止重复点击
-(void)touchchangestatus
{
    _leftbtn.enabled = YES;
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
