<template>
    <transition name="slide" :duration="duration"
                :enter-active-class="enterActiveClass"
                :leave-active-class="leaveActiveClass"
                v-on:before-enter="beforeEnter"
                v-on:after-leave="afterLeave">
        <div v-show="show" class="slide">
            <slot></slot>
        </div>
    </transition>
</template>

<script>
    export default {
        name: "vue-slide",
        props: {},
        data: function () {
            return {
                show: false,
                duration: 1000,
                enterActiveClass: 'animated',
                leaveActiveClass: 'animated'
            }
        },
        methods: {
            beforeEnter: function () {

            },
            afterLeave: function () {
            },
            onShow: function () {
                this.show = true
            },
            onHide: function () {
                this.show = false
            },
            setTransitionName: function (type) {
                this.enterActiveClass = ''
                this.leaveActiveClass = ''
                if (type == 'next') {
                    this.enterActiveClass = 'animated fadeInRightBig'
                    this.leaveActiveClass = 'animated fadeOutLeftBig'
                } else if (type == 'prev') {
                    this.enterActiveClass = 'animated fadeInLeftBig'
                    this.leaveActiveClass = 'animated fadeOutRightBig'
                } else if (type == 'top') {

                } else if (type == 'bottom') {

                }
            }
        }
    }
</script>

<style lang="less">
    .slide {
        overflow: hidden;
        flex-shrink: 0;
        width: 100%;
        height: 100%;
    }
    .animated {
        -webkit-animation-duration: 1s;
        animation-duration: 1s;
        -webkit-animation-fill-mode: both;
        animation-fill-mode: both;
    }

    @-webkit-keyframes fadeOutLeftBig {
        from {
            opacity: 1;
        }

        to {
            opacity: 0;
            -webkit-transform: translate3d(-100%, 0, 0);
            transform: translate3d(-100%, 0, 0);
        }
    }

    @keyframes fadeOutLeftBig {
        from {
            opacity: 1;
        }

        to {
            opacity: 0;
            -webkit-transform: translate3d(-100%, 0, 0);
            transform: translate3d(-100%, 0, 0);
        }
    }

    .fadeOutLeftBig {
        -webkit-animation-name: fadeOutLeftBig;
        animation-name: fadeOutLeftBig;
    }

    @-webkit-keyframes fadeInLeftBig {
        from {
            opacity: 0;
            -webkit-transform: translate3d(-100%, 0, 0);
            transform: translate3d(-100%, 0, 0);
        }

        to {
            opacity: 1;
            -webkit-transform: none;
            transform: none;
        }
    }

    @keyframes fadeInLeftBig {
        from {
            opacity: 0;
            -webkit-transform: translate3d(-100%, 0, 0);
            transform: translate3d(-100%, 0, 0);
        }

        to {
            opacity: 1;
            -webkit-transform: none;
            transform: none;
        }
    }

    .fadeInLeftBig {
        -webkit-animation-name: fadeInLeftBig;
        animation-name: fadeInLeftBig;
    }

    @-webkit-keyframes fadeInRightBig {
        from {
            opacity: 0;
            -webkit-transform: translate3d(100%, 0, 0);
            transform: translate3d(100%, 0, 0);
        }

        to {
            opacity: 1;
            -webkit-transform: none;
            transform: none;
        }
    }

    @keyframes fadeInRightBig {
        from {
            opacity: 0;
            -webkit-transform: translate3d(100%, 0, 0);
            transform: translate3d(100%, 0, 0);
        }

        to {
            opacity: 1;
            -webkit-transform: none;
            transform: none;
        }
    }

    .fadeInRightBig {
        -webkit-animation-name: fadeInRightBig;
        animation-name: fadeInRightBig;
    }

    @-webkit-keyframes fadeOutRightBig {
        from {
            opacity: 1;
        }

        to {
            opacity: 0;
            -webkit-transform: translate3d(100%, 0, 0);
            transform: translate3d(100%, 0, 0);
        }
    }

    @keyframes fadeOutRightBig {
        from {
            opacity: 1;
        }

        to {
            opacity: 0;
            -webkit-transform: translate3d(100%, 0, 0);
            transform: translate3d(100%, 0, 0);
        }
    }

    .fadeOutRightBig {
        -webkit-animation-name: fadeOutRightBig;
        animation-name: fadeOutRightBig;
    }

</style>