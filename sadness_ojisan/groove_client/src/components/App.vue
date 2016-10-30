<template>
    <router-view>
    </router-view>
</template>
<script>
  import store from '../vuex/store';
  import $ from 'jquery';
  export default {
    store
  }
</script>

<style>
html{
  width: 100%;
  height: 100%;
}
body{
  width: 100%;
  height: 100%;
}
#app{
  height: 100%;
  margin: 0;
}
</style>
