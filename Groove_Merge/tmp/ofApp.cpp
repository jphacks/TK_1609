#include "ofApp.h"
#include "stdlib.h"


//--------------------------------------------------------------
void ofApp::setup()
{
    ofSetupScreen();
    ofBackground(0, 0, 0);
    ofSetVerticalSync(true);
    
    sampleRate 			= 44100;
    initialBufferSize	= 512;
    lAudio.assign(initialBufferSize, 0.0);
    rAudio.assign(initialBufferSize, 0.0);
    music.load(ofToDataPath("videoplayback18.wav"));
//    music.loadOgg(ofToDataPath("videoplayback.ogg"));
    ofSoundStreamSetup(2,0,this, sampleRate, initialBufferSize, 4);
    
    
    ofSetLogLevel(OF_LOG_NOTICE);
    
    ofSetFrameRate(30);
    
    ofx::HTTP::SimplePostServerSettings settings;
    
    
    settings.setPort(7890);
    settings.setHost("127.0.0.1");
    
    // Apply the settings.
    server.setup(settings);
    
    server.getPostRoute().registerPostEvents(this);
    
        server.start();
    cout <<"server start" << endl;
    
#if !defined(TARGET_LINUX_ARM)
    // Launch a browser with the address of the server.
    ofLaunchBrowser(server.getURL());
#endif
    postedData =3;
    cnt = 0;
    
    
    
}

//--------------------------------------------------------------
void ofApp::update(){
    
}

//--------------------------------------------------------------
void ofApp::draw()
{
}


void ofApp::onHTTPPostEvent(ofx::HTTP::PostEventArgs& args)
{
    
}


void ofApp::onHTTPFormEvent(ofx::HTTP::PostFormEventArgs& args)
{
    ofLogNotice("ofApp::onHTTPFormEvent") << "";
    ofx::HTTP::HTTPUtils::dumpNameValueCollection(args.getForm(), ofGetLogLevel());
    pressureSensor = std::stoi(args.getForm().get("pressureSensor"));
    cout << pressureSensor << endl;
}


void ofApp::onHTTPUploadEvent(ofx::HTTP::PostUploadEventArgs& args)
{

}

void ofApp::audioOut 	(float * output, int bufferSize, int nChannels){
    for (int i = 0; i < bufferSize; i++){
        float index, modFreq;
//        modFreq = ofMap(pressureSensor, 0, 255, 1, 30);
        modFreq = ofMap(pressureSensor, 0, 255, 0, 1);
//        cout << "modfre1: " << modFreq << endl;
        float tmp = music.play(1);
//        wave = car.sinewave(filter.hipass(tmp, modFreq)*modFreq*440);
//        wave = filter.hipass(tmp, modFreq);
//        wave = car.sinewave(tmp*modFreq*240);
        wave = filter.hipass(tmp, modFreq);
        
        lAudio[i] = output[i*nChannels    ] = wave;
        rAudio[i] = output[i*nChannels + 1] = tmp;
        
    }
}

void ofApp::audioIn(float * input, int bufferSize, int nChannels){
    for (int i = 0; i < bufferSize; i++){
        
    }
    
}
