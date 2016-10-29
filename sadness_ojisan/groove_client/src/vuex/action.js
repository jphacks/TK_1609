import API from '../util/api.js';

export const login = ({ dispatch }, email, password) => {
  console.log('[ACTION]login')
  console.log('[ACTION] email: ' + email + ', password: ' + password);
  API.login(email, password).then((response) => {
    console.log("[ACTION] login: 成功. mutationに移行");
    dispatch('LOGIN', response)
  }).catch((reason) => {
    console.log('[ACTION] login: エラー');
  })
}

export const getMyInfo = ({ dispatch }, access_token) => {
  console.log("[ACTION] getMyInfo: access_tokenは, " + access_token);
  API.getMyInfo(access_token).then((response) => {
    console.log("[ACTION] getMyInfo");
    dispatch('GET_MY_INFO', response)
  }).catch((reason) => {
    console.log('[ACTION] getMyInfo: エラー');
  })
}
