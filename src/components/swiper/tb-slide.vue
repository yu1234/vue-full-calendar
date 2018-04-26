<template>
    <div :class="slideClass">
        <slot></slot>
    </div>
</template>

<script>
    export default {
        name: "vue-slide",
        props: {
            slideClass: {
                type: String,
                default: 'swiper-slide'
            }
        }
    }
</script>

<style scoped lang="less">
    .tb-item {
        position: relative;
        display: none;
        transition: transform .6s ease-in-out;
    }
</style>