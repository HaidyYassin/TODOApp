//
//  EditScreen.m
//  TODO List
//
//  Created by JETS Mobile Lab mini4 on 26/04/2023.
//

#import "EditScreen.h"

@interface EditScreen ()
@property (weak, nonatomic) IBOutlet UITextField *editTitle;
@property (weak, nonatomic) IBOutlet UITextField *editDescription;
@property (weak, nonatomic) IBOutlet UIDatePicker *editDate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *editPriorty;
@property (weak, nonatomic) IBOutlet UISegmentedControl *editStatus;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation EditScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _defaults = [NSUserDefaults standardUserDefaults];
    _tasktosave = [Task new];
    
    _emptyFieldsAlert =[UIAlertController alertControllerWithTitle:@"Warning" message:@"Required Empty Fields!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [_emptyFieldsAlert addAction:okAction];
    
    
    _editTitle.text = _task.title;
    _editDescription.text = _task.dest;
    _editDate.date = _task.date;
    _img.image = _task.img;
    
    if([_task.priorty  isEqual: @"high"])
        _editPriorty.selectedSegmentIndex =0;
    if([_task.priorty  isEqual: @"medium"])
        _editPriorty.selectedSegmentIndex =1;
    if([_task.priorty  isEqual: @"low"])
        _editPriorty.selectedSegmentIndex =2;
    
    if([_task.status  isEqual: @"todo"])
        _editStatus.selectedSegmentIndex =0;
    if([_task.status  isEqual: @"inprogress"])
        _editStatus.selectedSegmentIndex =1;
    if([_task.status  isEqual: @"done"])
        _editStatus.selectedSegmentIndex =2;
    
    printf("this is  %lu\n",(unsigned long)_tasksArr.count);
    
    _tasksArr = [NSMutableArray new];
    [self getLastTasks];
    printf("tasks before remove %lu\n",(unsigned long)_tasksArr.count);
    [_tasksArr removeObjectAtIndex:_task.taskID];
    printf("tasks  remove %lu\n",(unsigned long)_tasksArr.count);
    //[self saveAfterRemove];
    printf("tasks after remove %lu\n",(unsigned long)_tasksArr.count);
    
}


- (BOOL)checkEmptyFields {
    return [_editTitle.text isEqual:@""];
}

- (IBAction)save:(id)sender {
    if(!self.checkEmptyFields){
        _tasktosave.title = _editTitle.text;
        _tasktosave.dest = _editDescription.text;
        _tasktosave.date = _editDate.date;
        
        [self segPriortyBtnTapped];
        [self segStatusBtnTapped];
    
        
        //[_tasksArr insertObject:_task atIndex:_task.taskID];
        [_tasksArr addObject:_tasktosave];
        NSError *error;
        _archiveData =[NSKeyedArchiver archivedDataWithRootObject:_tasksArr requiringSecureCoding:YES error:&error];
        [_defaults setObject:_archiveData forKey:@"Tasks"];
        [self.navigationController popViewControllerAnimated:YES];
    
    }else
        [self presentViewController:_emptyFieldsAlert animated:YES completion:nil];
        
}

-(void)segPriortyBtnTapped{
    if(_editPriorty.selectedSegmentIndex==0)
        _tasktosave.priorty= @"high";
     
    if(_editPriorty.selectedSegmentIndex==1)
        _tasktosave.priorty= @"medium";
     
    
    if(_editPriorty.selectedSegmentIndex==2)
        _tasktosave.priorty= @"low";
     
}

-(void)segStatusBtnTapped{
    if(_editStatus.selectedSegmentIndex==0)
        _tasktosave.status= @"todo";
     
    if(_editStatus.selectedSegmentIndex==1)
        _tasktosave.status= @"inprogress";
    
    
    if(_editStatus.selectedSegmentIndex==2)
        _tasktosave.status= @"done";
}

-(void) getLastTasks{
    NSError *err;
    NSDate *savedData = [_defaults objectForKey:@"Tasks"];
    NSSet *set =[NSSet setWithArray:@[
        [NSArray class],
        [Task class],
    ]];
    
    _tasksArr =[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:&err];
    
    printf("alltasks size in edit %lu\n",(unsigned long)_tasksArr.count);
    
    
}

-(void) saveAfterRemove{
    NSError *error;
    _archiveData =[NSKeyedArchiver archivedDataWithRootObject:_tasksArr requiringSecureCoding:YES error:&error];
    [_defaults setObject:_archiveData forKey:@"Tasks"];
}



@end
