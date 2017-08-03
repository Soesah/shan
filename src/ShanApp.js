import Vue from 'Vue';
import router from 'Router';
import axios from 'Axios';

Vue.prototype.$http = axios;

new Vue({
  el: '#root',
  router
})
