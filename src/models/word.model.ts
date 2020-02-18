export interface Word {
  character: Character;
  pinyin: PinYin;
  meanings: Meaning[];
  id: string;
  batch: number;
}

export interface Character {
  page: number;
  position: number;
  value: string;
  lang: string;
}

export interface PinYin {
  order: string;
  text: string;
  value: string;
  lang: string;
}

export interface Meaning {
  lang: string;
  val: string;
}
