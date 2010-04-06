//
//  CommandLineDriver.h
//  PDFKitTool
//
//  Created by Joachim Fornallaz on 23.01.10.
//  Copyright 2010 Joachim Fornallaz.
//
//  Heavily inspired by Marc Liyanage's CommandLineDriver class in CoreImageTool:
//  http://github.com/liyanage/coreimagetool
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <Foundation/Foundation.h>


@interface CommandLineDriver : NSObject {
	NSString *programName;
	NSMutableArray *arguments;
}

+ (int)runWithArguments:(const char*[])argv count:(int)argc;
+ (CommandLineDriver *)driverForArguments:(const char*[])argv count:(int)argc;
- (CommandLineDriver *)initWithArguments:(const char*[])argv count:(int)argc;
- (int)run;

@end
