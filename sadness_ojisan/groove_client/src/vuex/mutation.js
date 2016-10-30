export default {
  LOGIN(state, my_info){
    console.log('[MUTATIONS]Called LOGIN');
    console.log(my_info);
    state.access_token = my_info.data.access_token;
    console.log('[MUTATIONS] state.access_token = ' + state.access_token);
    state.my_id = my_info.data.data.id;
    console.log('[MUTATIONS] state.my_id = ' + state.my_id);
    state.is_login = true;
    localStorage.setItem("access_token", state.access_token);
  },

  GET_MY_INFO(state, my_info){
    console.log('[MUTATIONS]Called GET_MY_INFO: ' + my_info);
    console.log(my_info.data);
    state.me = my_info.data;
    console.log('[MUTATIONS] state.me: ' + state.me);
  },

  GET_DANCE_LIST(state, dance_list){
    console.log('[MUTATIONS]Called GET_DANCE_LIST: ' + dance_list);
    console.log(dance_list);
    state.dance_list = dance_list;
    console.log('[MUTATIONS] state.dance_list: ' + state.dance_list);
    console.info(state.dance_list);
  },

  ACTIVATE_MOVIE(state, dance){
    console.log('[MUTATIONS]Called ACTIVATE_MOVIE: ' + dance);
    console.log(dance);
    state.active_movie = dance
  }
}
