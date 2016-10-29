import Vue from 'vue'
import Resource from 'vue-resource'
import {login, getMyInfo} from '../../vuex/action.js';
import store from '../../vuex/store.js';
import ApiService from '../../util/api.js'
import VueRouter from 'vue-router';
import API from '../../util/api.js'

const apiService = new ApiService();
Vue.use(VueRouter);
Vue.use(Resource);

export default {
  vuex: {
    actions: {
      login,
      getMyInfo
    }
  },
  data: function () {
     return {
       email: '',
       password: '',
     }
   },
  methods: {
    login_method: function(email, password){
      API.login(email, password).then((data) => {
        console.log("[LOGIN COMPORNENT] data.data.access_token: " + data.data.access_token)
        localStorage.setItem("access_token", data.data.access_token);
        this.getMyInfo(data.data.access_token)
        this.$route.router.go('/');
      })
    }
  },
  created() {
    console.log("[LOGIN COMPORNENT] created");
  }

}
