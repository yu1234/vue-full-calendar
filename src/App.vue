<template>
    <div id="app">
       <a @click="addScheduleItem">添加日程</a>
       <schedule></schedule>
        <!--<day-schedule :schedules="scheduleItems" :currentDate="currentDate"></day-schedule>-->
       <!-- <time-line-schedule :schedules="scheduleItems" style="margin: 0 .75rem" :currentDate="currentDate"></time-line-schedule>-->
       <!-- <tb-swiper :loop="true">
            <tb-slide>1</tb-slide>
            <tb-slide>2</tb-slide>
        </tb-swiper>-->
     <!--   <Carousel :loop="true">
            <Slide>1</Slide>
            <Slide>2</Slide>
        </Carousel>-->
       <!-- <vue-swiper :loop="true">
            <vue-slide style="text-align: center">11111111111111111</vue-slide>
            <vue-slide style="text-align: center">22222222222222222</vue-slide>
            <vue-slide style="text-align: center">33333333333333333</vue-slide>
        </vue-swiper>-->
    </div>
</template>

<script>
    import schedule from './components/calendar/calendar'
    import daySchedule from './components/calendar/day-schedule'
    import timeLineSchedule from './components/calendar/time-line-schedule'
    import tbSwiper from './components/swiper/tb-swiper'
    import tbSlide from './components/swiper/tb-slide'
    import { Carousel, Slide } from 'vue-carousel'
    import vueSwiper from './components/vue-swiper/vue-swiper'
    import vueSlide from './components/vue-swiper/vue-slide'
    export default {
        name: 'app',
        components: {
            schedule: schedule,
            'day-schedule': daySchedule,
            'time-line-schedule': timeLineSchedule,
            'tb-swiper':tbSwiper,
            'tb-slide':tbSlide,
            Carousel,
            Slide,
            'vue-swiper':vueSwiper,
            'vue-slide':vueSlide
        },
        data() {
            return {
                scheduleItems: [{
                    startDate: new Date(2018, 3, 18, 10, 30),
                    endDate: new Date(2018, 3, 20, 17, 30),
                    title: '主题1',
                    color: '#222222',
                    content: '22222222222223eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee33333333'
                }, {
                    startDate: new Date(2018, 3, 18, 10, 30),
                    endDate: new Date(2018, 3, 20, 17, 30),
                    title: '主题2',
                    content: '2222222222222333333333'
                }, {
                    startDate: new Date(2018, 3, 18, 12, 0),
                    endDate: new Date(2018, 3, 20, 12, 30),
                    title: '主题3',
                    content: '2222222222222333333333'
                }, {
                    startDate: new Date(2018, 3, 18, 14, 0),
                    endDate: new Date(2018, 3, 18, 17, 30),
                    title: '主题4',
                    content: '2222222222222333333333'
                }, {
                    startDate: new Date(2018, 3, 18, 18, 0),
                    endDate: new Date(2018, 3, 18, 19, 30),
                    title: '主题5',
                    content: '2222222222222333333333'
                }, {
                    startDate: new Date(2018, 3, 19, 3, 30),
                    endDate: new Date(2018, 3, 19, 8, 0),
                    title: '主题6',
                    content: '2222222222222333333333'
                }, {
                    startDate: new Date(2018, 3, 19, 3, 30),
                    endDate: new Date(2018, 3, 19, 8, 0),
                    title: '主题7',
                    content: '2222222222222333333333'
                }],
                currentDate: new Date(2018, 3, 18),
                show:false
            }
        },
        methods: {
            addScheduleItem() {
                let scheduleItem = {
                    startDate: new Date(2018, 3, 18, 3, 30),
                    endDate: new Date(2018, 3, 19, 8, 0),
                    title: '主题三'
                }
                this.scheduleItems.push(scheduleItem)
                this.show=!this.show
            }
        }
    }
</script>

<style>
    #app {
        font-family: 'Avenir', Helvetica, Arial, sans-serif;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
    }

    body, html {
        font-size: 20px;
        padding: 0;
        margin: 0;
    }
</style>
