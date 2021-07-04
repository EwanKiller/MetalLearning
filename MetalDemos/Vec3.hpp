//
//  Vec3.hpp
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/18.
//

#ifndef Vec3_hpp
#define Vec3_hpp

#include <math.h>

class Vec3
{
public:
    float x;
    float y;
    float z;
    
    Vec3();
    ~Vec3();
    Vec3(float x, float y, float z);
    //Vec3(const float x, const float y, const float z);
    Vec3(const float *array);
    Vec3(const Vec3 &vec);
    void operator>>(Vec3& vec);
    Vec3 operator-(const Vec3& vec) const;
    void normalize();
    static void cross(const Vec3& lhs, const Vec3& rhs, Vec3& outResult);
};
#endif /* Vec3_hpp */
