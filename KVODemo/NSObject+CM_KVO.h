//
//  NSObject+CM_KVO.h
//  KVODemo
//
//  Created by rp.wang on 2018/2/28.
//  Copyright © 2018年 兰州北科维拓科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CM_KVO)
- (void)CM_addObserver:(NSObject *_Nullable)observer forKeyPath:(NSString *_Nonnull)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
@end
