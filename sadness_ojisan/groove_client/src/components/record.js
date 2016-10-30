import Vue from 'vue';
import store from '../../vuex/store.js'
  export default {
    props: ['record'],
    components: {
    },
    vuex: {
      getters: {
      },
      actions: {
      }
    },

    created() {
      console.log("[RECORD] creasted")
    }
  }
