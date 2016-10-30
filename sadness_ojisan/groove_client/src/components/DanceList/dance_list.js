import Vue from 'vue';
import store from '../../vuex/store.js'
import {getDanceList} from '../../vuex/action.js'
import Dance from '../Dance/Dance.vue'
import DanceShow from '../DanceShow/DanceShow.vue'

  export default {
    components: {
      'dance': Dance,
      'dance-show': DanceShow
    },
    vuex: {
      getters: {
        dance_list: state => state.dance_list
      },
      actions: {
        getDanceList
      }
    },

    created() {
      this.getDanceList(localStorage.access_token)
      console.log("[Dance_LIST] created")
      console.log(this.dance_list)
    }
  }
