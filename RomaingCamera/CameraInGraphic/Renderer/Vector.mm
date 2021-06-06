//
//  Vector.m
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/6.
//

#import <Foundation/Foundation.h>
#import "Vector.h"

Vector3f::Vector3f():x(0),y(0),z(0){ }
Vector3f::Vector3f(float a, float b, float c):x(a),y(b),z(c){ }
Vector3f::~Vector3f(){ }
Vector3f& Vector3f::operator=(const Vector3f &vec)
{
    x = vec.x;
    y = vec.y;
    z = vec.z;
    return *this;
}
Vector3f& Vector3f::operator+(const Vector3f &vec)
{
    x += vec.x;
    y += vec.y;
    z += vec.z;
    return *this;
}
Vector3f& Vector3f::operator-(const Vector3f &vec)
{
    x -= vec.x;
    y -= vec.y;
    z -= vec.z;
    return *this;
}
