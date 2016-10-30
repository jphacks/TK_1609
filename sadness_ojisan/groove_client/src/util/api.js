import Vue from 'vue';
import Resource from 'vue-resource';

Vue.use(Resource)

const API_HOST = "http://localhost:3000/api/v1"

let resource = function(url, options) {
  return Vue.resource(url, null, null, { emulateJSON: true });
}

export default class API {
  static login(email, password){
    return (new Promise((resolve, reject) => {
      resource(`${API_HOST}/login`)
      .save({}, {dancer: {email: email, password: password}})
      .then((data) => {
        if (data.status){
          resolve(data);
        }
      }).catch((reason) => {
        console.log(reason)
      })
    }))
  }

  static getMyInfo(access_token){
    console.log("[API getMyInfo(access_token)] access_token: " + access_token)
    return (new Promise((resolve, reject) => {
      resource(`${API_HOST}/me`).get(null, {headers: {'HTTP_ACCESS_TOKEN': access_token}})
      .then((data) => {
        console.log("[API getMyInfo(access_token)] : access成功")
        resolve(data.data)
      }).catch((data) => {
        console.log("[API getMyInfo(access_token)] : access失敗")
        reject(data);
      })
    }))
  }

  static getDanceList(access_token){
    console.log("[API getDanceList(access_token)] access_token: " + access_token)
    return (new Promise((resolve, reject) => {
      resource(`${API_HOST}/records`).get(null, {headers: {'HTTP_ACCESS_TOKEN': access_token}})
      .then((data) => {
        console.log("[API getDanceList(access_token)] : access成功")
        resolve(data.data)
      }).catch((data) => {
        console.log("[API getDanceList(access_token)] : access失敗")
        reject(data)
      })
    }))
  }

}
