//
//  main.cpp
//  MultiThread
//
//  Created by ThisEwan on 2021/6/29.
//

#include <iostream>
#include <thread>

void renderThreadLog() noexcept
{
    std::cout << "render thread " << std::endl;
}


int main(int argc, const char * argv[]) {
    
    std::thread renderThread(renderThreadLog);
    renderThread.detach();
    // insert code here...
    std::cout << "Hello, World!\n";
    return 0;
}
