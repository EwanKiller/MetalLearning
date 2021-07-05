//
//  Camera.hpp
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/22.
//

#ifndef Camera_hpp
#define Camera_hpp

#include <stdio.h>
#include "Vec3.hpp"
#include "Mat4.hpp"

class Camera
{
public:
    Vec3 position;
    Vec3 rotation;
    Vec3 scale;
    float fov;
    float aspectRatio;
    float near;
    float far;
    float viewport_X;
    float viewport_Y;
    
    Camera() = delete;
    Camera(const float viewportX, const float viewportY);
    ~Camera();
    
    Mat4 getViewMatrix() const;
    Mat4 getOrthonormalMatrix() const;
    Mat4 getProjectiveMatrix() const;
};
#endif /* Camera_hpp */
