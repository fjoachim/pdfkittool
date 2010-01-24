#import <objc/objc-auto.h>
#import <Foundation/Foundation.h>
#import "CommandLineDriver.h"

int main (int argc, const char * argv[])
{
	// objc_startCollectorThread();
	return [CommandLineDriver runWithArguments:argv count:argc];
}
