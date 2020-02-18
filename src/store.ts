import Vue from 'vue';
import Vuex from 'vuex';
import wordsService from '@/services/words.service';
import { Word } from './models/word.model';

Vue.use(Vuex);

interface ShanState {
  words: Word[];
  notifications: any[];
}

export default new Vuex.Store<ShanState>({
  state: {
    words: [],
    notifications: [],
  },
  mutations: {
    setWords(state: ShanState, words: Word[]) {
      state.words = words;
    },
    showNotification(state: ShanState, notification) {
      state.notifications = [...state.notifications, notification];
    },
    removeNotification(state: ShanState, uuid: string) {
      state.notifications = state.notifications.filter((n) => n.uuid !== uuid);
    },
  },
  actions: {
    getWords: async ({ commit }) => {
      const res = await wordsService.load();

      if (res.status) {
        commit('setWords', res.data);
      } else {
        commit('showNotification');
      }
    },
  },
});
