var hosturl = "0.0.0.0";
var wsport = 3100;
var oscport = 8000;

// WebSocket Serverを立ち上げる
var WebSocketServer = require('ws').Server;
var wss = new WebSocketServer({host:hosturl, port:wsport});

// OSC Senderを立ち上げる
var oscsender = require('omgosc').UdpSender;
var sender = new oscsender(hosturl, oscport);

// WebSocketのイベントハンドラ
wss.on('connection', function (ws) {
    ws.on('message', function (message) {
        console.log(message);
        var mes = JSON.parse(message);
        if(mes.osc){    // チェック甘！
                // OSCで送信
            sender.send(mes.path,mes.type,[mes.data]);
        }
    });
});
