import Vue from 'vue';
import Router from 'vue-router';
import Flash from './views/Flash.vue';

Vue.use(Router);

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'flash',
      component: Flash,
    },
    {
      path: '/add',
      name: 'add',
      component: () => import('./views/Add.vue'),
    },
    {
      path: '/list',
      name: 'list',
      component: () => import('./views/List.vue'),
    },
  ],
});
