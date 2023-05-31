//
//  DetailsScreen.m
//  TODO List
//
//  Created by JETS Mobile Lab mini4 on 26/04/2023.
//

#import "DetailsScreen.h"

@interface DetailsScreen ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;

@end

@implementation DetailsScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];

    //Optionally for time zone conversions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];

    NSString *stringFromDate = [formatter stringFromDate:_task.date];

    _img.image = _task.img;
    _titleLabel.text = _task.title;
    _descriptionLabel.text = _task.dest;
    _dateLabel.text = stringFromDate;
    _priorityLabel.text = _task.priorty;
}



@end
