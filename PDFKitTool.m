#import <Foundation/Foundation.h>

#import "CommandLineDriver.h"

int main (int argc, const char * argv[])
{
	return [CommandLineDriver runWithArguments:argv count:argc];
}
