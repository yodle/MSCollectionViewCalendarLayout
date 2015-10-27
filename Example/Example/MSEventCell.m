//
//  MSEventCell.m
//  Example
//
//  Created by Eric Horacek on 2/26/13.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

#import "MSEventCell.h"
#import "STJob.h"
#import "PureLayout.h"
#import "UIColor+Hex.h"

@interface MSEventCell ()

@property (nonatomic, strong) UIView *borderView;

@end

@implementation MSEventCell

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
        self.layer.shouldRasterize = YES;
        
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(0.0, 4.0);
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOpacity = 0.0;
        
        self.borderView = [UIView new];
        [self.contentView addSubview:self.borderView];
        
        self.summary = [UILabel new];
        self.summary.numberOfLines = 0;
        self.summary.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.summary];
        
        self.customer = [UILabel new];
        self.customer.numberOfLines = 0;
        self.customer.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.customer];
        
        [self updateColors];
        
        CGFloat borderWidth = 2.0;
        CGFloat contentMargin = 2.0;
        UIEdgeInsets contentPadding = UIEdgeInsetsMake(1.0, (borderWidth + 4.0), 1.0, 4.0);
        
        [self.borderView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self];
        [self.borderView autoSetDimension:ALDimensionWidth toSize:borderWidth];
        [self.borderView autoConstrainAttribute:NSLayoutAttributeLeft toAttribute:NSLayoutAttributeLeft ofView:self];
        [self.borderView autoConstrainAttribute:NSLayoutAttributeTop toAttribute:NSLayoutAttributeTop ofView:self];
        
        [self.summary autoConstrainAttribute:NSLayoutAttributeTop toAttribute:NSLayoutAttributeTop ofView:self withOffset:contentPadding.top];
        [self.summary autoConstrainAttribute:NSLayoutAttributeLeft toAttribute:NSLayoutAttributeLeft ofView:self withOffset:contentPadding.left];
        [self.summary autoConstrainAttribute:NSLayoutAttributeRight toAttribute:NSLayoutAttributeRight ofView:self withOffset:-contentPadding.right];
        
        [self.customer autoConstrainAttribute:NSLayoutAttributeTop toAttribute:NSLayoutAttributeBottom ofView:self.summary withOffset:contentMargin];
        [self.summary autoConstrainAttribute:NSLayoutAttributeLeft toAttribute:NSLayoutAttributeLeft ofView:self withOffset:contentPadding.left];
        [self.summary autoConstrainAttribute:NSLayoutAttributeRight toAttribute:NSLayoutAttributeRight ofView:self withOffset:-contentPadding.right];
        [self.summary autoConstrainAttribute:NSLayoutAttributeBottom toAttribute:NSLayoutAttributeBottom ofView:self withOffset:-contentPadding.bottom];
    }
    return self;
}

#pragma mark - UICollectionViewCell

- (void)setSelected:(BOOL)selected
{
    if (selected && (self.selected != selected)) {
        [UIView animateWithDuration:0.1 animations:^{
            self.transform = CGAffineTransformMakeScale(1.025, 1.025);
            self.layer.shadowOpacity = 0.2;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.transform = CGAffineTransformIdentity;
            }];
        }];
    } else if (selected) {
        self.layer.shadowOpacity = 0.2;
    } else {
        self.layer.shadowOpacity = 0.0;
    }
    [super setSelected:selected]; // Must be here for animation to fire
    [self updateColors];
}

#pragma mark - MSEventCell

- (void)setJob:(STJob*)job
{
    _job = job;
    self.summary.attributedText = [[NSAttributedString alloc] initWithString:job.summary attributes:[self titleAttributesHighlighted:self.selected]];
    self.customer.attributedText = [[NSAttributedString alloc] initWithString:job.customer attributes:[self subtitleAttributesHighlighted:self.selected]];;
}

- (void)updateColors
{
    self.contentView.backgroundColor = [self backgroundColorHighlighted:self.selected];
    self.borderView.backgroundColor = [self borderColor];
    self.summary.textColor = [self textColorHighlighted:self.selected];
    self.customer.textColor = [self textColorHighlighted:self.selected];
}

- (NSDictionary *)titleAttributesHighlighted:(BOOL)highlighted
{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.hyphenationFactor = 1.0;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    return @{
        NSFontAttributeName : [UIFont boldSystemFontOfSize:12.0],
        NSForegroundColorAttributeName : [self textColorHighlighted:highlighted],
        NSParagraphStyleAttributeName : paragraphStyle
    };
}

- (NSDictionary *)subtitleAttributesHighlighted:(BOOL)highlighted
{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.hyphenationFactor = 1.0;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    return @{
        NSFontAttributeName : [UIFont systemFontOfSize:12.0],
        NSForegroundColorAttributeName : [self textColorHighlighted:highlighted],
        NSParagraphStyleAttributeName : paragraphStyle
    };
}

- (UIColor *)backgroundColorHighlighted:(BOOL)selected
{
    return selected ? [UIColor colorWithHex:0x35b1f1] : [[UIColor colorWithHex:0x35b1f1] colorWithAlphaComponent:0.2];
}

- (UIColor *)textColorHighlighted:(BOOL)selected
{
    return selected ? [UIColor whiteColor] : [UIColor colorWithHex:0x21729c];
}

- (UIColor *)borderColor
{
    return [[self backgroundColorHighlighted:NO] colorWithAlphaComponent:1.0];
}

@end
