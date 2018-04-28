<template>
    <div class="carousel">
        <div class="carousel-inner" ref="carouselInner"
             @touchstart="onTouchStart" @touchmove="onTouchMove"
             @touchend="onTouchEnd" @mousedown="onTouchStart"
             @mousemove="onTouchMove" @mouseup="onTouchEnd">
            <slot></slot>
        </div>
    </div>
</template>

<script>
    const VERTICAL = 'vertical'
    const HORIZONTAL = 'horizontal'
    export default {
        name: "vue-swiper",
        mounted: function () {
            this.slides = [].map.call(this.$children, (el, index) => {
                if (!el) {
                    return
                }
                if (index === 0) {
                    el.show()
                }
                return el
            })
            console.log(this.slides)
        },
        props: {
            direction: {
                type: String,
                default: HORIZONTAL,
                validator: (value) => [VERTICAL, HORIZONTAL].indexOf(value) > -1
            },
            speed: {
                type: Number,
                default: 500
            },
            loop: {
                type: Boolean,
                default: false
            }
        },
        data: function () {
            return {
                slides: [],
                startPos: null,
                startTime: null,
                delta: 0,
                currentSlideIndex: 0,

            }
        },
        methods: {
            isHorizontal: function () {
                return this.direction === HORIZONTAL;
            },
            isVertical: function () {
                return this.direction === VERTICAL;
            },
            getTouchPos: function (e) {
                let key = this.isHorizontal() ? 'pageX' : 'pageY';
                return e.changedTouches ? e.changedTouches[0][key] : e[key];
            },
            onTouchStart: function (e) {
                this.startPos = this.getTouchPos(e);
                this.startTime = new Date().getTime();
                this.transitionDuration = 0;
            },
            onTouchMove: function (e) {
                this.delta = this.getTouchPos(e) - this.startPos
                if (this.isVertical() || this.isHorizontal() && Math.abs(this.delta) > 0) {
                    e.preventDefault();
                }
            },
            onTouchEnd: function () {
                this.dragging = false;
                //this.transitionDuration = this.speed;
                let isQuickAction = new Date().getTime() - this.startTime < 1000
                if (this.delta < -100 || (isQuickAction && this.delta < -15)) {
                    this.next();
                } else if (this.delta > 100 || (isQuickAction && this.delta > 15)) {
                    this.prev();
                } else {
                    this.revert();
                }
            },
            next: function () {
                const {currentSlideIndex, slides} = this
                let slide = currentSlideIndex + 1
                if (slide >= slides.length) {
                    if (this.loop) {
                        this.setSlide(0, currentSlideIndex, 'next')
                    } else {
                        this.revert()
                    }
                } else {
                    this.setSlide(slide, currentSlideIndex, 'next')
                }
            },
            prev: function () {
                const {currentSlideIndex, slides} = this
                let slide = currentSlideIndex - 1
                if (slide < 0) {
                    if (this.loop) {
                        this.setSlide(slides.length - 1, currentSlideIndex, 'prev')
                    } else {
                        this.revert()
                    }
                } else {
                    this.setSlide(slide, currentSlideIndex, 'prev')
                }
            },
            revert: function () {
                //this.setPage(this.currentPage);
            },
            setSlide: function (newSlideIndex, oldSlideIndex, type) {
                const {currentSlideIndex, slides} = this
                if (newSlideIndex >= 0 && newSlideIndex < slides.length && oldSlideIndex >= 0 && oldSlideIndex < slides.length) {
                    let newSlide = slides[newSlideIndex]
                    let oldSlide = slides[oldSlideIndex]
                    oldSlide.setTransition(type)
                    newSlide.setTransition(type)
                    oldSlide.$once('slide-after-leave', (el) => {
                        newSlide.show()
                    })
                    oldSlide.hide()
                    this.currentSlideIndex = newSlideIndex
                    this.$emit(`slider-${type}`, type, newSlideIndex, oldSlideIndex)
                }
            }
        }
    }
</script>

<style scoped lang="less">

    .carousel {
        position: relative;
    }

    .carousel-inner {
        position: relative;
        width: 100%;
        overflow: hidden;
    }
</style>