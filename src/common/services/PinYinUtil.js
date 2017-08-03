class PinYinUtil {
  constructor() {}

  static get DICTIONARY() {
    return {
        a: ['ā', 'á', 'ǎ', 'à'],
        e: ['ē', 'é', 'ě', 'è'],
        o: ['ō', 'ó', 'ǒ', 'ò'],
        i: ['ī', 'í', 'ǐ', 'ì'],
        u: ['ū', 'ú', 'ǔ', 'ù'],
        v: ['ǖ', 'ǘ', 'ǚ', 'ǜ']
    }
  }

  static toPinyin(text) {
    return this.convert(text);
  }

  static fromPinyin(pinyin) {
    return this.convert(pinyin, true);
  }

  static convert(input, to_text) {
      let output = '';
      for (let i = 0; i < input.length; i++) {
          let isletter = !(input[i] > 0),
              followedbynumber = input[i + 1] && input[i + 1] > 0 ? input[i + 1] * 1 : false,
              letter = input[i];

          if (isletter && followedbynumber && this.DICTIONARY[letter] && !to_text) {
              output += this.DICTIONARY[letter][followedbynumber - 1];
              i++;
          }
          else if (to_text && !isletter)
              continue;
          else
              output += letter;
      }
      return output;
  }
}