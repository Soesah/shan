class Word {
  constructor({id = null, batch = null, characters = [], pinyin = null, meanings = []}) {
    this.id =  id;
    this.batch =  batch;
    this.characters =  characters;
    this.pinyin =  new Pinyin(pinyin);
    this.meanings =  meanings;
  }
}
