<template>
    <transition name="slide" :duration="duration"
                :enter-active-class="enterActiveClass"
                :leave-active-class="leaveActiveClass">
        <div v-show="show" style="width: 100%; flex: 1 1 auto;">
            <slot></slot>
        </div>
    </transition>
</template>

<script>
    export default {
        name: "vue-slide",
        props: {
        },
        data: function () {
            return {
                show: false,
                duration:1000,
                enterActiveClass:'animated',
                leaveActiveClass:'animated'
            }
        },
        methods: {
            onShow: function () {
                this.show = true
            },
            onHide: function () {
                this.show = false
            },
            setTransitionName: function (type) {
                if (type == 'next') {
                    this.enterActiveClass='animated fadeInRightBig'
                    this.leaveActiveClass='animated fadeOutLeftBig'
                } else if (type == 'prev') {
                    this.enterActiveClass='animated fadeInLeftBig'
                    this.leaveActiveClass='animated fadeOutRightBig'
                } else if (type == 'top') {

                } else if (type == 'bottom') {

                }
            }
        }
    }
</script>

<style lang="less">
    .slide-enter-active,
    .slide-leave-active{
        width: 300%;
    }

    /*.slide-right-enter {
        opacity: 0;
        transform: translate3d(-100%, 0, 0);
        -webkit-transform: translate3d(-100%, 0, 0);
    }

    .slide-right-leave-active {
        opacity: 1;
        -webkit-transform: translate3d(100%, 0, 0);
        transform: translate3d(100%, 0, 0);
    }
    .slide-left-enter {
        opacity: 0;
        transform: translate3d(100%, 0, 0);
        -webkit-transform: translate3d(100%, 0, 0);
    }

    .slide-left-leave-active {
        opacity: 1;
        transform: translate3d(-100%, 0, 0);
        -webkit-transform: translate3d(100%, 0, 0);
    }*/
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