//
//  MSCurrentTimeGridline.m
//  Example
//
//  Created by Eric Horacek on 2/27/13.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

#import "MSCurrentTimeGridline.h"
#import "UIColor+Hex.h"

@implementation MSCurrentTimeGridline

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:0xfd3935];
    }
    return self;
}

@end
