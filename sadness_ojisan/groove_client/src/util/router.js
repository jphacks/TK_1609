import Vue from 'vue';
import VueRouter from 'vue-router';
import Root from '../components/Root/Root.vue';
import Login from '../components/Login/Login.vue';

Vue.use(VueRouter);
const router = new VueRouter();

router.map({
  '/': {
    component: Root
  },
  '/login': {
    component: Login
  }
})

export default router;
