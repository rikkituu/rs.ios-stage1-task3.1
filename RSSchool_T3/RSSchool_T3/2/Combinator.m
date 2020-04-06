#import "Combinator.h"

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    NSNumber *c = array.firstObject;
    NSNumber *n = array.lastObject;
    for (int k = 0; k <= n.intValue; k++) {
        double nFactorial = [self factorial:n].doubleValue;
        double kFactorial = [self factorial:@(k)].doubleValue;
        double nkFactorial = [self factorial:@(n.doubleValue-k)].doubleValue;
        NSNumber *myC = @(nFactorial/(nkFactorial*kFactorial));
        
        if ([c isEqual:myC]) {
            return @(k);
        }
    }
    return nil;
}
-(NSNumber*)factorial:(NSNumber*)myValue {
    NSNumber *myFactorial = @1;
    if (myValue == 0) {
        return myFactorial;
    } else for (int i = 1; i <= myValue.intValue; i++) {
        myFactorial = @(myFactorial.doubleValue*i);
    }
    return myFactorial;
}

@end
