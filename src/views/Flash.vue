<template>
  <section>
    <logo></logo>
  </section>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import Logo from '@/components/common/Logo.vue';

@Component({
  components: { Logo },
})
export default class List extends Vue {}
</script>
