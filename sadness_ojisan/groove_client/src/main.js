import Vue from 'vue';
import { sync } from 'vuex-router-sync';
import App from './components/App.vue';
import router from './util/router';
import store from './vuex/store';
import $ from 'jquery'
import 'bootstrap';
import 'bootstrap/dist/css/bootstrap.css';
import 'admin-lte';
import 'admin-lte/dist/css/AdminLTE.min.css'
import 'admin-lte/dist/css/skins/skin-green.css'

sync(store, router);
router.start(App, '#app');
