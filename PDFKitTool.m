#import <objc/objc-auto.h>
#import <Foundation/Foundation.h>
#import "CommandLineDriver.h"

int main (int argc, const char * argv[])
{
	// objc_startCollectorThread(); // to be enabled once rdar://7573841 is fixed
	return [CommandLineDriver runWithArguments:argv count:argc];
}
