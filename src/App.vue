<template>
    <div id="app">
        <a @click="addScheduleItem">添加日程</a>
        <calendar :scheduleItems="scheduleItems"></calendar>
    </div>
</template>

<script>
    import Calendar from './components/calendar/Calendar.vue'

    export default {
        name: 'app',
        components: {
            calendar: Calendar
        },
        data() {
            return {
                scheduleItems: [{
                    startDate: new Date(2018, 4, 19, 2, 30),
                    endDate: new Date(2018, 4, 19, 3, 0),
                    subject: '主题一'
                }, {
                    startDate: new Date(2018, 4, 19, 2, 30),
                    endDate: new Date(2018, 4, 19, 4, 0),
                    subject: '主题二'
                }
                ]
            }
        },
        methods: {
            addScheduleItem() {
                let scheduleItem = {
                    startDate: new Date(2018, 4, 19, 3, 30),
                    endDate: new Date(2018, 4, 19, 8, 0),
                    subject: '主题三'
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
