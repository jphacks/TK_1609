import Vue from 'vue';
import store from '../../vuex/store.js'
import RecordList from '../RecordList/RecordList.vue'
import {getMyInfo} from '../../vuex/action.js'

  export default {
    components: {
      'record-list': RecordList
    },
    vuex: {
      getters: {
        me: state => state.me
      },
      actions: {
        getMyInfo
      }
    },

    created() {
      console.log("[MYPAGE] localStorage.access_token: " + localStorage.access_token)
      this.getMyInfo(localStorage.access_token)
      console.log("[MYPAGE] created")
    }
  }
