<template>
    <div id="app">
        <a @click="addScheduleItem">添加日程</a>
        <schedule :scheduleItems="scheduleItems"></schedule>
    </div>
</template>

<script>
    import schedule from './components/calendar/schedule'

    export default {
        name: 'app',
        components: {
            schedule: schedule
        },
        data() {
            return {
                scheduleItems: [{
                    startDate: new Date(2018, 3, 18, 10, 30),
                    endDate: new Date(2018, 3, 20, 17, 30),
                    title: '主题1',
                    color: 'blue'
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
                }]
            }
        },
        methods: {
            addScheduleItem() {
                let scheduleItem = {
                    startDate: new Date(2018, 4, 19, 3, 30),
                    endDate: new Date(2018, 4, 19, 8, 0),
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
</style>
