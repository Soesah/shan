import Card from 'Card';
import AnswerForm from 'AnswerForm';

let DailyWords = Vue.component('daily-words', {
  template: `<section class="daily-words">
              <p>Take a look at the card and provide the answer-form to continue to the next card.</p>
              <answer-form></answer-form>
              <div class="cards">
                <card v-for="word in words" :word="word" :key="word.id"/>
              </div>
            </section>`,
  data() {
    return {
      words: []
    };
  },
  created() {
    let _this = this;
    this.$http.get('words').then(function(response) {
      _this.words = response.data.data;
    });
  },
  components: {
    card: Card,
    'answer-form': AnswerForm
  }
});