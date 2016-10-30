import Vue from 'vue'
import Header from '../Header/Header.vue';
import SideBar from '../SideBar/SideBar.vue';
import MyPage from '../MyPage/MyPage.vue';
import DanceList from '../DanceList/DanceList.vue';

export default {
  components: {
    'page-header': Header,
    'side-bar': SideBar
  },
  vuex: {
    actions: {
    }
  },
  created() {
    console.log("[ROOT] created");
  }
}
