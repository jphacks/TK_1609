import Vue from 'vue'
import Header from '../Header/Header.vue';
import SideBar from '../SideBar/SideBar.vue';

export default {
  components: {
    'page-header': Header,
    'side-bar': SideBar
  },
  created() {
    console.log("[ROOT] created");
  }
}
