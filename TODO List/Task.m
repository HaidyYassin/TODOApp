//
//  Task.m
//  TODO List
//
//  Created by JETS Mobile Lab mini4 on 26/04/2023.
//

#import "Task.h"

@implementation Task

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:_title forKey:@"title"];
    [coder encodeObject:_dest forKey:@"description"];
    [coder encodeObject:_img forKey:@"img"];
    [coder encodeObject:_date forKey:@"date"];
    [coder encodeObject:_priorty forKey:@"priorty"];
    [coder encodeObject:_status forKey:@"status"];
    [coder encodeInt:_taskID forKey:@"id"];
   
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if((self = [super init])){
        _title = [coder decodeObjectOfClass:[NSString class] forKey:@"title"];
        _dest = [coder decodeObjectOfClass:[NSString class] forKey:@"description"];
        _img = [coder decodeObjectOfClass:[UIImage class] forKey:@"img"];
        _date = [coder decodeObjectOfClass:[NSDate class] forKey:@"date"];
        _priorty = [coder decodeObjectOfClass:[NSString class] forKey:@"priorty"];
        _status = [coder decodeObjectOfClass:[NSString class] forKey:@"status"];
        _taskID =[coder decodeIntForKey: @"id"];
       
        
    }
    return self;
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

@end
