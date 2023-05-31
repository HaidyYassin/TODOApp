//
//  AddTaskScreen.m
//  TODO List
//
//  Created by JETS Mobile Lab mini4 on 26/04/2023.
//

#import "AddTaskScreen.h"

@interface AddTaskScreen ()
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UITextField *desTF;
@property (weak, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priortySC;

@end

@implementation AddTaskScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    _myTask =[Task new];
    _TasksArray =[NSMutableArray new];
    _defaults = [NSUserDefaults standardUserDefaults];
    
    _emptyFieldsAlert =[UIAlertController alertControllerWithTitle:@"Warning" message:@"Required Empty Fields!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [_emptyFieldsAlert addAction:okAction];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:-18];
    NSDate *minDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
    [comps setYear:-150];
    
    self.myDatePicker.minimumDate = minDate;
}



- (BOOL)checkEmptyFields {
    return [_titleTF.text isEqual:@""];
}
- (IBAction)addTaskToDefaults:(id)sender {
    
    if(!self.checkEmptyFields){
        _myTask.title = _titleTF.text;
        _myTask.dest =_desTF.text;
        _myTask.date = _myDatePicker.date;
        _myTask.status =@"todo";
        
        [self segPriortyBtnTapped];
        
        //Save in user defaults
        [_TasksArray addObject:_myTask];
        [self saveLastTasks];
        
        NSError *error;
        _archiveData =[NSKeyedArchiver archivedDataWithRootObject:_TasksArray requiringSecureCoding:YES error:&error];
        [_defaults setObject:_archiveData forKey:@"Tasks"];
        [self.navigationController popViewControllerAnimated:YES];
    
    }else
        [self presentViewController:_emptyFieldsAlert animated:YES completion:nil];
        
}

-(void)segPriortyBtnTapped{
    if(_priortySC.selectedSegmentIndex==0){
        _myTask.priorty= @"high";
        //NSLog(@"%@", _myTask.priorty);
    }
    if(_priortySC.selectedSegmentIndex==1){
        _myTask.priorty= @"medium";
        //NSLog(@"%@",_myTask.priorty);
    }
    
    if(_priortySC.selectedSegmentIndex==2){
        _myTask.priorty= @"low";
       // NSLog(@"%@",_myTask.priorty);
    }
}

-(void) saveLastTasks{
    NSError *err;
    NSDate *savedData = [_defaults objectForKey:@"Tasks"];
    NSSet *set =[NSSet setWithArray:@[
        [NSArray class],
        [Task class],
    ]];
    
    NSArray<Task *> *tasksArr =[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:&err];
    
    printf("%lu\n",(unsigned long)tasksArr.count);
    for(int i=0; i<tasksArr.count;i++){
        [_TasksArray addObject:tasksArr[i]];
        printf("%lu\n",(unsigned long)_TasksArray.count);
        
    }
    
}

@end
