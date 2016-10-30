import Vue from 'vue'
import Header from '../Header/Header.vue';
import SideBar from '../SideBar/SideBar.vue';
import MyPage from '../MyPage/MyPage.vue';

export default {
  components: {
    'page-header': Header,
    'side-bar': SideBar,
    'my-page': MyPage
  },
  vuex: {
    actions: {
    }
  },
  created() {
    console.log("[ROOT] created");
  }
}
