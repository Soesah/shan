# Shan 2.0

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
- Keep track of trained characters, times, correctness, etc.

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
  Ten words to practice, and the ability to renew the batch, and use a batch.

- Tag words (for grouping, different aspects on words, associations)

## Project setup

```bash
yarn install
```

### Compiles and hot-reloads for development

```bash
yarn run serve
```

### Compiles and minifies for production

```bash
yarn run build
```

### Run your tests

```bash
yarn run test
```

### Lints and fixes files

```bash
yarn run lint
```
