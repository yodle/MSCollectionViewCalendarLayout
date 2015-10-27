//
//  MSCurrentTimeIndicator.m
//  Example
//
//  Created by Eric Horacek on 2/27/13.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

#import "MSCurrentTimeIndicator.h"
#import "UIColor+Hex.h"
#import "PureLayout.h"

@interface MSCurrentTimeIndicator ()

@property (nonatomic, strong) UILabel *time;
@property (nonatomic, retain) NSTimer *minuteTimer;

@end

@implementation MSCurrentTimeIndicator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.time = [UILabel new];
        self.time.font = [UIFont boldSystemFontOfSize:10.0];
        self.time.textColor = [UIColor colorWithHex:0xfd3935];
        [self addSubview:self.time];
        
        [self.time autoConstrainAttribute:NSLayoutAttributeCenterY toAttribute:NSLayoutAttributeCenterY ofView:self];
        [self.time autoConstrainAttribute:NSLayoutAttributeRight toAttribute:NSLayoutAttributeRight ofView:self withOffset:-5.0];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *oneMinuteInFuture = [[NSDate date] dateByAddingTimeInterval:60];
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:oneMinuteInFuture];
        NSDate *nextMinuteBoundary = [calendar dateFromComponents:components];
        
        self.minuteTimer = [[NSTimer alloc] initWithFireDate:nextMinuteBoundary interval:60 target:self selector:@selector(minuteTick:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.minuteTimer forMode:NSDefaultRunLoopMode];
        
        [self updateTime];
    }
    return self;
}

#pragma mark - MSCurrentTimeIndicator

- (void)minuteTick:(id)sender
{
    [self updateTime];
}

- (void)updateTime
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"h:mm aa"];
    self.time.text = [dateFormatter stringFromDate:[NSDate date]];
    [self.time sizeToFit];
}

@end
