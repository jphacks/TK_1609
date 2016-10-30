#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
    params = [accelX, accelY, accelZ, bendIndex, bendMiddle, bendRing, bendThumb, gyroX, gyroY, gyroZ, leftOrRight, pressureSensor];
    ofSetLogLevel(OF_LOG_NOTICE);
    
    ofx::HTTP::SimplePostServerSettings settings;
    settings.setPort(7890);
    
    ofSetFrameRate(30);
    //ofSetVerticalSync(true);
    //ofBackground(0);
    fft.setup(pow(2.0, 12.0));
    
    server.setup(settings);
    server.getPostRoute().registerPostEvents(this);

    server.start();

    #if !defined(TARGET_LINUX_ARM)
        // Launch a browser with the address of the server.
        ofLaunchBrowser(server.getURL());
    #endif
    //GUI
    gui.setup();
    gui.add(saturation.setup("Saturation", 127, 0, 255));
    gui.add(playPauseBtn.setup("Play"));
    //playPauseBtn.addListener(this, &myofxFFTBasicSketch::playPauseBtnPressed);
}

//--------------------------------------------------------------
void ofApp::update(){
    
    
    fft.update();
}

//--------------------------------------------------------------
void ofApp::draw(){

    vector<float> buffer;
    buffer = fft.getBins();
    
    //„Ç∞„É©„Éï„Å´ÊèèÁîª
    ofPushMatrix();
    ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
    ofSetLineWidth(ofGetWidth() / float(buffer.size()));
    ofEnableBlendMode(OF_BLENDMODE_ADD);
    
    for (int j = 0; j < 2; j++) {
        for (int i = 0; i < buffer.size(); i++) {
            //Ëâ≤„ÇíË®≠ÂÆö
            float hue = ofMap(i, 0, buffer.size(), 0, 160);
            float br = ofMap(buffer[i], 0, 1, 0, 255);
            ofColor col;
            col.setHsb(hue, saturation, br);
            ofSetColor(col);
        
            //Âè≥
            float rx = ofMap(i, 0, buffer.size(), 0, ofGetWidth() / 2.0);
            ofLine(rx, -ofGetHeight() / 2.0, rx, ofGetWidth() / 2.0);
        
            float lx = ofMap(i, 0, buffer.size(), 0, -ofGetWidth() / 2.0);
            ofLine(lx, -ofGetHeight() / 2.0, lx, ofGetWidth() / 2.0);
        }
        ofRotateZ(90);
    }
    ofPopMatrix();
    gui.draw();
}

void ofApp::onHTTPPostEvent(ofx::HTTP::PostEventArgs& args)
{
    ofLogNotice("ofApp::onHTTPPostEvent") << "Data: " << args.getBuffer().getText();
}


void ofApp::onHTTPFormEvent(ofx::HTTP::PostFormEventArgs& args)
{
    ofLogNotice("ofApp::onHTTPFormEvent") << "";
    ofx::HTTP::HTTPUtils::dumpNameValueCollection(args.getForm(), ofGetLogLevel());
}


void ofApp::onHTTPUploadEvent(ofx::HTTP::PostUploadEventArgs& args)
{
    std::string stateString = "";
    
    switch (args.getState())
    {
        case ofx::HTTP::PostUploadEventArgs::UPLOAD_STARTING:
            stateString = "STARTING";
            break;
        case ofx::HTTP::PostUploadEventArgs::UPLOAD_PROGRESS:
            stateString = "PROGRESS";
            break;
        case ofx::HTTP::PostUploadEventArgs::UPLOAD_FINISHED:
            stateString = "FINISHED";
            break;
    }
    
    ofLogNotice("ofApp::onHTTPUploadEvent") << "";
    ofLogNotice("ofApp::onHTTPUploadEvent") << "         state: " << stateString;
    ofLogNotice("ofApp::onHTTPUploadEvent") << " formFieldName: " << args.getFormFieldName();
    ofLogNotice("ofApp::onHTTPUploadEvent") << "orig. filename: " << args.getOriginalFilename();
    ofLogNotice("ofApp::onHTTPUploadEvent") <<  "     filename: " << args.getFilename();
    ofLogNotice("ofApp::onHTTPUploadEvent") <<  "     fileType: " << args.getFileType().toString();
    ofLogNotice("ofApp::onHTTPUploadEvent") << "# bytes xfer'd: " << args.getNumBytesTransferred();
}

public void receiver(string keyString, string valueString) {
    
}
//--------------------------------------------------------------
void ofApp::keyPressed(int key){
    
}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
