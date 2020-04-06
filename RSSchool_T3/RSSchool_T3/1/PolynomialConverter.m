#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    NSMutableString *finalString = [[NSMutableString alloc] init]; //результирующая строка, в т.ч. в процессе записи
    NSString *result = [[NSString alloc] init];
    if (numbers.count == 0) {
        return nil;
    }
    //    [finalString appendString:[NSString stringWithFormat:@"+ %@x^%lu ", numbers[i], index]];
    for (unsigned long index = 0; index < numbers.count; index++) {
        unsigned long power = numbers.count - 1 - index;
        if (numbers[index] == 0) {
            continue;
        }
        if (power == 0) {
            if (numbers[index].intValue == 0) {
                continue;
            }
            if (numbers[index].intValue >= 1) {
                [finalString appendString:[NSString stringWithFormat:@"+ %@", numbers[index]]];
            }
            if (numbers[index].intValue <= -1) {
                [finalString appendString:[NSString stringWithFormat:@"- %d", abs(numbers[index].intValue)]];
            }
            
        }
        if (power == 1) {
            if (numbers[index].intValue == 1) {
                [finalString appendString:[NSString stringWithFormat:@"+ x "]];
            }
            if (numbers[index].intValue == -1) {
                [finalString appendString:[NSString stringWithFormat:@"- x "]];
            }
            if (numbers[index].intValue >= 2) {
                [finalString appendString:[NSString stringWithFormat:@"+ %@x ", numbers[index]]];
            }
            if (numbers[index].intValue <= -2) {
                [finalString appendString:[NSString stringWithFormat:@"- %dx ", abs(numbers[index].intValue)]];
            }
        }
        if (power >= 2) {
            if (numbers[index].intValue == 1) {
                [finalString appendString:[NSString stringWithFormat:@"+ x^%lu ", power]];
            }
            if (numbers[index].intValue == -1) {
                [finalString appendString:[NSString stringWithFormat:@"- x^%lu ", power]];
            }
            if (numbers[index].intValue >= 2) {
                [finalString appendString:[NSString stringWithFormat:@"+ %@x^%lu ", numbers[index], power]];
            }
            if (numbers[index].intValue <= -2) {
                [finalString appendString:[NSString stringWithFormat:@"- %dx^%lu ", abs(numbers[index].intValue), power]];
            }
        }
    }

    if ([finalString hasPrefix:@"+ "]) {
        result = [finalString substringWithRange:NSMakeRange(2, (finalString.length - 2))];
    }
    
    if ([result hasSuffix:@" "]) {
        result = [result substringWithRange:NSMakeRange(0, (result.length - 1))];
    }
    return result;
}
@end
