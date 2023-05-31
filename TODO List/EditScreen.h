//
//  EditScreen.h
//  TODO List
//
//  Created by JETS Mobile Lab mini4 on 26/04/2023.
//

#import <UIKit/UIKit.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditScreen : UIViewController
@property Task *task;
@property Task *tasktosave;

-(BOOL) checkEmptyFields;
@property UIAlertController *emptyFieldsAlert;

@property NSMutableArray<Task *> *tasksArr;
@property NSDate *archiveData;
@property NSUserDefaults *defaults;

@end

NS_ASSUME_NONNULL_END
