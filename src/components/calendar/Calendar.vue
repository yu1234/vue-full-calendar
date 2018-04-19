<template>
    <div class="calendar">
        <div class="time-list">
            <div class="item" v-for="(dayTime,i) in dayTimes" :key="dayTime.id">
                <div class="time">{{dayTime.text}}</div>
                <div class="content">
                    <div :class="{'top-line':i===0}" class="bottom-line" style="height: 100%"></div>
                </div>
            </div>
            <div class="schedule">
                <div class="schedule-item" v-for="(scheduleItem,j) in scheduleItems" :key="scheduleItem.id"
                     :style="scheduleItem.style">
                    <div class="schedule-subject">{{scheduleItem.subject}}</div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    let dayTimes = [
        {text: '00:00', id: 0},
        {text: '01:00', id: 1},
        {text: '02:00', id: 2},
        {text: '03:00', id: 3},
        {text: '04:00', id: 4},
        {text: '05:00', id: 5},
        {text: '06:00', id: 6},
        {text: '07:00', id: 7},
        {text: '08:00', id: 8},
        {text: '09:00', id: 9},
        {text: '10:00', id: 10},
        {text: '11:00', id: 11},
        {text: '12:00', id: 12},
        {text: '13:00', id: 13},
        {text: '14:00', id: 14},
        {text: '15:00', id: 15},
        {text: '16:00', id: 16},
        {text: '17:00', id: 17},
        {text: '18:00', id: 18},
        {text: '19:00', id: 19},
        {text: '20:00', id: 20},
        {text: '21:00', id: 21},
        {text: '22:00', id: 22},
        {text: '23:00', id: 23},
    ]
    export default {
        name: 'calendar',
        props: {
            scheduleItems: Array
        },
        data() {
            return {
                dayTimes: dayTimes,
                positions: []
            }
        },
        methods: {
            scheduleItemExtends() {
                let _this = this
                if (_this.scheduleItems && Array.isArray(_this.scheduleItems)) {
                    // 初始化位置二维表
                    _this.positions = []
                    for (let m = 0, len = 48; m < len; m++) {
                        let rows = []
                        for (let n = 0; m < _this.scheduleItems.length; n++) {
                            let col = {isUse: false}
                            rows.push(col)
                        }
                        _this.positions.push(rows)
                    }
                    for (let m = 0, len = _this.scheduleItems.length; m < len; m++) {
                        let scheduleItem = _this.scheduleItems[m]
                        if (scheduleItem && scheduleItem.startDate && scheduleItem.startDate instanceof Date && scheduleItem.endDate && scheduleItem.endDate instanceof Date) {
                            let starTime = scheduleItem.startDate.getTime()
                            let endTime = scheduleItem.endDate.getTime()
                            let uesTime = endTime - starTime
                            let starHours = scheduleItem.startDate.getHours()
                            let useHours = uesTime / (1000 * 60 * 60)
                            let endHours = scheduleItem.endDate.getHours()
                            let starMinutes = scheduleItem.startDate.getMinutes()
                            let endMinutes = scheduleItem.endDate.getMinutes()
                            if (useHours > 24) {
                                let i = starHours * 2
                                if (starMinutes > 29) {
                                    i++
                                }
                                for (; i < 48; i++) {
                                    if (i >= 0) {
                                        _this.positions[i][m].isUse = true
                                    }
                                }
                            } else if (useHours < 1) {
                                if (starHours >= 0) {
                                    let i = starHours * 2
                                    if (starMinutes > 29) {
                                        i++
                                    }
                                    _this.positions[i][m].isUse = true
                                }
                            } else {
                                let i = starHours * 2
                                let j = endHours * 2
                                if (starMinutes > 29) {
                                    i++
                                }
                                if (endMinutes > 29) {
                                    j++
                                }
                                for (; i <= j; i++) {
                                    if (i >= 0) {
                                        _this.positions[i][m].isUse = true
                                    }
                                }
                            }
                        }
                    }
                    console.log(_this.positions)

                    for (let m = 0, len = _this.scheduleItems.length; m < len; m++) {
                        let style = {}
                        let scheduleItem = _this.scheduleItems[m]
                        if (scheduleItem && scheduleItem.startDate && scheduleItem.startDate instanceof Date && scheduleItem.endDate && scheduleItem.endDate instanceof Date) {
                            let starTime = scheduleItem.startDate.getTime()
                            let endTime = scheduleItem.endDate.getTime()
                            let uesTime = endTime - starTime
                            let starHours = scheduleItem.startDate.getHours()
                            let useHours = uesTime / (1000 * 60 * 60)
                            let endHours = scheduleItem.endDate.getHours()
                            let starMinutes = scheduleItem.startDate.getMinutes()

                            // 设置高度
                            if (useHours > 24) {
                                style.height = `${60 * 24}px`
                            } else if (useHours < 1) {
                                style.height = `30px`
                            } else {
                                style.height = `${60 * useHours}px`
                            }
                            //获取位置信息
                            let h = starHours * 2
                            if (starMinutes > 29) {
                                h++
                            }
                            let useCount = -1
                            // 设置宽度
                            if (useHours > 24) {
                                for (let i = starHours; i < 24; i++) {
                                    if (_this.dayTimes[i].useCount > useHours) {
                                        useCount = _this.dayTimes[i].useCount
                                    }
                                }
                            } else if (useHours < 1) {
                                if (starHours >= 0) {
                                    useCount = _this.dayTimes[starHours].useCount
                                }
                            } else {
                                for (let i = starHours; i <= endHours; i++) {
                                    if (_this.dayTimes[i].useCount > useHours) {
                                        useCount = _this.dayTimes[i].useCount
                                    }
                                }
                            }
                            if (useCount > 0) {
                                style.width = `${100 / useCount}%`
                                style.left = `${(100 / useCount) * (m)}%`
                            } else if (useCount === 0) {
                                style.width = `100%`
                                style.left = `0`
                            } else {
                                style.width = `0`
                                style.left = `0`
                            }
                            // 计算位置
                            if (starMinutes >= 30) {
                                style.top = `${starHours * 60 + 30}px`
                            } else {
                                style.top = `${starHours * 60}px`
                            }
                            _this.scheduleItems[m].style = style
                        }
                    }
                }
                return _this.scheduleItems
            },
            computeCols(positions, start, col) {
                let i = start
                while (positions[i][col].isUse) {
                    let isUse = positions[i][col + 1].isUse
                    i++;
                    if (isUse) {
                        this.computeCols(positions, i, col + 1)
                    }
                }
            }
        },
        computed: {},
        watch: {
            scheduleItems: {
                handler: function (val, oldVal) {
                    this.scheduleItemExtends()
                },
                deep: true,
                immediate: true
            }
        }
    }
</script>

<!-- Add "scoped" attribute to limit CSS to _this component only -->
<style scoped lang="less">
    .calendar {
        .time-list {
            display: flex;
            flex-direction: column;
            z-index: 0;
            .item {
                display: flex;
                height: 60px;
                width: 100%;
                .time {
                    color: rgb(153, 153, 153);
                    font-size: 15px;
                    margin-right: 15px;
                    line-height: .6;
                    width: 40px;
                }
                .content {
                    display: flex;
                    flex-direction: column;
                    width: 100%;
                    .top-line {
                        border-top: rgb(229, 229, 229) 1px solid;
                    }
                    .bottom-line {
                        border-bottom: rgb(229, 229, 229) 1px solid;
                    }
                }
            }
            .schedule {
                position: absolute;
                z-index: 1;
                height: 100%;
                left: 60px;
                right: 0;
                .schedule-item {
                    position: absolute;
                    background-color: rgba(224, 111, 46, .25);
                    border-left: rgb(224, 111, 46) 2px solid;
                    .schedule-subject {
                        color: black;
                        word-break: break-all;
                        font-weight: 600;
                    }
                }
            }
        }
    }
</style>
