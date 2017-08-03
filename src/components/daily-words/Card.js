import _ from 'Lodash';

let Card = Vue.component('card', {
  template: `<section class="card">
              <h2 class="chinese">{{characters}}</h2>
              <p class="pinyin">{{word.pinyin.pinyin}}</p>
            </section>`,
  props: {
    word: {
      type: Object
    }
  },
  data() {
    return {
      showhint: false,
      answer: ''
    };
  },
  computed: {
    characters() {
      return _.map(this.word.characters, function(char) {
        return char.text;
      }).join('');
    }
  },
  methods: {
    toggleHint() {
      this.showhint = !this.showhint;
    }
  }
});