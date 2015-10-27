//
//  MSEvent.m
//  Example
//
//  Created by Eric Horacek on 2/26/13.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

#import "STJob.h"

@implementation STJob

@dynamic startDate;
@dynamic endDate;
@dynamic summary;
@dynamic customer;

- (NSDate *)day
{
    return [[NSCalendar currentCalendar] startOfDayForDate:self.startDate];
}

@end
