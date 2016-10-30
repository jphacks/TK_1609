function parse(array){
  console.log('parse関数が実行されました');
  var parsed_json = {
    is_right_left : null, // 左右のデバイスどちらなのか（0,1)
    bpm : null, // BPM(正の整数)
    parm_pressure: null, // 手のひらの圧力センサ（0~1024）
    bending_sensor_oya: null, // 曲げセンサ親指（0~1024）
    bending_sensor_hito: null, // 曲げセンサ人差し指（0~1024）
    bending_sensor_naka: null, // 曲げセンサ中指（0~1024）
    bending_sensor_kusu: null, // 曲げセンサ薬指（0~1024）
    bending_sensor_koyu: null, // 曲げセンサ小指（0~1024）
    acceleration_x: null, // 加速度X（-255~255）
    acceleration_y: null, // 加速度Y（-255~255）
    acceleration_z: null, // 加速度Z（-255~255）
    gyro_x: null, // ジャイロX（-360~360)
    gyro_y: null, // ジャイロY（-360~360）
    gyro_z: null // ジャイロZ（-360~360）
  }
  for(var i=0; i<array.length; i++){
    if(i == 0){
      parsed_json['is_right_left'] = array[i]
    }else if(i == 1){
      parsed_json['bpm'] = array[i]
    }else if(i == 2){
      parsed_json['parm_pressure'] = array[i]
    }else if(i == 3){
      parsed_json['bending_sensor_oya'] = array[i]
    }else if(i == 4){
      parsed_json['bending_sensor_hito'] = array[i]
    }else if(i == 5){
      parsed_json['bending_sensor_naka'] = array[i]
    }else if(i == 6){
      parsed_json['bending_sensor_kusu'] = array[i]
    }else if(i == 7){
      parsed_json['bending_sensor_koyu'] = array[i]
    }else if(i == 8){
      parsed_json['acceleration_x'] = array[i]
    }else if(i == 9){
      parsed_json['acceleration_y'] = array[i]
    }else if(i == 10){
      parsed_json['acceleration_z'] = array[i]
    }else if(i == 11){
      parsed_json['gyro_x'] = array[i]
    }else if(i == 12){
      parsed_json['gyro_z'] = array[i]
    }else if(i == 13){
      parsed_json['gyro_z'] = array[i]
    }
    console.info(array[i])
  }
  return parsed_json
}
