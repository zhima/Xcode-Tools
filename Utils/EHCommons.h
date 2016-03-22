//
//  EHCommons.h
//  
//
//  Created by Joe on 15/3/10.
//
//

#import <Foundation/Foundation.h>


#ifdef __cplusplus
extern "C" {
#endif
    int cpuCoreCount();
    int deviceMemorySize();
    
    NSTimeInterval TGCurrentSystemTime();
    
    NSString *TGStringMD5(NSString *string);
    NSString *StringSha1(NSString *input)
    
    void TGDumpViews(UIView *view, NSString *indent);
    
    inline void TGDispatchOnMainThread(dispatch_block_t block)
    {
        if ([NSThread isMainThread])
            block();
        else
            dispatch_async(dispatch_get_main_queue(), block);
    }
    
    inline void TGDispatchAfter(double delay, dispatch_queue_t queue, dispatch_block_t block)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((delay) * NSEC_PER_SEC)), queue, block);
    }

#ifdef __cplusplus
}
#endif

@interface EHCommons : NSObject

@end
