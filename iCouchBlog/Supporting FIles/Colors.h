//
//  Colors.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/7/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor (Kanbanery)
+ (UIColor *) colorWithIntegersRed: (CGFloat) red green: (CGFloat) green blue: (CGFloat) blue;

+ (UIColor *) navigationBarColor;
+ (UIColor *) backgroundColor;
+ (UIColor *) darkTextColor;
+ (UIColor *) lightTextColor;
+ (UIColor *) lightBackgroundColor;
+ (UIColor *) tableSeparatorColor;
@end
