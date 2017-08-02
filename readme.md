#Shan 2.0

You've had the Shan site quite a while now, but it's time for an update to make it more useful. 
Especially being able to display texts with pinyin, to practice pronunciation, would be very good.

The main goals of the app are:

- Flashcards
  - choose a batch to play with (Save in localstorage)
    - LocalStorangeService - to save settings: current batch, used words, current words and state?
    - DailyWordsService - to provide the daily words
  - See 3 cards with a character (or with a meaning)
    - click card to see hint (pinyin)
    - enter a value to see if you are correct
    - turn card around to see meaning
    - english->pinyin/chinese (based on setting, time of day?)
    - chinese/pinyin->english
- Expose you to chinese characters, Pinyin and translation
- Quickly add characters (and make sure you don't add doubles)
- Add chinese texts

- Search
  Search should always be available, and be consistent: you should be able to go back to previous results  
  Items (Character, Text) are clickable and link to their page.
  You should likewise, perhaps, be able to search a word in a text (in a side panel or so)
- Text
  Choose a text, see the chinese, and open pinyin reading dialogs for a paragraph.
- Downloads
  Download PDF files
- About
  Just for fun, why did you make this website?
- Add Character
  A very important feature, but it should be smarter, in helping to give you character numbers
- Daily Words/List
  Twenty words to practice, and the ability to renew the batch, and use a batch.


Problems with the current site:

- Back doesn't work, due to use of XMLHTTP
- Can't search and do something else at the same time.
- Can't deeplink
- Not easy to extend.

Source
http://lava360.com/freebies/99-high-quality-css-and-xhtml-free-templates-and-layouts-part-1/