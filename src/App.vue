<template>
    <div id="app">
        <a @click="addScheduleItem">添加日程</a>
        <!--<schedule :scheduleItems="scheduleItems"></schedule>-->
        <day-schedule :scheduleItems="scheduleItems" :currentDate="currentDate"></day-schedule>
        <a @click="addScheduleItem">添加日程</a>
    </div>
</template>

<script>
    import schedule from './components/calendar/schedule'
    import daySchedule from './components/calendar/day-schedule'

    export default {
        name: 'app',
        components: {
            schedule: schedule,
            'day-schedule': daySchedule
        },
        data() {
            return {
                scheduleItems: [{
                    startDate: new Date(2018, 3, 18, 10, 30),
                    endDate: new Date(2018, 3, 20, 17, 30),
                    title: '主题1',
                    color: '#222222'
                }, {
                    startDate: new Date(2018, 3, 18, 10, 30),
                    endDate: new Date(2018, 3, 20, 17, 30),
                    title: '主题2'
                }, {
                    startDate: new Date(2018, 3, 17, 12, 0),
                    endDate: new Date(2018, 3, 20, 12, 30),
                    title: '主题3'
                }, {
                    startDate: new Date(2018, 3, 18, 14, 0),
                    endDate: new Date(2018, 3, 18, 17, 30),
                    title: '主题4'
                }, {
                    startDate: new Date(2018, 3, 18, 18, 0),
                    endDate: new Date(2018, 3, 18, 19, 30),
                    title: '主题5'
                }, {
                    startDate: new Date(2018, 3, 19, 3, 30),
                    endDate: new Date(2018, 3, 19, 8, 0),
                    title: '主题6'
                }, {
                    startDate: new Date(2018, 3, 19, 3, 30),
                    endDate: new Date(2018, 3, 19, 8, 0),
                    title: '主题7'
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

    body {
        padding: 0;
        margin: 0;
    }
</style>
