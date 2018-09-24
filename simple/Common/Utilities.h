//
//  Utils.h
//  Korte
//
//  Created by Peace on 9/21/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utiliti2es.h"
@interface Utilities : NSObject{
    int indexImage;
    Boolean idVerifyStatus;
}
@property(assign, nonatomic) int indexImage;
@property(assign, nonatomic) Boolean idVerifyStatus;
+ (id)sharedUtilities;
-(void) setIndexImageOfCell:(int)index;
-(void) setIdVerifyStatus:(Boolean)idVerifyStatus;
@end
