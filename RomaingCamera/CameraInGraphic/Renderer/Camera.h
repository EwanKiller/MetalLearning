//
//  Camera.hpp
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/7.
//

#ifndef Camera_h
#define Camera_h

#include "Vector.h"

class Camera
{
public:
    Vector3f position;
    Vector3f rotation;
    Vector3f scale;
    float fov;
    float aspectRatio;
    float near;
    float far;
    
    Camera();
    ~Camera();
    Matrix4x4f getViewMatrix(const Vector3f& offset, const Vector3f& target, const Vector3f& up) const;
};

#endif /* Camera_h */
