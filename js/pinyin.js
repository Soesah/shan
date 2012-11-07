/*
* convert a string to pinyin, using the number notation for the tones
*/

function PinYin() {
    this.dictionary = {
        a: ['ā', 'á', 'ǎ', 'à'],
        e: ['ē', 'é', 'ě', 'è'],
        o: ['ō', 'ó', 'ǒ', 'ò'],
        i: ['ī', 'í', 'ǐ', 'ì'],
        u: ['ū', 'ú', 'ǔ', 'ù'],
        v: ['ǖ', 'ǘ', 'ǚ', 'ǜ']
    }
}

PinYin.addMethods(

  function init() {
  },

  function convert(input, to_text) {
      var output = '';
      for (var i = 0; i < input.length; i++) {
          var isletter = !(input[i] > 0);
          var followedbynumber = (input[i + 1] && (input[i + 1] > 0)) ? (input[i + 1] * 1) : false;
          var letter = input[i];

          if (isletter && followedbynumber && this.dictionary[letter] && !to_text) {
              output += this.dictionary[letter][followedbynumber - 1];
              i++;
          }
          else if (to_text && !isletter)
              output = output;
          else
              output += letter;
      }
      return output;
  },

  function message(string) {
      var li = document.createElement('li');
      li.appendChild(document.createTextNode(string));
      document.getElementById('output-messages').appendChild(li);
  }

)

var pinyin = new PinYin();

if (window.addEventListener) //Mozilla, etc.
    window.addEventListener("load", function() { pinyin.init(); }, false);
else if (window.attachEvent) //IE
    window.attachEvent("onload", function() { pinyin.init(); });
    


