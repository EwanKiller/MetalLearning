//
//  Matrix.h
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/4.
//

#ifndef Matrix_h
#define Matrix_h

#import "BaseTypes.h"

class Matrix{
    
public:
    static Matrix4f vec3f2Matrix4f(Vector3f vec3f);
    
    Matrix4x4f operator*(const Matrix4x4f& matrix) const;
    
    static Matrix4x4f translateMatrix(Vector3f vec3f);
    
    static Matrix4x4f scaleMatrix(Vector3f vec3f);
    
    static Matrix4x4f rotateMatrixAxisX(float angle);
    
    static Matrix4x4f rotateMatrixAxisY(float angle);
    
    static Matrix4x4f rotateMatrixAxisZ(float angle);
    
    static Matrix4x4f rotateMatrix(float angle,Vector3f Axis);
};
#endif /* Matrix_h */
