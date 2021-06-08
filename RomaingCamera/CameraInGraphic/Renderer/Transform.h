//
//  Transform.hpp
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/7.
//

#ifndef Transform_h
#define Transform_h
#include "Vector.h"
#include "Matrix.h"

class AffineTransform
{
public:
    static void Translate(const Vector3f& offset, Vector3f& pos);
    static void RotateAxisX(const float angle, Vector3f& pos);
    static void RotateAxisY(const float angle, Vector3f& pos);
    static void RotateAxisZ(const float angle, Vector3f& pos);
    static void Scale(const Vector3f& factor, Vector3f& pos);
};

#endif /* Transform_hp */
