<template>
  <section>
    <Logo />
    <FlashCard />
  </section>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import Logo from '@/components/common/Logo.vue';
import FlashCard from '@/components/card/FlashCard.vue';

@Component({
  components: {
    Logo,
    FlashCard,
  },
})
export default class Flash extends Vue { }
</script>
