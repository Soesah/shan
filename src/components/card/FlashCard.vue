<template>
  <section class="flash-card"></section>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';

@Component
export default class FlashCard extends Vue {

}
</script>

<style scoped lang="less">
@import '../../css/less/variables.less';
@import '../../css/less/colors.less';

.flash-card {
  margin: 0 auto;
  box-shadow: 2px 2px 6px @color-sand-dark;
  border-radius: @border-radius;
  width: 400px;
  height: 600px;
}

@media screen and (max-width: 600px) {
  .flash-card {
    max-width: 80%;
    max-height: 80%;
  }
}
</style>
