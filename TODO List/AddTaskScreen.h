//
//  AddTaskScreen.h
//  TODO List
//
//  Created by JETS Mobile Lab mini4 on 26/04/2023.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "AddTaskProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddTaskScreen : UIViewController
@property Task *myTask;
@property id<AddTaskProtocol> ref;

-(BOOL) checkEmptyFields;
@property UIAlertController *emptyFieldsAlert;

@property NSMutableArray *TasksArray;
@property NSDate *archiveData;
@property NSUserDefaults *defaults;
@end

NS_ASSUME_NONNULL_END
