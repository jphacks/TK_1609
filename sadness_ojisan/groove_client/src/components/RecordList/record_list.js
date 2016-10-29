import Vue from 'vue';
import store from '../../vuex/store.js'
import Record from '../Record/Record.vue'
  export default {
    props: ['records'],
    components: {
      'record': Record
    },
    vuex: {
      getters: {
      },
      actions: {
      }
    },

    created() {
      console.log("[RECORD_LIST] records: " + this.records)
      console.log("[RECORD_LIST] created")
    }
  }
