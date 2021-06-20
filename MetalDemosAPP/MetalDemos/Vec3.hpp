//
//  Vec3.hpp
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/18.
//

#ifndef Vec3_hpp
#define Vec3_hpp

#include <stdio.h>

class Vec3
{
    float x;
    float y;
    float z;
    
    Vec3();
    ~Vec3();
    Vec3(const float x, const float y, const float z);
    Vec3(const float *array);
    Vec3(const Vec3 &vec);
};
#endif /* Vec3_hpp */
