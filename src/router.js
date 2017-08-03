import VueRouter from 'vue-router';
import DailyWords from 'components/daily-words/DailyWords';
import AddForm from 'components/add-form/AddForm';

const router = new VueRouter({
  routes: [
    {
      path: '/',
      component: DailyWords
    },{
      path: '/add',
      component: AddForm
    }
  ]
});