import Vue from 'vue';
import store from '../../vuex/store.js'
import {activateMovie} from '../../vuex/action.js'

  export default {
    props:['dance'],
    components: {
    },
    vuex: {
      getters: {

      },
      actions: {
        activateMovie
      }
    },

    created() {
      console.log("[Dance] created")
    },
    methods: {
      activateMovieMethod: function (dance) {
        console.log("[activateMovieMethod]")
        this.activateMovie(dance);
    }
  }
}
