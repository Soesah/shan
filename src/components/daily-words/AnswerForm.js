import PinYinUtil from '/common/services/PinYinUtil';

let AnswerForm = Vue.component('answer-form', {
  template: `<form class="answer-form">
               <p>What is the meaning of this word?</p>
               <input v-model="answer" v-pinyin/>
             </form>`,
  data() {
    return {
      answer: ''
    };
  },
  directives: {
    pinyin(el) {
      // converts the input value to pinyin 
      // when written with the number system
      el.addEventListener('blur', function() {
        el.value = PinYinUtil.toPinyin(el.value);
      });
    }
  }
});