//
//  Matrix.m
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/4.
//

#import <Foundation/Foundation.h>
#include "Matrix.h"

Matrix4f Matrix::vec3f2Matrix4f(Vector3f pos){
    
    Matrix4f mat;
    
    mat.row[0] = pos.x;
    mat.row[1] = pos.y;
    mat.row[2] = pos.z;
    mat.row[3] = 1.0;
    
    return mat;
}
Matrix4x4f translateMatrix(Vector3f t){
    
    Matrix4x4f mat;
    
    mat.column[0].row[0] = 1.0;
    mat.column[0].row[1] = 0.0;
    mat.column[0].row[2] = 0.0;
    mat.column[0].row[3] = t.x;
    
    mat.column[1].row[0] = 0.0;
    mat.column[1].row[1] = 1.0;
    mat.column[1].row[2] = 0.0;
    mat.column[1].row[3] = t.y;
    
    mat.column[2].row[0] = 0.0;
    mat.column[2].row[1] = 0.0;
    mat.column[2].row[2] = 1.0;
    mat.column[2].row[3] = t.z;
    
    mat.column[3].row[0] = 0.0;
    mat.column[3].row[1] = 0.0;
    mat.column[3].row[2] = 0.0;
    mat.column[3].row[3] = 1.0;
    
    return mat;
}
Matrix4x4f scaleMatrix(Vector3f s){
    
    Matrix4x4f mat;
    
    mat.column[0].row[0] = s.x;
    mat.column[0].row[1] = 0.0;
    mat.column[0].row[2] = 0.0;
    mat.column[0].row[3] = 0.0;
    
    mat.column[1].row[0] = 0.0;
    mat.column[1].row[1] = s.y;
    mat.column[1].row[2] = 0.0;
    mat.column[1].row[3] = 0.0;
    
    mat.column[2].row[0] = 0.0;
    mat.column[2].row[1] = 0.0;
    mat.column[2].row[2] = s.z;
    mat.column[2].row[3] = 0.0;
    
    mat.column[3].row[0] = 0.0;
    mat.column[3].row[1] = 0.0;
    mat.column[3].row[2] = 0.0;
    mat.column[3].row[3] = 1.0;
    
    return mat;
}
Matrix4x4f rotateMatrixAxisX(float angle){
    
    Matrix4x4f mat;
    
    mat.column[0].row[0] = 1.0;
    mat.column[0].row[1] = 0.0;
    mat.column[0].row[2] = 0.0;
    mat.column[0].row[3] = 0.0;
    
    mat.column[1].row[0] = 0.0;
    mat.column[1].row[1] = std::cos(angle);
    mat.column[1].row[2] = std::sin(angle);
    mat.column[1].row[3] = 0.0;
    
    mat.column[2].row[0] = 0.0;
    mat.column[2].row[1] = -std::sin(angle);
    mat.column[2].row[2] = std::cos(angle);
    mat.column[2].row[3] = 0.0;
    
    mat.column[3].row[0] = 0.0;
    mat.column[3].row[1] = 0.0;
    mat.column[3].row[2] = 0.0;
    mat.column[3].row[3] = 1.0;
    
    return mat;
}
Matrix4x4f rotateMatrixAxisY(float angle){
    
    Matrix4x4f mat;
    
    mat.column[0].row[0] = std::cos(angle);
    mat.column[0].row[1] = 0.0;
    mat.column[0].row[2] = -std::sin(angle);
    mat.column[0].row[3] = 0.0;
    
    mat.column[1].row[0] = std::sin(angle);
    mat.column[1].row[1] = 1.0;
    mat.column[1].row[2] = std::cos(angle);
    mat.column[1].row[3] = 0.0;
    
    mat.column[2].row[0] = 0.0;
    mat.column[2].row[1] = 0.0;
    mat.column[2].row[2] = 1.0;
    mat.column[2].row[3] = 0.0;
    
    mat.column[3].row[0] = 0.0;
    mat.column[3].row[1] = 0.0;
    mat.column[3].row[2] = 0.0;
    mat.column[3].row[3] = 1.0;
    
    return mat;
}
Matrix4x4f rotateMatrixAxisZ(float angle){
    
    Matrix4x4f mat;
    
    mat.column[0].row[0] = std::cos(angle);
    mat.column[0].row[1] = std::sin(angle);
    mat.column[0].row[2] = 0.0;
    mat.column[0].row[3] = 0.0;
    
    mat.column[1].row[0] = -std::sin(angle);
    mat.column[1].row[1] = std::cos(angle);
    mat.column[1].row[2] = 0.0;
    mat.column[1].row[3] = 0.0;
    
    mat.column[2].row[0] = 0.0;
    mat.column[2].row[1] = 0.0;
    mat.column[2].row[2] = 1.0;
    mat.column[2].row[3] = 0.0;
    
    mat.column[3].row[0] = 0.0;
    mat.column[3].row[1] = 0.0;
    mat.column[3].row[2] = 0.0;
    mat.column[3].row[3] = 1.0;
    
    return mat;
}
Matrix4x4f rotateMatrix(float angle,Vector3f Axis){
    
    Matrix4x4f mat;
    
    
    
    return mat;
}

