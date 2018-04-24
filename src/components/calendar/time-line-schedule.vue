<template>
    <div class="ds-time-line ds-left-line">
        <div style="height: 1.25rem"></div>
        <div class="ds-time-line-item" v-for="(schedule,i) in extendSchedules" @click="itemClick(schedule,i)">
            <div class="ds-time-line-item-title">{{schedule.title}}</div>
            <div class="ds-time-line-item-line" :style="{borderTopColor:schedule.color}">
                <div class="ds-time-line-item-dot" :style="{backgroundColor:schedule.color}"></div>
            </div>
            <div class="ds-time-line-item-content" v-if="schedule.content">{{schedule.content}}</div>
            <div class="ds-time-line-item-time">{{schedule.formatStartDate}}至{{schedule.formatEndDate}}</div>
            <div style="height: 2rem"></div>
        </div>

    </div>
</template>

<script>
    import {isArrayNotNull} from '../utils'

    export default {
        name: 'time-line-schedule',
        props: {
            schedules: {
                type: Array,
                default: function () {
                    return []
                }
            }
        },
        data: function () {
            return {
                extendSchedules: [],
                cnWeek: ['周日', '周一', '周二', '周三', '周四', '周五', '周六']
            }
        },
        mounted: function () {
            if (isArrayNotNull(this.schedules)) {
                this.extendSchedules = this.formatSchedules(this.schedules)
            }
        },
        methods: {
            /**
             * 格式化日程
             * @param schedules
             * @return {Array}
             */
            formatSchedules: function (schedules) {
                let r = []
                if (isArrayNotNull(schedules)) {
                    let cSchedules = schedules.concat()
                    // 排序
                    this.schedulesSort(cSchedules)
                    for (let i = 0, len = cSchedules.length; i < len; i++) {
                        let schedule = cSchedules[i]
                        if (schedule.startDate && schedule.startDate instanceof Date) {
                            let startDate = schedule.startDate
                            schedule.formatStartDate = `${startDate.getFullYear()}-${startDate.getMonth() + 1}-${startDate.getDate()} ${this.cnWeek[startDate.getDay()]} ${startDate.getHours() < 10 ? '0' + startDate.getHours() : startDate.getHours()}:${startDate.getMinutes() < 10 ? '0' + startDate.getMinutes() : startDate.getMinutes()}`
                        }
                        if (schedule.endDate && schedule.endDate instanceof Date) {
                            let endDate = schedule.endDate
                            schedule.formatEndDate = `${endDate.getFullYear()}-${endDate.getMonth() + 1}-${endDate.getDate()} ${this.cnWeek[endDate.getDay()]} ${endDate.getHours() < 10 ? '0' + endDate.getHours() : endDate.getHours()}:${endDate.getMinutes() < 10 ? '0' + endDate.getMinutes() : endDate.getMinutes()}`
                        }
                        r.push(schedule)
                    }
                }
                return r
            },
            /**
             * 日程排序
             */
            schedulesSort: function (schedules) {
                if (isArrayNotNull(schedules)) {
                    schedules.sort((a, b) => {
                        let aStartDate = a.startDate
                        let bStartDate = b.startDate
                        if (aStartDate && bStartDate && aStartDate instanceof Date && bStartDate instanceof Date) {
                            return aStartDate.getTime() - bStartDate.getTime()
                        } else if ((!aStartDate || !(aStartDate instanceof Date)) && bStartDate && bStartDate instanceof Date) {
                            return -1
                        } else if ((!bStartDate || !(bStartDate instanceof Date)) && aStartDate && aStartDate instanceof Date) {
                            return 1
                        } else {
                            return 0
                        }
                    })
                }
            },
            /**
             * 日程点击时间
             */
            itemClick: function (item, i) {
                this.$emit('scheduleClick', item, i)
                this.$emit('schedule-click', item, i)
            }
        },
        watch: {
            schedules: function (newVal) {
                if (isArrayNotNull(newVal)) {
                    this.extendSchedules = this.formatSchedules(newVal)
                }
            }
        }
    }
</script>

<style scoped lang="less">
    .ds-time-line {
        display: flex;
        flex-direction: column;
        border-left: rgb(229, 229, 229) .1rem solid;
        .ds-time-line-item {
            .ds-time-line-item-title {
                font-size: .85rem;
                padding-left: .75rem;
                color: rgb(224, 111, 46);
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }
            .ds-time-line-item-content {
                font-size: .75rem;
                padding-left: .75rem;
                color: rgb(102, 102, 102);
                margin-bottom: .5rem;
                word-break: break-all;
                overflow: hidden;
                text-overflow: ellipsis;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
            }
            .ds-time-line-item-time {
                font-size: .65rem;
                padding-left: .75rem;
                color: rgb(153, 153, 153);
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }
            .ds-time-line-item-line {
                border-top: rgb(224, 111, 46) .1rem solid;
                margin-top: .5rem;
                margin-bottom: .5rem;
                z-index: 0;
                position: relative;
                .ds-time-line-item-dot {
                    position: absolute;
                    left: -0.2rem;
                    top: -0.2rem;
                    height: .3rem;
                    width: .3rem;
                    border-radius: 50%;
                    background-color: rgb(224, 111, 46);
                    z-index: 1;
                }
            }

        }
    }
</style>
