//
//  Task.h
//  TODO List
//
//  Created by JETS Mobile Lab mini4 on 26/04/2023.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject <NSCoding,NSSecureCoding>
@property NSString *title;
@property NSString *dest;

@property int taskID;

@property NSString *priorty;
@property NSString *status;
@property NSDate *date;
@property UIImage *img;

-(void)encodeWithCoder:(NSCoder *)coder;
@end

NS_ASSUME_NONNULL_END
