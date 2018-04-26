<template>
    <div class="swiper"
         :class="[direction, {'dragging': dragging}]"
         @touchstart="_onTouchStart"
         @mousedown="_onTouchStart"
         @wheel="_onWheel">
        <div class="swiper-wrap" ref="swiperWrap"
             :style="{
                'transform' : 'translate3d(' + translateX + 'px,' + translateY + 'px, 0)',
                'transition-duration': transitionDuration + 'ms'
             }"
             @transitionend="_onTransitionEnd">
            <slot></slot>
        </div>
        <div class="swiper-pagination"
             v-show="paginationVisible">
            <span class="swiper-pagination-bullet"
                  :class="{'active': i+1===currentPage}"
                  v-for="(slide,i) in slideEls" :key="i"
                  @click="paginationClickable && setPage(i+1)"></span>
        </div>
    </div>
</template>
<style lang="less" src="./vue-swiper.less"></style>
<script type="text/babel">
    const VERTICAL = 'vertical';
    const HORIZONTAL = 'horizontal';

    export default {
        props: {
            direction: {
                type: String,
                default: VERTICAL,
                validator: (value) => [VERTICAL, HORIZONTAL].indexOf(value) > -1
            },
            mousewheelControl: {
                type: Boolean,
                default: true
            },
            performanceMode: {
                type: Boolean,
                default: false
            },
            paginationVisible: {
                type: Boolean,
                default: false
            },
            paginationClickable: {
                type: Boolean,
                default: false
            },
            loop: {
                type: Boolean,
                default: false
            },
            speed: {
                type: Number,
                default: 500
            }
        },
        data: function () {
            return {
                currentPage: 1,
                lastPage: 1,
                translateX: 0,
                translateY: 0,
                startTranslate: 0,
                delta: 0,
                dragging: false,
                startPos: null,
                transitioning: false,
                slideEls: [],
                translateOffset: 0,
                transitionDuration: 0
            };
        },
        mounted: function () {
            this._onTouchMove = this._onTouchMove.bind(this);
            this._onTouchEnd = this._onTouchEnd.bind(this);
            this.slideEls = [].map.call(this.$refs.swiperWrap.children, el => el);
            if (this.loop) {
                this.$nextTick(function () {
                    this._createLoop();
                    this.setPage(this.currentPage, true);
                });
            } else {
                this.setPage(this.currentPage);
            }
        },
        updated: function () {
            console.log('updated')
        },
        methods: {
            next: function () {
                var page = this.currentPage;
                if (page < this.slideEls.length) {
                    this.setPage(page + 1);
                } else if (this.loop && page >= this.slideEls.length) {
                    this.setPage(1)
                } else {
                    this._revert();
                }
            },
            prev: function () {
                var page = this.currentPage;
                if (page > 1 || this.loop) {
                    this.setPage(page - 1);
                } else if (this.loop && page <= 1) {
                    this.setPage(this.slideEls.length)
                } else {
                    this._revert();
                }
            },
            setPage: function (page, noAnimation) {
                var self = this;
                this.lastPage = this.currentPage;
                if (page === 0) {
                    this.currentPage = this.slideEls.length;
                } else if (page === this.slideEls.length + 1) {
                    this.currentPage = 1;
                } else {
                    this.currentPage = page;
                }

                if (this.loop) {
                    if (this.delta === 0) {
                        this._setTranslate(self._getTranslateOfPage(this.lastPage));
                    }
                    setTimeout(function () {
                        self._setTranslate(self._getTranslateOfPage(page));
                        if (noAnimation) return;
                        self._onTransitionStart();
                    }, 0);
                } else {
                    this._setTranslate(this._getTranslateOfPage(page));
                    if (noAnimation) return;
                    this._onTransitionStart();
                }
            },
            isHorizontal: function () {
                return this.direction === HORIZONTAL;
            },
            isVertical: function () {
                return this.direction === VERTICAL;
            },
            _onTouchStart: function (e) {
                this.startPos = this._getTouchPos(e);
                this.delta = 0;
                this.startTranslate = this._getTranslateOfPage(this.currentPage);
                this.startTime = new Date().getTime();
                this.dragging = true;
                this.transitionDuration = 0;

                document.addEventListener('touchmove', this._onTouchMove, false);
                document.addEventListener('touchend', this._onTouchEnd, false);
                document.addEventListener('mousemove', this._onTouchMove, false);
                document.addEventListener('mouseup', this._onTouchEnd, false);
            },
            _onTouchMove: function (e) {
                this.delta = this._getTouchPos(e) - this.startPos;

                if (!this.performanceMode) {
                    this._setTranslate(this.startTranslate + this.delta);
                    this.$emit('slider-move', this._getTranslate());
                }

                if (this.isVertical() || this.isHorizontal() && Math.abs(this.delta) > 0) {
                    e.preventDefault();
                }
            },
            _onTouchEnd: function () {
                this.dragging = false;
                this.transitionDuration = this.speed;
                var isQuickAction = new Date().getTime() - this.startTime < 1000;
                if (this.delta < -100 || (isQuickAction && this.delta < -15)) {
                    this.next();
                    this.$emit('slider-next', 'next', this.currentPage);
                } else if (this.delta > 100 || (isQuickAction && this.delta > 15)) {
                    this.prev();
                    this.$emit('slider-prev', 'prev', this.currentPage);
                } else {
                    this._revert();
                }

                document.removeEventListener('touchmove', this._onTouchMove);
                document.removeEventListener('touchend', this._onTouchEnd);
                document.removeEventListener('mousemove', this._onTouchMove);
                document.removeEventListener('mouseup', this._onTouchEnd);
            },
            _onWheel: function (e) {
                if (this.mousewheelControl) {
                    // TODO Support apple magic mouse and trackpad.
                    if (!this.transitioning) {
                        if (e.deltaY > 0) {
                            this.next();
                        } else {
                            this.prev();
                        }
                    }
                    if (this._isPageChanged()) e.preventDefault();

                }
            },
            _revert: function () {
                this.setPage(this.currentPage);
            },
            _getTouchPos: function (e) {
                var key = this.isHorizontal() ? 'pageX' : 'pageY';
                return e.changedTouches ? e.changedTouches[0][key] : e[key];
            },
            _onTransitionStart: function () {
                this.transitioning = true;
                this.transitionDuration = this.speed;
                if (this._isPageChanged()) {
                    this.$emit('slide-change-start', this.currentPage);
                } else {
                    this.$emit('slide-revert-start', this.currentPage);
                }
            },
            _onTransitionEnd: function () {
                this.transitioning = false;
                this.transitionDuration = 0;
                this.delta = 0;
                if (this._isPageChanged()) {
                    this.$emit('slide-change-end', this.currentPage);
                } else {
                    this.$emit('slide-revert-end', this.currentPage);
                }
            },
            _isPageChanged: function () {
                return this.lastPage !== this.currentPage;
            },
            _setTranslate: function (value) {
                var translateName = this.isHorizontal() ? 'translateX' : 'translateY';
                this[translateName] = value;
            },
            _getTranslate: function () {
                var translateName = this.isHorizontal() ? 'translateX' : 'translateY';
                return this[translateName];
            },
            _getTranslateOfPage: function (page) {
                if (page === 0) return 0;

                var propName = this.isHorizontal() ? 'clientWidth' : 'clientHeight';
                return -[].reduce.call(this.slideEls, function (total, el, i) {
                    return i > page - 2 ? total : total + el[propName];
                }, 0) + this.translateOffset;
            },
            _createLoop: function () {
               
            }
        }
    };
</script>
