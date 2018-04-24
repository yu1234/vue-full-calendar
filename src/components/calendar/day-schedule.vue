<template>
    <div class="ds-daySchedule">
        <div class="ds-time-list">
            <div class="ds-item" :style="{height:dayTimeHeight+'px' }" v-for="(dayTime,i) in dayTimes"
                 :key="dayTime.id">
                <div class="ds-time">{{dayTime.text}}</div>
                <div class="ds-content">
                    <div :class="{'ds-top-line':i===0}" class="ds-bottom-line" style="height: 100%"></div>
                </div>
            </div>
            <div class="ds-schedule" :style="{height:dayTimeHeight*24+'px' }">
                <div class="ds-schedule-item" v-for="(scheduleItem) in daySchedules" :key="scheduleItem.id"
                     :style="scheduleItem.style">
                    <div class="ds-schedule-subject">{{scheduleItem.title}}</div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import {isArrayNotNull, flexibleCompare, colorRgba} from '../utils'

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
        name: 'day-schedule',
        mounted: function () {
            this.daySchedules = this.setDaySchedules(this.scheduleItems)
            if (this.currentDate && this.currentDate instanceof Date) {
                this.currentDate.setHours(0)
                this.currentDate.setMinutes(0)
            }
        },
        props: {
            dayTimeHeight: {
                type: Number,
                default: function () {
                    return 40
                }
            },
            scheduleItems: {
                type: Array,
                default: function () {
                    return []
                }
            },
            currentDate: {
                type: Date,
                default: function () {
                    let today = new Date()
                    today.setHours(0)
                    today.setMinutes(0)
                    return today
                }
            }
        },
        data: function () {
            return {
                dayTimes: dayTimes,
                daySchedules: []
            }
        },
        methods: {
            sortScheduleItems: function (scheduleItems) {
                if (isArrayNotNull(scheduleItems)) {
                    scheduleItems.sort(function (a, b) {
                        return a.startTime - b.startTime || // earlier events go first
                            b.durationTime - a.durationTime || // tie? longer events go first
                            flexibleCompare(a.title, b.title);
                    })
                }
            },
            buildSlotItemsLevels: function (scheduleItems) {
                let levels = []
                let i
                let seg
                let j
                for (i = 0; i < scheduleItems.length; i++) {
                    seg = scheduleItems[i]
                    // go through all the levels and stop on the first level where there are no collisions
                    for (j = 0; j < levels.length; j++) {
                        if (!this.computeSlotSegCollisions(seg, levels[j]).length) {
                            break
                        }
                    }
                    seg.level = j
                    levels[j] || (levels[j] = [])
                    levels[j].push(seg)
                }
                return levels;
            },
            computeSlotSegCollisions: function (seg, otherSegs, results) {
                results = results || []
                for (var i = 0; i < otherSegs.length; i++) {
                    if (this.isSlotSegCollision(seg, otherSegs[i])) {
                        results.push(otherSegs[i])
                    }
                }
                return results
            },
            // Do these segments occupy the same vertical space?
            isSlotSegCollision(seg1, seg2) {
                return seg1.bottomPoint > seg2.topPoint && seg1.topPoint < seg2.bottomPoint
            },
            computeForwardSlotSegs: function (levels) {
                let i
                let level
                let j
                let seg
                let k
                for (i = 0; i < levels.length; i++) {
                    level = levels[i]
                    for (j = 0; j < level.length; j++) {
                        seg = level[j]
                        seg.forwardSegs = []
                        for (k = i + 1; k < levels.length; k++) {
                            this.computeSlotSegCollisions(seg, levels[k], seg.forwardSegs)
                        }
                    }
                }
            },
            // Figure out which path forward (via seg.forwardSegs) results in the longest path until
            // the furthest edge is reached. The number of segments in this path will be seg.forwardPressure
            computeSlotSegPressures: function (seg) {
                let forwardSegs = seg.forwardSegs
                let forwardPressure = 0
                let i
                let forwardSeg

                if (seg.forwardPressure === undefined) { // not already computed
                    for (i = 0; i < forwardSegs.length; i++) {
                        forwardSeg = forwardSegs[i]
                        // figure out the child's maximum forward path
                        this.computeSlotSegPressures(forwardSeg);
                        // either use the existing maximum, or use the child's forward pressure
                        // plus one (for the forwardSeg itself)
                        forwardPressure = Math.max(
                            forwardPressure,
                            1 + forwardSeg.forwardPressure
                        )
                    }
                    seg.forwardPressure = forwardPressure;
                }
            },
            computeFgSegForwardBack: function (seg, seriesBackwardPressure, seriesBackwardCoord) {
                let forwardSegs = seg.forwardSegs
                let i
                if (seg.forwardCoord === undefined) { // not already computed
                    if (!forwardSegs.length) {
                        // if there are no forward segments, this segment should butt up against the edge
                        seg.forwardCoord = 1
                    } else {
                        // sort highest pressure first
                        this.sortScheduleItems(forwardSegs)
                        // this segment's forwardCoord will be calculated from the backwardCoord of the
                        // highest-pressure forward segment.
                        this.computeFgSegForwardBack(forwardSegs[0], seriesBackwardPressure + 1, seriesBackwardCoord)
                        seg.forwardCoord = forwardSegs[0].backwardCoord
                    }
                    // calculate the backwardCoord from the forwardCoord. consider the series
                    seg.backwardCoord = seg.forwardCoord -
                        (seg.forwardCoord - seriesBackwardCoord) / // available width for series
                        (seriesBackwardPressure + 1) // # of segments in the series
                    // use this segment's coordinates to computed the coordinates of the less-pressurized
                    // forward segments
                    for (i = 0; i < forwardSegs.length; i++) {
                        this.computeFgSegForwardBack(forwardSegs[i], 0, seg.forwardCoord)
                    }
                }
            },
            computeFgSegHorizontals: function (scheduleItems) {
                let levels
                let level0
                let i
                this.sortScheduleItems(scheduleItems)
                levels = this.buildSlotItemsLevels(scheduleItems)
                this.computeForwardSlotSegs(levels)
                if ((level0 = levels[0])) {
                    for (i = 0; i < level0.length; i++) {
                        this.computeSlotSegPressures(level0[i]);
                    }
                    for (i = 0; i < level0.length; i++) {
                        this.computeFgSegForwardBack(level0[i], 0, 0)
                    }
                }
                for (let j = 0, len = scheduleItems.length; j < len; j++) {
                    let style = this.setStyle(scheduleItems[j])
                    scheduleItems[j].style = style
                }
            },
            // Generates an object with CSS properties/values that should be applied to an event segment element.
            // Contains important positioning-related properties that should be applied to any event element, customized or not.
            setStyle: function (seg) {
                let backwardCoord = seg.backwardCoord // the left side if LTR. the right side if RTL. floating-point
                let forwardCoord = seg.forwardCoord // the right side if LTR. the left side if RTL. f
                let props = {} // get top/bottom first
                let left // amount of space from left edge, a fraction of the total width
                let right // amount of space from right edge, a fraction of the total width
                forwardCoord = Math.min(1, backwardCoord + (forwardCoord - backwardCoord) * 2)
                left = backwardCoord
                right = 1 - forwardCoord
                props.zIndex = seg.level + 1 // convert from 0-base to 1-based
                props.left = left * 100 + '%'
                if (seg.forwardPressure) {
                    let unit = (1 - (right + left)) / 2;
                    right += unit;
                    props.right = right * 100 + '%'
                } else {
                    props.right = right * 100 + '%'
                }
                props.top = seg.top + 'px'
                props.bottom = seg.bottom + 'px'
                if (seg.color) {
                    props.backgroundColor = colorRgba(seg.color, 0.25)
                    props.borderLeftColor = seg.color
                }
                return props
            },
            setDaySchedules: function (scheduleItems) {
                let r = []
                if (isArrayNotNull(scheduleItems)) {
                    for (let m = 0, len = scheduleItems.length; m < len; m++) {
                        let scheduleItem = Object.assign({}, scheduleItems[m])
                        if (scheduleItem && scheduleItem.startDate && scheduleItem.startDate instanceof Date && scheduleItem.endDate && scheduleItem.endDate instanceof Date) {
                            let currentStartTime = this.currentDate.getTime()
                            let currentEndTime = currentStartTime + (1000 * 60 * 60 * 24)
                            let startTime = scheduleItem.startDate.getTime()
                            let endTime = scheduleItem.endDate.getTime()
                            let durationTime = endTime - startTime
                            let startHours = scheduleItem.startDate.getHours()
                            let endHours = scheduleItem.endDate.getHours()
                            let startMinutes = scheduleItem.startDate.getMinutes()
                            let endMinutes = scheduleItem.endDate.getMinutes()
                            scheduleItem.startTime = startTime
                            scheduleItem.endTime = endTime
                            scheduleItem.durationTime = durationTime
                            // 设置高度
                            if (startTime < currentEndTime && endTime > currentStartTime) {
                                if (startTime < currentStartTime && endTime > currentEndTime) {
                                    scheduleItem.topPoint = 0
                                    scheduleItem.bottomPoint = 24 * this.dayTimeHeight
                                    scheduleItem.top = 0
                                    scheduleItem.bottom = 0
                                } else if (startTime < currentStartTime && endTime < currentEndTime) {
                                    scheduleItem.topPoint = 0
                                    scheduleItem.top = 0
                                    let sC = endHours * 2 + (((endMinutes + 1) / 30) >= 1 ? 1 : 0)
                                    let bottom = sC * (this.dayTimeHeight / 2)
                                    scheduleItem.bottomPoint = bottom
                                    scheduleItem.bottom = 24 * this.dayTimeHeight - bottom
                                } else if (startTime > currentStartTime && endTime > currentEndTime) {
                                    let top = startHours * this.dayTimeHeight + (((startMinutes + 1) / 30) >= 1 ? (this.dayTimeHeight / 2) : 0)
                                    scheduleItem.topPoint = top
                                    scheduleItem.top = top
                                    scheduleItem.bottomPoint = 24 * this.dayTimeHeight
                                    scheduleItem.bottom = 0
                                } else if (startTime >= currentStartTime && endTime <= currentEndTime) {
                                    let top = startHours * this.dayTimeHeight + (((startMinutes + 1) / 30) >= 1 ? (this.dayTimeHeight / 2) : 0)
                                    let sC = (endHours * 2 + (((endMinutes + 1) / 30) >= 1 ? 1 : 0)) - (startHours * 2 + (((startMinutes + 1) / 30) >= 1 ? 1 : 0))
                                    let bottom = sC * (this.dayTimeHeight / 2) + top
                                    scheduleItem.topPoint = top
                                    scheduleItem.bottomPoint = bottom
                                    scheduleItem.top = top
                                    scheduleItem.bottom = 24 * this.dayTimeHeight - bottom
                                } else {
                                    scheduleItem.topPoint = 0
                                    scheduleItem.bottomPoint = 0
                                    scheduleItem.top = ''
                                    scheduleItem.bottom = ''
                                }
                                r.push(scheduleItem)
                            }
                        } else {
                            console.error('日程项必须有startDate,endDate属性,且必须为Date对象')
                            return r
                        }
                    }
                    this.computeFgSegHorizontals(r)
                }
                return r
            }
        },
        computed: {},
        watch: {
            scheduleItems: function (newVal) {
                this.daySchedules = this.setDaySchedules(newVal)
            },
            currentDate: function (newVal) {
                if (newVal && newVal instanceof Date) {
                    this.currentDate.setHours(0)
                    this.currentDate.setMinutes(0)
                    this.daySchedules = this.setDaySchedules(this.scheduleItems)
                }

            }
        }
    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="less">
    .ds-daySchedule {
        .ds-time-list {
            display: flex;
            flex-direction: column;
            z-index: 0;
            .ds-item {
                display: flex;
                width: 100%;
                .time {
                    color: rgb(153, 153, 153);
                    font-size: 15px;
                    margin-right: 15px;
                    line-height: .6;
                    width: 40px;
                }
                .ds-content {
                    display: flex;
                    flex-direction: column;
                    width: 100%;
                    .ds-top-line {
                        border-top: rgb(229, 229, 229) 1px solid;
                    }
                    .ds-bottom-line {
                        border-bottom: rgb(229, 229, 229) 1px solid;
                    }
                }
            }
            .ds-schedule {
                position: absolute;
                z-index: 1;
                left: 45px;
                right: 0;
                .ds-schedule-item {
                    position: absolute;
                    background-color: rgba(224, 111, 46, .25);
                    border-left: rgb(224, 111, 46) 2px solid;
                    .ds-schedule-subject {
                        color: black;
                        word-break: break-all;
                        font-weight: 600;
                    }
                }
            }
        }
    }
</style>
