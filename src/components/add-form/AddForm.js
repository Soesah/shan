let AddForm =  {
  template: `<form class="add">
              <h2>Add a word</h2>
              <div class="form-item">
                <label>Character</label>
                <input type="text" v-model="characters"/>
              </div>
            </form>`,
  data() {
    return {
      word: {
        characters: '',
        pinyin: {
          text: ''
        },
        meanings: []
      }
    };
  }
};