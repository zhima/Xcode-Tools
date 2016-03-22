//
//  EHCommons.m
//  
//
//  Created by Joe on 15/3/10.
//
//

#import "EHCommons.h"

#include <sys/sysctl.h>
#include <mach/mach.h>
#include <mach/mach_time.h>

#import <CommonCrypto/CommonDigest.h>

int cpuCoreCount()
{
    static int count = 0;
    if (count == 0)
    {
        size_t len;
        unsigned int ncpu;
        
        len = sizeof(ncpu);
        sysctlbyname("hw.ncpu", &ncpu, &len, NULL, 0);
        count = ncpu;
    }
    
    return count;
}

int deviceMemorySize()
{
    static int memorySize = 0;
    if (memorySize == 0)
    {
        size_t len;
        __int64_t nmem;
        
        len = sizeof(nmem);
        sysctlbyname("hw.memsize", &nmem, &len, NULL, 0);
        memorySize = (int)(nmem / (1024 * 1024));
    }
    return memorySize;
}

NSTimeInterval TGCurrentSystemTime()
{
    static mach_timebase_info_data_t timebase;
    if (timebase.denom == 0)
        mach_timebase_info(&timebase);
    
    return ((double)mach_absolute_time()) * ((double)timebase.numer) / ((double)timebase.denom) / 1e9;
}

void TGDumpViews(UIView *view, NSString *indent)
{
    TGLog(@"%@%@", indent, view);
    NSString *newIndent = [[NSString alloc] initWithFormat:@"%@    ", indent];
    for (UIView *child in view.subviews)
        TGDumpViews(child, newIndent);
}

NSString *TGStringMD5(NSString *string)
{
    const char *ptr = [string UTF8String];
    unsigned char md5Buffer[16];
    CC_MD5(ptr, [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], md5Buffer);
    NSString *output = [[NSString alloc] initWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", md5Buffer[0], md5Buffer[1], md5Buffer[2], md5Buffer[3], md5Buffer[4], md5Buffer[5], md5Buffer[6], md5Buffer[7], md5Buffer[8], md5Buffer[9], md5Buffer[10], md5Buffer[11], md5Buffer[12], md5Buffer[13], md5Buffer[14], md5Buffer[15]];
    
    return output;
}

NSString *StringSha1(NSString *input)
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}

@implementation EHCommons

@end
