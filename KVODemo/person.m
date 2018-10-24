//
//  person.m
//  KVODemo
//
//  Created by rp.wang on 2018/2/28.
//  Copyright © 2018年 兰州北科维拓科技股份有限公司. All rights reserved.
//

#import "person.h"



@implementation person

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];

    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%@",self.name);
}

-(void)setName:(NSString *)name{
    _name=[NSString stringWithFormat:@"%@ MMP",name];
}
@end



