#pragma once

#include "ofMain.h"
#include "ofxEasyFft.h"
#include "ofxGui.h"
//#include "ofxOsc.h"
//#include "ofxJSONElement.h"
#include "ofxHTTP.h"
#include "Particle.h"

class ofApp : public ofBaseApp{
    
public:
    void setup();
    void update();
    void draw();

    void keyPressed(int key);
    void keyReleased(int key);
    void mouseMoved(int x, int y );
    void mouseDragged(int x, int y, int button);
    void mousePressed(int x, int y, int button);
    void mouseReleased(int x, int y, int button);
    void mouseEntered(int x, int y);
    void mouseExited(int x, int y);
    void windowResized(int w, int h);
    void dragEvent(ofDragInfo dragInfo);
    void gotMessage(ofMessage msg);
    void receiver(string* keyString, string* valueString);

    ofxEasyFft fft; //ofxEasyFft
    ofxPanel gui; //GUI
    ofxFloatSlider saturation;
    ofxButton playPauseBtn;
    
    void onHTTPPostEvent(ofx::HTTP::PostEventArgs& evt);
    void onHTTPFormEvent(ofx::HTTP::PostFormEventArgs& evt);
    void onHTTPUploadEvent(ofx::HTTP::PostUploadEventArgs& evt);
    
    ofx::HTTP::SimplePostServer server;
    
    int accelX = 0;
    int accelY = 0;
    int accelZ = 0;
    int gyroX = 0;
    int gyroY = 0;
    int gyroZ = 0;
    int bendThumb = 0;
    int bendIndex = 0;
    int bendMiddle = 0;
    int bendRing = 0;
    int bendPinkie = 0;
    int leftOrRight = 0;
    int pressureSensor = 0;
    
    int params[13];
    
    //Particle-----------------------------------
    
    // パーティクルクラスをインスタンス化
    vector<Particle> particles;
    // パーティクルの数
    static const int NUM = 1000;
    
    
};
