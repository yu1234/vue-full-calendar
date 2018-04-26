<template>
    <div class="tb-carousel">
        <div class="carousel-inner" ref="swiperWrap">
            <slot></slot>
        </div>
    </div>
</template>

<script>
    export default {
        name: "tb-swiper",
        mounted: function () {
            this.slideEls = [].map.call(this.$refs.swiperWrap.children, el => el)
        },
        props: {},
        data: function () {
            return {
                slideEls: []
            }
        }
    }
</script>

<style scoped lang="less">
    .tb-carousel {
        position: relative;
        .tb-carousel-inner {
            position: relative;
            overflow: hidden;
            width: 100%;
            /* 默认情况下 .item 元素隐藏*/
            .tb-carousel-inner > .tb-item {
                position: relative;
                display: none;
                transition: transform .6s ease-in-out;
            }

            /* 活动状态的元素才显示 */
            .tb-carousel-inner > .tb-active, .tb-carousel-inner > .tb-next, .tb-carousel-inner > .tb-prev {
                display: block;
            }

            /* 切换状态，显示目标元素 */
            .tb-carousel-inner > .tb-item.tb-active, .tb-carousel-inner > .tb-item.tb-next.tb-left, .tb-carousel-inner > .tb-item.tb-prev.tb-right {
                left: 0;
                transform: translate3d(0, 0, 0);
            }

            /* 切换过程，前后两个元素的过度 */
            .tb-carousel-inner > .tb-item.active.left, .tb-carousel-inner > .tb-item.tb-prev {
                left: 0;
                transform: translate3d(-100%, 0, 0);
            }
            .tb-carousel-inner > .tb-item.active.right, .tb-carousel-inner > .tb-item.next {
                left: 0;
                transform: translate3d(100%, 0, 0);
            }
        }
    }

</style>