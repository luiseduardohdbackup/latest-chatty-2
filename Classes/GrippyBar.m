//
//  Grippybar.m
//  LatestChatty2
//
//  Created by Alex Wayne on 3/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GrippyBar.h"


@implementation GrippyBar

- (id)initWithCoder:(NSCoder *)coder {
  if (self = [super initWithCoder:coder]) {
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GrippyBarBackground.png"]];
    backgroundView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    backgroundView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:backgroundView];
    [backgroundView release];
    
    UIImageView *grippy = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GrippyBar.png"]];
    grippy.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    grippy.contentMode = UIViewContentModeCenter;
    [self addSubview:grippy];
    [grippy release];
    
  }
  return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  isDragging = YES;
  initialTouchPoint = [[touches anyObject] locationInView:self.superview];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  if (isDragging) {
    CGPoint currentPoint = [[touches anyObject] locationInView:self.superview];
    CGPoint distance = CGPointMake(currentPoint.x - initialTouchPoint.x, currentPoint.y - initialTouchPoint.y);
    BOOL vertical = (abs(distance.y) > abs(distance.x));
    
    if (vertical) {
      if (distance.y > 0) {
        [delegate grippyBarDidSwipeDown];
        isDragging = NO;
      } else if (distance.y < 0) {
        [delegate grippyBarDidSwipeUp];
        isDragging = NO;
      }
    } else {
      if (distance.x > 0) {
        [delegate grippyBarDidSwipeRight];
        isDragging = NO;
      } else if (distance.x < 0) {
        [delegate grippyBarDidSwipeLeft];
        isDragging = NO;
      }
    }
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  isDragging = NO;
}


- (void)dealloc {
  [super dealloc];
}


@end
