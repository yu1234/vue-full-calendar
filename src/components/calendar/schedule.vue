<template>
    <div class="schedule">
        <div class="calendar">
            <div class="week-title flex-box">
                <div class="flex-item" style="text-align: center" v-for="day in weekday" :key="day">
                    {{day}}
                </div>
            </div>
            <div class="calendar-swiper">

            </div>
        </div>
        <day-schedule :scheduleItems="scheduleItems" v-if="scheduleType==='day'"></day-schedule>
    </div>
</template>

<script>
    import daySchedule from './day-schedule'

    export default {
        name: "calendar",
        components: {
            'day-schedule': daySchedule
        },
        props: {
            scheduleItems: {
                type: Array,
                default: function () {
                    return []
                }
            },
            scheduleType: {
                type: String,
                default: function () {
                    return 'day'
                }
            }
        },
        data() {
            return {
                weekday: ['一', '二', '三', '四', '五', '六', '日']
            }
        }
    }
</script>

<style scoped lang="less">
    .schedule {
        .flex-box {
            display: flex;
        }
        .flex-item {
            flex: 1 1 auto;
        }
        .calendar {
            height: 120px;
            .week-title {
                font-size: 10px;
                padding-top: 10px;
            }
            .calendar-swiper {

            }
        }

    }

</style>