

function Shan()
{
  this.xml = null;
};

Shan.addMethods(

  function init() {
    //reset form for adding characters
    this.resetForm();
  },

/* add character */

  function addCharacter(form) {

    this.xml = tools.initXML("<words/>");
    var characters = form["character"].value;
    var pages = form["page"].value;
    var numbers = form["number"].value;
    var batch = form["batch"].value;
    var pinyin_text = form["pinyin-input"].value;
    var text = form["text"].value;
    var order_string = form["order-string"].value;
    var meaning = form["meaning"].value;

    if (characters == '' || pinyin == '' || meaning == '')
      return false;

    var new_card = this.xml.createElement("word");
    new_card.setAttribute("id", (form["update_id"]) ? form["update_id"].value : new UUID().toString().toLowerCase());

    new_card.setAttribute("batch", batch);

    if (characters.length > 1) {
      var character_node = this.xml.createElement("characters");
      character_node.setAttributeNS("http://www.w3.org/XML/1998/namespace", "xml:lang", "zh-Hans");
      character_node.appendChild(this.xml.createTextNode(characters));
      if (pages != "" && numbers != '') {
        character_node.setAttribute("pages", pages);
        character_node.setAttribute("positions", numbers);
      }
      new_card.appendChild(character_node);
    }
    else {
      var character_node = this.xml.createElement("character");
      character_node.setAttributeNS("http://www.w3.org/XML/1998/namespace", "xml:lang", "zh-Hans");
      character_node.appendChild(this.xml.createTextNode(characters));
      if (pages != "" && numbers != '') {
        character_node.setAttribute("page", pages);
        character_node.setAttribute("position", numbers);
      }
      new_card.appendChild(character_node);
    }

    var pinyin_node = this.xml.createElement("pinyin");
    pinyin_node.setAttributeNS("http://www.w3.org/XML/1998/namespace", "xml:lang", "zh-Latn-x-pinyin");
    pinyin_node.appendChild(this.xml.createTextNode(pinyin.convert(pinyin_text)));
    pinyin_node.setAttribute("order-string", order_string);
    pinyin_node.setAttribute("text", text);

    var meanings_node = this.xml.createElement("meanings");
    for (var name in form) {
      if (name.indexOf("meaning") != -1) {
        var meaning_node = this.xml.createElement("meaning");
        meaning_node.setAttributeNS("http://www.w3.org/XML/1998/namespace", "xml:lang", "en-US");
        meanings_node.appendChild(meaning_node);
        meaning_node.appendChild(this.xml.createTextNode(form[name].value));
      }
    }

    new_card.appendChild(pinyin_node);
    new_card.appendChild(meanings_node);

    var cards = this.xml.documentElement;

    //insert the new card into the xml document
    cards.appendChild(new_card);

    //save the xml
    comm.send("content/add-character.php?file=shan.xml", this.xml, "post");
    //tools.xmlStr(this.xml);

    this.resetForm(form);

    return false;
  },

  function getCharacter(id) {

  },

  function resetForm(form) {
    try {
      if (form) {
        var meaning_el = document.getElementById("meaning");
        meaning_el.appendChild(document.getElementById("add-meaning"));
        meaning_el.className = "form-item with-button";
        var parent = document.getElementById("additional-meanings");
        var el = parent.childNodes[0];
        while (el) {
          parent.removeChild(el);
          el = parent.childNodes[0];
        }

        var fields = ['update_id', 'character', 'sentence-characters', 'character', 'pinyin', 'sentence-text', 'order-string', 'page', 'number', 'batch'];
        for (var name in form) {
          if (tools.inArray(name, fields) || name.indexOf("meaning") != -1) {
            if (name == "update_id") {
              document.getElementById(name).parentNode.removeChild(document.getElementById(name));
              form[name] = null;
            }
            else if (name == "page" || name == "number")
              form[name].value = 0;
            else if (name == "batch")
              form[name].value = document.getElementById(name).getAttribute("max");
            else if (name == "add-meaning")
              continue;
            else
              form[name].value = '';
          }
        }
        document.getElementById("add-sentence-form-title").innerHTML = "Add a Sentence"
        document.getElementById("add-sentence-form-submit-button").innerHTML = "Add";
        document.getElementById("add-form-title").innerHTML = "Add a Character"
        document.getElementById("add-form-submit-button").innerHTML = "Add";
        document.getElementById("meaning-label").innerHTML = "Meaning";
        document.getElementById("pinyin-input").value = '';
        document.getElementById("text-input").value = '';
        document.getElementById("meaning-input").value = '';
        document.getElementById("order_string").value = '';
        document.getElementById("add-focus").value = '';
        document.getElementById("add-focus").focus();
        document.getElementById("page-input").value = '';
        document.getElementById("number-input").value = '';
        document.getElementById("batch").value = document.getElementById("batch").getAttribute("max");
      }
    }
    catch (e) {
      alert(e.message);
    }
  },


  function setPinYinValues(el) {
    var order_string = el.value;
    document.getElementById("order_string").value = order_string;
    var text = pinyin.convert(el.value, true);
    document.getElementById("text-input").value = text;
  },

  function updateValue(evt, input) {
    var minimum = input.getAttribute("minimum", 2) * 1;
    var value = input.value * 1;

    if (evt.keyCode == 38)
      input.value = value + 1;
    if (evt.keyCode == 40)
      input.value = value - 1;
    if (!tools.isNumber(value) || value < minimum)
      input.value = minimum;
  },

  function add_meaning_field(el) {
    var item = el.parentNode;
    if (item.parentNode.getAttribute("id") != "additional-meanings")
      item.className = "form-item";
    else
      item.className = "form-item no-label";

    var newitem = document.createElement("div");
    newitem.className = "form-item no-label with-button";
    var input = document.createElement("input");
    input.setAttribute("type", "text");
    input.className = "meaning-input";
    input.setAttribute("name", "meaning" + new UUID().toString().toLowerCase());

    newitem.appendChild(input);
    newitem.appendChild(el);

    var parent = document.getElementById("additional-meanings");
    document.getElementById("meaning-label").innerHTML = "Meanings";
    parent.appendChild(newitem);
    return false;
  },


  function addSentence(form) {
    this.xml = tools.initXML("<sentences/>");
    var characters = form["sentence-characters"].value;
    var text = form["sentence-text"].value;

    if (characters == '' || text == '')
      return false;

    var new_sentence = this.xml.createElement("sentence");
    new_sentence.setAttribute("id", (form["update_id"]) ? form["update_id"].value : new UUID().toString().toLowerCase());

    var character_node = this.xml.createElement("chinese");
    character_node.setAttributeNS("http://www.w3.org/XML/1998/namespace", "xml:lang", "zh-Hans");
    character_node.appendChild(this.xml.createTextNode(characters));

    var english_node = this.xml.createElement("english");
    english_node.setAttributeNS("http://www.w3.org/XML/1998/namespace", "xml:lang", "en-US");
    english_node.appendChild(this.xml.createTextNode(text));

    new_sentence.appendChild(character_node);
    new_sentence.appendChild(english_node);

    var sentences = this.xml.documentElement;

    //insert the new card into the xml document
    sentences.appendChild(new_sentence);

    //save the xml
    comm.send("content/add-sentence.php?file=shan.xml", this.xml, "post");
    //tools.xmlStr(this.xml);

    this.resetForm(form);

    return false;
  },

  function checkWord(el) 
  {
    if (el.value != '')
      comm.send('content/check-character.php?w=' + el.value, null, 'GET');
    return false;
  }

);


shan = new Shan();

if (window.addEventListener) //Mozilla, etc.
    window.addEventListener("load",function(){shan.init();},false);
else if (window.attachEvent) //IE
    window.attachEvent("onload",function(){shan.init();});