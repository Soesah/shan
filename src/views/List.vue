<template>
  <section>
    <Logo />

    <ul class="characters">
      <Card v-for="word in words" :key="word.id" :word="word"> </Card>
    </ul>
  </section>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import { mapState } from 'vuex';
import Logo from '@/components/common/Logo.vue';
import Card from '@/components/card/Card.vue';

@Component({
  computed: {
    ...mapState(['words']),
  },
  components: {
    Logo,
    Card,
  },
})
export default class List extends Vue {
  public async created() {
    this.$store.dispatch('getWords');
  }
}
</script>
