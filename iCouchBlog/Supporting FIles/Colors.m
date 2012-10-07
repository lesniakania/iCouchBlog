//
//  Colors.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/7/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "Colors.h"

@implementation UIColor (Kanbanery)

+ (UIColor *) colorWithIntegersRed: (CGFloat) red green: (CGFloat) green blue: (CGFloat) blue {
  return [UIColor colorWithRed: red/256.0 green: green/256.0 blue: blue/256.0 alpha: 1.0];
}


+ (UIColor *) navigationBarColor {
  return [UIColor colorWithIntegersRed: 142 green: 179 blue: 111];
}

+ (UIColor *) backgroundColor {
  return [UIColor colorWithIntegersRed: 207 green: 232 blue: 186];
}

+ (UIColor *) darkTextColor {
  return [UIColor colorWithIntegersRed: 64 green: 77 blue: 52];
}

+ (UIColor *) lightTextColor {
  return [UIColor colorWithIntegersRed: 77 green: 107 blue: 49];
}


+ (UIColor *) lightBackgroundColor {
  return [UIColor colorWithIntegersRed: 228 green: 247 blue: 210];
}

+ (UIColor *) tableSeparatorColor {
  return [UIColor colorWithIntegersRed: 162 green: 181 blue: 145];
}

@end