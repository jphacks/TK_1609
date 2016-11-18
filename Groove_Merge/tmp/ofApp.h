#pragma once


#include "ofMain.h"
#include "ofxHTTP.h"
#include "ofxMaxim.h"


class ofApp: public ofBaseApp
{
public:
    void setup();
    void draw();
    void update();
    
    void onHTTPPostEvent(ofx::HTTP::PostEventArgs& evt);
    void onHTTPFormEvent(ofx::HTTP::PostFormEventArgs& evt);
    void onHTTPUploadEvent(ofx::HTTP::PostUploadEventArgs& evt);
    int postedData;
    int postedData2;
    int cnt;
    ofx::HTTP::SimplePostServer server;
    
    
    void audioOut(float * input, int bufferSize, int nChannels);
    void audioIn(float * input, int bufferSize, int nChannels);
    int initialBufferSize;
    int sampleRate;
    double outputs[2];
    double wave;
    
    maxiSample music;
    ofxMaxiMix mymix; //Mixer
    ofxMaxiOsc car; //FM career /* 波を変えるメソッドたくさん入ってる */
    ofxMaxiOsc mod; //FM modulator
    maxiFilter filter; /* lopassとかのフィルターがたくさん入ってる */
    
    vector <float> lAudio;
    vector <float> rAudio;
    
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

};
