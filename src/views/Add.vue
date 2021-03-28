<template>
  <section>
    <Logo />
    <h1>This is the add page</h1>
  </section>
</template>
<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import Logo from '@/components/common/Logo.vue';

@Component({
  components: {
    Logo,
  },
})
export default class Add extends Vue { }
</script>
