<template>
    <div id="app">
        <!-- <a @click="addScheduleItem">添加日程</a>-->
        <schedule></schedule>
       <!-- <day-schedule :schedules="scheduleItems" :currentDate="currentDate"></day-schedule>
        <time-line-schedule :schedules="scheduleItems" style="margin: 0 .75rem" :currentDate="currentDate"></time-line-schedule>-->
    </div>
</template>

<script>
    import schedule from './components/calendar/calendar'
    import daySchedule from './components/calendar/day-schedule'
    import timeLineSchedule from './components/calendar/time-line-schedule'

    export default {
        name: 'app',
        components: {
            schedule: schedule,
            'day-schedule': daySchedule,
            'time-line-schedule': timeLineSchedule
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
                    startDate: new Date(2018, 3, 17, 12, 0),
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
                currentDate: new Date(2018, 3, 18)
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
