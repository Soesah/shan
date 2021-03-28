<template>
  <li
    class="chinese"
    :class="{
      'chinese-double': isDouble(),
      'chinese-tripple': isTripple(),
      'chinese-quadrupple': isQuadrupple(),
    }"
  >
    <h2>{{ word.character.value }}</h2>
    <!-- <p>{{ word.pinyin.value }}</p> -->
  </li>
</template>

<script lang="ts">
import { Word } from '@/models/word.model';
import { Component, Prop, Vue } from 'vue-property-decorator';

@Component
export default class Card extends Vue {
  @Prop()
  public word!: Word;

  public isDouble(): boolean {
    return this.word.character.value.length === 2;
  }

  public isTripple(): boolean {
    return this.word.character.value.length === 3;
  }

  public isQuadrupple(): boolean {
    return this.word.character.value.length === 4;
  }
}
</script>

<style scoped>
</style>
