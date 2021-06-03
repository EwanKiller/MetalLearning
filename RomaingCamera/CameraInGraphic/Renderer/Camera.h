//
//  Camera.h
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/4.
//

#ifndef Camera_h
#define Camera_h
#import "BaseTypes.h"

class Camera{
    
public:
    Camera();
    virtual ~Camera() = 0;
    
private:
    Position position;
    float near;
    float far;
    float aspectRatio;
    float fov;
};

#endif /* Camera_h */
