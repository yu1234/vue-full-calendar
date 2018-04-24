<template>
  <div class="mu-avatar">
    <div class="mu-avatar-inner">
      <slot></slot>
    </div>
  </div>
</template>

<script>
export default {
  name: 'mu-avatar',
  props: {
    backgroundColor: {
      type: String,
      default: ''
    },
    size: {
      type: Number
    }
  },
  data: function () {
    return {
      imgSrc: ''
    }
  },
  computed: {
  },
  methods: {
  },
  watch: {
  }
}
</script>

<style lang="less">
.mu-avatar{
  display: inline-block;
  height: 40px;
  width: 40px;
  font-size: 20px;
  color: #ffffff;
  background-color: darken(#ffffff, 26%);
  text-align: center;
  border-radius: 50%;
  img {
    border-radius: 50%;
    width: 100%;
    height: 100%;
    display: block;
  }
}
.mu-avatar-inner{
  display: flex;
  width: 100%;
  height: 100%;
  align-items: center;
  justify-content: center;
}
</style>
