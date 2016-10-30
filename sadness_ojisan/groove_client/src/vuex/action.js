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

export const getDanceList = ({ dispatch }, access_token) => {
  console.log("[ACTION] getDanceList: access_tokenは, " + access_token);
  API.getDanceList(access_token).then((response) => {
    console.log("[ACTION] getDanceList");
    dispatch('GET_DANCE_LIST', response)
  }).catch((reason) => {
    console.log('[ACTION] getDanceList: エラー');
  })
}

export const activateMovie = ({ dispatch }, selected_movie) => {
  console.log("[ACTION] activateMovie")
  dispatch('ACTIVATE_MOVIE', selected_movie);
}
