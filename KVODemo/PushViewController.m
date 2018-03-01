//
//  PushViewController.m
//  KVODemo
//
//  Created by rp.wang on 2018/3/1.
//  Copyright © 2018年 兰州北科维拓科技股份有限公司. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"push view";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setPerModel:(person *)person
{
    _perModel = person;
    NSLog(@"=============%@",_perModel.name);
}


@end
