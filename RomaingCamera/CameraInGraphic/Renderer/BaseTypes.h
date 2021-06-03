//
//  BaseTypes.h
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/4.
//

#ifndef BaseTypes_h
#define BaseTypes_h

typedef struct {
    float pX;
    float pY;
    float pZ;
} Position;

typedef struct {
    float rX;
    float rY;
    float rZ;
} Rotation;

typedef struct {
    float sX;
    float sY;
    float sZ;
} Scale;

typedef struct {
    float x;
    float y;
    float z;
} Vector3f;

typedef struct{
    float x;
    float y;
    float z;
    float w;
} Vector4f;

// column matrix
typedef struct {
    float row[4];
} Matrix4f;

typedef struct {
    Matrix4f column[4];
} Matrix4x4f;

#endif /* BaseTypes_h */
