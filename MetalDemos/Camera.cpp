//
//  Camera.cpp
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/22.
//

#include "Camera.h"

Camera::Camera(const float viewportX, const float viewportY):position(Vec3(0.0f,0.0f,0.0f)),rotation(Vec3(0.0f,0.0f,0.0f)),scale(Vec3(1.0f,1.0f,1.0f)),fov(90.0f),aspectRatio(1.0f),near(1.0f),far(500.0f),viewport_X(viewportX),viewport_Y(viewportY)
{
}
Camera::~Camera()
{
}

Mat4 Camera::getViewMatrix() const
{
    Vec3 up(0.0f, 1.0f, 0.0f);
    float angle = rotation.y * (M_PI / 180.0f);
    Vec3 target(std::sin(angle), 0.0f, std::cos(angle));
    Vec3 eyePos(0.0f, 0.0f, 0.0f);
    eyePos.normalize();
    Vec3 lookAt = target - eyePos;
    lookAt.normalize();
    
    Vec3 lookRight;
    Vec3::cross(up, lookAt, lookRight);
    lookRight.normalize();
    
    Vec3 lookUp;
    Vec3::cross(lookAt, lookRight, lookUp);
    lookUp.normalize();
    
    float viewRotateMatrixItems[16] =
    {
        lookRight.x,lookRight.y,lookRight.z,0.0f,
        lookUp.x,lookUp.y,lookUp.z,0.0f,
        lookAt.x,lookAt.y,lookAt.z,0.0f,
        0.0f,0.0f,0.0f,1.0f,
    };
    Mat4 viewRotateMatrix(viewRotateMatrixItems);
    
    float l = position.z / std::cos(angle);
    float x = l * std::sin(angle) + position.x;
    
    float viewTransMatrixItems[16] =
    {
        1.0f,0.0f,0.0f,-x,
        0.0f,1.0f,0.0f,-position.y,
        0.0f,0.0f,1.0f,-position.z,
        0.0f,0.0f,0.0f,1.0f,
    };
    Mat4 viewTranslateMatrix(viewTransMatrixItems);
    
    Mat4 viewMatrix;
    Mat4::multiply(viewTranslateMatrix, viewRotateMatrix, viewMatrix);
    return viewMatrix;
}

Mat4 Camera::getOrthonormalMatrix() const
{
    /** T_ortho 正交投影的frustum的平移矩阵*/
    float halfViewX = viewport_X / 2.0f;
    float halfViewY = viewport_Y / 2.0f;
    float l = -halfViewX + position.x;
    float r = halfViewX + position.x;
    float b = -halfViewY + position.y;
    float t = halfViewY + position.y;
    float orthoTransMatrixItems[16] =
    {
        1.0f,0.0f,0.0f,-(r + l) / 2.0f,
        0.0f,1.0f,0.0f,-(t + b) / 2.0f,
        0.0f,0.0f,1.0f,-near,         // 这里z只平移near的原因是在Metal中，视锥Z方向上的距离是[0,1]而非[-1,1]
        0.0f,0.0f,0.0f,1.0f,
    };
    Mat4 orthoTranslateMatrix(orthoTransMatrixItems);
    /** S_ortho  正交投影的frustum的缩放矩阵*/
    float orthoScaleMatrixItems[16] =
    {
        2.0f / (r - l),0.0f,0.0f,0.0f,
        0.0f,2.0f / (t - b),0.0f,0.0f,
        0.0f,0.0f,1.0f / (far -near),0.0f,  // 这里z只缩放1/(far-near)也是因为视锥Z方向上的距离是[0,1]而非[-1,1]
        0.0f,0.0f,0.0f,1.0f,
    };
    Mat4 orthoScaleMatrix(orthoScaleMatrixItems);
    /** 正交投影的Frustum矩阵*/
    Mat4 orthoProjectionMatrix;
    Mat4::multiply(orthoScaleMatrix, orthoTranslateMatrix, orthoProjectionMatrix);
    return orthoProjectionMatrix;
}

Mat4 Camera::getProjectiveMatrix() const
{
    float height = 1.0f / tanf(fov * 0.5f * (M_PI/180.0f));
    float width = height * aspectRatio;
    float projectiveMatrixItems[16] =
    {
        1.0f/width,0,0,0.0f,
        0.0f,1.0f/height,0,0.0f,
        0.0f,0.0f,far/(far - near),-near*(far/(far-near)),
        0.0f,0.0f,1.0f,0.0f,
    };
    Mat4 projectiveMatrix(projectiveMatrixItems);
    return projectiveMatrix;
}

