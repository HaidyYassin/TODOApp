//
//  ToDoScreen.m
//  TODO List
//
//  Created by JETS Mobile Lab mini4 on 26/04/2023.
//

#import "ToDoScreen.h"
#import "AddTaskScreen.h"
#import "Task.h"
#import "DetailsScreen.h"
#import "EditScreen.h"

@interface ToDoScreen ()

@property (weak, nonatomic) IBOutlet UINavigationItem *myItem;
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (weak, nonatomic) IBOutlet UISearchBar *searchTask;

@end

@implementation ToDoScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _deleteAlert =[UIAlertController alertControllerWithTitle:@"Warning" message:@"Are You Sure You Want to Delete This Task?" preferredStyle:UIAlertControllerStyleAlert];
    
    _defaults =[NSUserDefaults standardUserDefaults];
   
    _myItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Add Task"
            style:UIBarButtonItemStylePlain
            target:self
            action:@selector(add)];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length != 0) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
                return [[evaluatedObject lowercaseString] containsString:[searchText lowercaseString]];
            }];
        NSMutableArray * names = [NSMutableArray new];
        for(int i=0; i<_allTasks.count; i++)
            [names addObject:_allTasks[i].title];
        
        names = [names filteredArrayUsingPredicate:predicate];
        _filteredTasks =[NSMutableArray new];
        for(int i=0; i<names.count;i++)
            if(names[i]== _allTasks[i].title)
             [self.filteredTasks addObject:_allTasks[i]];
        
        NSLog(@"%@", self.filteredTasks);
            
        }
        else {
            self.filteredTasks = self.allTasks;
        }
        
        [self.myTable reloadData];
     
}

- (void)viewWillAppear:(BOOL)animated{
    _allTasks =[NSMutableArray new];
    _filteredTasks =[NSMutableArray new];
    [self addTask];
    self.filteredTasks = self.allTasks;
    
    [self.myTable reloadData];
}



-(void) add{
    printf("add");
    AddTaskScreen *addTask = [self.storyboard instantiateViewControllerWithIdentifier:@"addscreen"];
    addTask.ref = self;
    [self.navigationController pushViewController:addTask animated:YES];
}


- (void)addTask { 
    
    NSError *err;
    NSDate *savedData = [_defaults objectForKey:@"Tasks"];
    NSSet *set =[NSSet setWithArray:@[
        [NSArray class],
        [Task class],
    ]];
    
    _tasksArr =[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:&err];
    
    printf("%lu\n",(unsigned long)_tasksArr.count);
    for(int i=0; i<_tasksArr.count;i++){
        
        if([_tasksArr[i].priorty isEqual:@"high"])
            _tasksArr[i].img = [UIImage imageNamed:@"high.png"];
        if([_tasksArr[i].priorty isEqual:@"medium"])
            _tasksArr[i].img = [UIImage imageNamed:@"medium.png"];
        if([_tasksArr[i].priorty isEqual:@"low"])
            _tasksArr[i].img = [UIImage imageNamed:@"low.png"];
        
        if([_tasksArr[i].status  isEqual: @"todo"])
            [_allTasks addObject:_tasksArr[i]];
        printf("%lu\n",(unsigned long)_allTasks.count);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsScreen * details = [self.storyboard instantiateViewControllerWithIdentifier:@"details"];
    details.task  =[_allTasks objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:details animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text =[_filteredTasks objectAtIndex:indexPath.row].title;
    cell.imageView.image = [_filteredTasks objectAtIndex:indexPath.row].img;
    
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _filteredTasks.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        EditScreen * edit = [self.storyboard instantiateViewControllerWithIdentifier:@"editscreen"];
        edit.task =[self->_allTasks objectAtIndex:indexPath.row];
        edit.task.taskID = indexPath.row;
        [self.navigationController pushViewController:edit animated:YES];
    }];
    editAction.backgroundColor = [UIColor linkColor];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        [self->_allTasks removeObjectAtIndex:indexPath.row];
        [self->_tasksArr removeObjectAtIndex:indexPath.row];
        NSError *error;
        self->_archiveData =[NSKeyedArchiver archivedDataWithRootObject:_tasksArr requiringSecureCoding:YES error:&error];
        [self->_defaults setObject:self->_archiveData forKey:@"Tasks"];
        [self.myTable reloadData];
        
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction,editAction];
}


@end
