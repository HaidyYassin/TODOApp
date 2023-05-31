//
//  InProgressScreen.m
//  TODO List
//
//  Created by JETS Mobile Lab mini4 on 26/04/2023.
//

#import "InProgressScreen.h"
#import "Task.h"
#import "DetailsScreen.h"
#import "EditScreen.h"

@interface InProgressScreen ()
@property (weak, nonatomic) IBOutlet UINavigationItem *inprogressNavItem;
@property (weak, nonatomic) IBOutlet UITableView *inprogressTable;

@end

@implementation InProgressScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isFiltered = NO;
    
    _defaults =[NSUserDefaults standardUserDefaults];    
    _inprogressNavItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain
        target:self
       action:@selector(filterTasks)];
}

- (void)viewWillAppear:(BOOL)animated{
    _allInProgressTasks =[NSMutableArray new];
    _highPriortyTask =[NSMutableArray new];
    _lowPriortyTask =[NSMutableArray new];
    _mediumPriortyTask =[NSMutableArray new];
    
    
    [self getInprogressTasks];
    [self.inprogressTable reloadData];
}

-(void)filterTasks{
   _isFiltered= !_isFiltered;
    [self.inprogressTable reloadData];
}

- (void)getInprogressTasks {
    
    NSError *err;
    NSDate *savedData = [_defaults objectForKey:@"Tasks"];
    NSSet *set =[NSSet setWithArray:@[
        [NSArray class],
        [Task class],
    ]];
    
    _tasksArr =[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:&err];
    
    printf("all tasks %lu\n",(unsigned long)_tasksArr.count);
    for(int i=0; i<_tasksArr.count;i++){
        
        if([_tasksArr[i].status  isEqual: @"inprogress"]){
            
            [_allInProgressTasks addObject:_tasksArr[i]];
            
            if([_tasksArr[i].priorty isEqual:@"high"]){
                _tasksArr[i].img = [UIImage imageNamed:@"high.png"];
                [_highPriortyTask addObject:_tasksArr[i]];
            }
            if([_tasksArr[i].priorty isEqual:@"medium"]){
                _tasksArr[i].img = [UIImage imageNamed:@"medium.png"];
                [_mediumPriortyTask addObject:_tasksArr[i]];
            }
            if([_tasksArr[i].priorty isEqual:@"low"]){
                _tasksArr[i].img = [UIImage imageNamed:@"low.png"];
                [_lowPriortyTask addObject:_tasksArr[i]];
            }
        }
        
       
    }
    printf("_allInProgressTasks %lu\n",(unsigned long)_allInProgressTasks.count);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsScreen * details = [self.storyboard instantiateViewControllerWithIdentifier:@"details"];
    details.task  =[_allInProgressTasks objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:details animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_isFiltered)
        return 3;
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    if(_isFiltered){
        switch (indexPath.section) {
            case 0:
                cell.textLabel.text =[_highPriortyTask objectAtIndex:indexPath.row].title;
                cell.imageView.image = [_highPriortyTask objectAtIndex:indexPath.row].img;
                break;
                
            case 1:
                cell.textLabel.text =[_mediumPriortyTask objectAtIndex:indexPath.row].title;
                cell.imageView.image = [_mediumPriortyTask objectAtIndex:indexPath.row].img;
                break;
                
            case 2:
                cell.textLabel.text =[_lowPriortyTask objectAtIndex:indexPath.row].title;
                cell.imageView.image = [_lowPriortyTask objectAtIndex:indexPath.row].img;
                break;
                
            default:
                break;
        }
        
    }else{
        
        cell.textLabel.text =[_allInProgressTasks objectAtIndex:indexPath.row].title;
        cell.imageView.image = [_allInProgressTasks objectAtIndex:indexPath.row].img;
    }
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_isFiltered){
        switch (section) {
            case 0:
                return [_highPriortyTask count];
                break;
            case 1:
                return [_mediumPriortyTask count];
                break;
            case 2:
                return [_lowPriortyTask count];
                break;
            default:
                break;
        }
    }
    
 return _allInProgressTasks.count;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *string;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
        /* Create custom view to display section header... */
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
        [label setFont:[UIFont boldSystemFontOfSize:12]];
    label.textColor =[UIColor whiteColor];
   
    if(_isFiltered){
        switch (section) {
            case 0:
                string =@"High Priorty Tasks";
                break;
            case 1:
                string =@"Medium Priorty Tasks";
                break;
            case 2:
                string =@"Low Priorty Tasks";
                break;
        }}else{
            string =@"All Tasks";
        }
    
        [label setText:string];
        [view addSubview:label];
        [view setBackgroundColor:[UIColor linkColor]];
        return view;
    
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        EditScreen * edit = [self.storyboard instantiateViewControllerWithIdentifier:@"editscreen"];
        edit.task =[self->_allInProgressTasks objectAtIndex:indexPath.row];
        edit.task.taskID = indexPath.row;
        [self.navigationController pushViewController:edit animated:YES];
    }];
    editAction.backgroundColor = [UIColor linkColor];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        if([[self->_allInProgressTasks objectAtIndex:indexPath.row].priorty isEqual:@"high"]){
            [self->_highPriortyTask removeObjectAtIndex:indexPath.row];
        }
        if([[self->_allInProgressTasks objectAtIndex:indexPath.row].priorty isEqual:@"medium"]){
            [self->_mediumPriortyTask removeObjectAtIndex:indexPath.row];
        }
        if([[self->_allInProgressTasks objectAtIndex:indexPath.row].priorty isEqual:@"low"]){
            [self->_lowPriortyTask removeObjectAtIndex:indexPath.row];
        }
        [self->_allInProgressTasks removeObjectAtIndex:indexPath.row];
        [self->_tasksArr removeObjectAtIndex:indexPath.row];
        
        
        NSError *error;
        self->_archiveData =[NSKeyedArchiver archivedDataWithRootObject:_tasksArr requiringSecureCoding:YES error:&error];
        [self->_defaults setObject:self->_archiveData forKey:@"Tasks"];
        
        [self.inprogressTable reloadData];
        
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction,editAction];
}




@end
