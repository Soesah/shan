<template>
  <section>
    <logo></logo>

    <ul class="characters">
      <li
        class="chinese"
        v-for="word in words"
        :key="word.id"
        :class="{
          'chinese-double': isDouble(word.character.value),
          'chinese-tripple': isTripple(word.character.value),
          'chinese-quadrupple': isQuadrupple(word.character.value),
        }"
      >
        <h2>{{ word.character.value }}</h2>
      </li>
    </ul>
  </section>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import { mapState } from 'vuex';
import Logo from '@/components/common/Logo.vue';

@Component({
  computed: {
    ...mapState(['words']),
  },
  components: {
    Logo,
  },
  async created() {
    this.$store.dispatch('getWords');
  },
  methods: {
    isDouble(characters: string) {
      return characters.length === 2;
    },
    isTripple(characters: string) {
      return characters.length === 3;
    },
    isQuadrupple(characters: string) {
      return characters.length === 4;
    },
  },
})
export default class List extends Vue {}
</script>
