//
//  MathCalculation.h
//  Cycling
//
//  Created by Sandip Sarkar on 10/3/15.
//  Copyright © 2015 Rezaul Karim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MathCalculation : NSObject

+ (NSString *)stringifyDistance:(float)meters;
+ (NSString *)stringifySecondCount:(int)seconds usingLongFormat:(BOOL)longFormat;
+ (NSString *)stringifyAvgPaceFromDist:(float)meters overTime:(int)seconds;

@end
