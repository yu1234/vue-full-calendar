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

<style scoped>

</style>