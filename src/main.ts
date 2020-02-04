import Vue from 'vue';
import ShanApp from './ShanApp.vue';
import router from './router';
import store from './store';

Vue.config.productionTip = false;

new Vue({
  router,
  store,
  render: (h) => h(ShanApp),
}).$mount('#app');
