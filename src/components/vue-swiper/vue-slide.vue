<template>
    <transition name="slide" :enter-active-class="enterActiveClass" :leave-active-class="leaveActiveClass"
                @after-leave="afterLeave">
        <div class="slide" v-show="slideShow">
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
                slideShow: false,
                enterActiveClass: '',
                leaveActiveClass: ''
            }
        },
        methods: {
            show: function () {
                this.slideShow = true
            },
            hide: function () {
                this.slideShow = false
            },
            setTransition: function (type) {
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
            },
            afterLeave: function (el) {
                this.$emit('slide-after-leave', el)
            }
        }
    }
</script>

<style scoped lang="less">
    .slide {
        position: relative;
        -webkit-box-align: center;
        -ms-flex-align: center;
        align-items: center;
        width: 100%;
    }

    .animated {
        -webkit-animation-duration: .5s;
        animation-duration: .5s;
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