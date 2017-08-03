import Vue from 'Vue';
import axios from 'Axios';
import router from 'Router';

Vue.prototype.$http = axios;

new Vue({
  el: '#root',
  router
})
