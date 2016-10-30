var url = window.document.location.host.replace(/:.*/, '');
var wsport = 3100;  // WebSocketのPort番号
// WebSocket開始
var wsOsc = {};
wsOsc.ws = new WebSocket('ws://' + url + ':'+wsport);
wsOsc.status = 0;       // 0: 送れる 1: 送れない
wsOsc.ws.onopen = function(){
    wsOsc.status = 1;   // 送れる
};
wsOsc.ws.onclose = function(){
    wsOsc.status = 0;   // 送れない
};
wsOsc.send = function(path,type,data){
    var jsonobj = {"osc":"WsOscSend","path":path,"type":type,"data":data};
    var json = JSON.stringify(jsonobj);

    // 送れれば送る
    if(wsOsc.status){
        wsOsc.ws.send(json);
    }
};

// 送るところ。(jQuery使ってます)
var toggle = 0;
$(function() {
  // iPhone用(てぬき)
    $('#bt1').bind('touchstart', function(event) {
        event.preventDefault();
        // ここで送信。
        wsOsc.send('/osc/button1','i',[toggle]);
        if(toggle == 0){
            toggle = 1;
        }else{
            toggle = 0;
        }
    });
});
