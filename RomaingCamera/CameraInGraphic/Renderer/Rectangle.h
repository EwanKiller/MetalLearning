//
//  NSObject+Rectangle.h
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/3.
//

#import <Foundation/Foundation.h>
#import "ShaderTypes.h"
NS_ASSUME_NONNULL_BEGIN

//@interface Rectangle: NSObject
//{
//@public vector_float4 vertices[8];
//
//@public vector_float4 colors[8];
//
//@public UInt16 indices[8];
//}
//@end

typedef struct
{
    vector_float4 vertices[8];
    vector_float4 colors[8];
    //uint indices[32];
} Rectangle;

NS_ASSUME_NONNULL_END
