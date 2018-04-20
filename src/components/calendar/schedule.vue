<template>
    <day-schedule :scheduleItems="scheduleItems" v-if="scheduleType==='day'"></day-schedule>
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
        }
    }
</script>

<style scoped>

</style>