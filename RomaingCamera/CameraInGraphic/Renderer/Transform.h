//
//  Transform.hpp
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/7.
//

#ifndef Transform_h
#define Transform_h
#import "Vector.h"
#import "Matrix.h"

class AffineTransform
{
    static void Translate(const Vector3f& offset, Vector3f& pos);
    static void RotateAxisX(const float angle, Vector3f& pos);
    static void RotateAxisY(const float angle, Vector3f& pos);
    static void RotateAxisZ(const float angle, Vector3f& pos);
    static void Scale(const Vector3f& factor, Vector3f& pos);
};

#endif /* Transform_hp */
