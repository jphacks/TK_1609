import Vue from 'vue'
import store from '../../vuex/store.js';
  export default {
    components: {

    },
    vuex: {
      getters: {
        me: state => state.me
      },
      actions: {
      }
    },

    created() {
      console.log("[SIDEBAR] headerComponent created");
    }
  }
