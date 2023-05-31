//
//  InProgressScreen.h
//  TODO List
//
//  Created by JETS Mobile Lab mini4 on 26/04/2023.
//

#import <UIKit/UIKit.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface InProgressScreen : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property NSUserDefaults *defaults;

@property NSDate *archiveData;
@property NSMutableArray<Task *> *tasksArr;

@property NSMutableArray<Task *> *allInProgressTasks;
@property NSMutableArray<Task *> *highPriortyTask;
@property NSMutableArray<Task *> *lowPriortyTask;
@property NSMutableArray<Task *> *mediumPriortyTask;

@property BOOL isFiltered;
@end

NS_ASSUME_NONNULL_END
