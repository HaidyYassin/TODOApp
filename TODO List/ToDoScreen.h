//
//  ToDoScreen.h
//  TODO List
//
//  Created by JETS Mobile Lab mini4 on 26/04/2023.
//

#import <UIKit/UIKit.h>
#import "AddTaskProtocol.h"
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoScreen : UIViewController <AddTaskProtocol,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property NSMutableArray<Task *> *allTasks;
@property NSUserDefaults *defaults;

@property NSMutableArray *TasksArray;
@property NSDate *archiveData;
@property NSMutableArray<Task *> *tasksArr;

@property UIAlertController *deleteAlert;
@property UIAlertAction *cancelAction ;
@property UIAlertAction *okAction;

@property NSMutableArray<Task *> *filteredTasks;
@end

NS_ASSUME_NONNULL_END
