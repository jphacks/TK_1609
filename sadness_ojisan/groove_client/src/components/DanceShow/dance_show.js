import Vue from 'vue';
import store from '../../vuex/store.js'

  export default {
    props:['dance'],
    components: {
    },
    vuex: {
      getters: {
        active_movie: state => state.active_movie
      },
      actions: {
      }
    },

    created() {
      console.log("[DanceShow] created")
    }
  }


//.DS_Storemethods: {
  //   greet: function (event) {
  //     // `this` inside methods points to the Vue instance
  //     alert('Hello ' + this.name + '!')
  //     // `event` is the native DOM event
  //     alert(event.target.tagName)
  //   }
  // }
