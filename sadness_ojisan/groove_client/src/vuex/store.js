// store.js
import Vue from 'vue';
import Vuex from 'vuex';
import mutations from './mutation';

Vue.use(Vuex);

const state = {
  my_id: null,
  is_login: false,
  access_token: null,
  me: null
};

export default new Vuex.Store({
  state,
  mutations
});
