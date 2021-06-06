//
//  Vector.h
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/6.
//

#ifndef Vector_h
#define Vector_h

class Vector3f{
public:
    float x,y,z;
    
    Vector3f();
    Vector3f(const float a, const float b, const float c);
    ~Vector3f();
    Vector3f& operator=(const Vector3f& vec);
    Vector3f& operator+(const Vector3f& vec);
    Vector3f& operator-(const Vector3f& vec);
    void normalize() const;
};


#endif /* Vector_h */
