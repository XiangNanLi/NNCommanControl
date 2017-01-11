//
//  NNCopyLabel.m
//  NNCommonControl
//
//  Created by Xiaodou on 2017/1/11.
//  Copyright © 2017年 NanNuo. All rights reserved.
//

#import "NNCopyLabel.h"

@implementation NNCopyLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self attachLongHandler];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self attachLongHandler];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copyText:)) {
        return YES;
    }
    return NO;
}

- (void)copyText:(id)sender {
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.text;
}

- (void)attachLongHandler {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu:)];
    [self addGestureRecognizer:longPressGesture];
}

- (void)showMenu:(UILongPressGestureRecognizer *)longPressGesture {
    [self becomeFirstResponder];
    UIMenuItem *copyMenuItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyText:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyMenuItem, nil]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

@end
