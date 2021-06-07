//
//  Vector.h
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/6.
//

#ifndef Vector_h
#define Vector_h
#include <iostream>
#include "Matrix.h"
using namespace::std;

class Vector3f{
public:
    float x,y,z;
    
    Vector3f();
    Vector3f(const Vector3f &vec);
    Vector3f(const float a, const float b, const float c);
    ~Vector3f();
    Vector3f& operator=(const Vector3f& vec);
    Vector3f operator+(const Vector3f& vec) const;
    Vector3f operator-(const Vector3f& vec) const;
    void normalize();
    static void cross(const Vector3f& lhs, const Vector3f& rhs, Vector3f& outResult);
};


#endif /* Vector_h */
