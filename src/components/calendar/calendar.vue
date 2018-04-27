<template>
    <div class="schedule">
        <div class="calendar">
            <div class="week-title flex-box">
                <div class="flex-item" style="text-align: center" v-for="day in weekday" :key="day">
                    {{day}}
                </div>
            </div>
            <div class="calendar-swiper">
                <tb-swiper ref="swiper" direction="horizontal" :loop="true" @slider-next="slideChange"
                           @slider-prev="slideChange"
                           v-if="calendar.calendarSwiperInit">
                    <tb-slide>
                        <div class="flex-box" style="font-size: 17px;">
                            <div class="flex-item" style="text-align: center" v-for="(weekday,i) in calendar.week0"
                                 :key="weekday.id">
                                <avatar class="calendar-selected"
                                        :class="{'calendar-unselected':calendar.selectedDateIndex!==i,'calendar-selected':calendar.selectedDateIndex===i}">
                                    <div style="display: inline-flex;flex-direction: column;">
                                        <span style="line-height: 10px;"> {{weekday.text}}</span>
                                        <span style="line-height: 0;font-size: 24px;font-weight: bold">.</span>
                                    </div>
                                </avatar>
                            </div>
                        </div>
                    </tb-slide>
                    <tb-slide>
                        <div class="flex-box" style="font-size: 17px;">
                            <div class="flex-item" style="text-align: center" v-for="(weekday,i) in calendar.week1"
                                 :key="weekday.id">
                                <avatar :class="{'calendar-unselected':calendar.selectedDateIndex!==i,'calendar-selected':calendar.selectedDateIndex===i}">
                                    <div style="display: inline-flex;flex-direction: column;">
                                        <span style="line-height: 10px;"> {{weekday.text}}</span>
                                        <span style="line-height: 0;font-size: 24px;font-weight: bold">.</span>
                                    </div>
                                </avatar>
                            </div>
                        </div>
                    </tb-slide>
                </tb-swiper>
                <div class="text-center" style="margin-top: 15px">
                    <span style="font-size: 15px;">{{getDateInfo}}</span>&nbsp;&nbsp;
                    <i class="iconfont  icon-calendar_icon_pulldo" style="font-size: .75rem;"></i>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import daySchedule from './day-schedule'
    import swiper from '../vue-swiper/vue-swiper'
    import slide from '../vue-swiper/vue-slide'
    import avatar from '../avatar/avatar'
    import tbSwiper from '../swiper/tb-swiper'
    import tbSlide from '../swiper/tb-slide'

    export default {
        name: "calendar",
        components: {
            'day-schedule': daySchedule,
            swiper: swiper,
            slide: slide,
            avatar: avatar,
            'tb-swiper': tbSwiper,
            'tb-slide': tbSlide
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
                weekday: ['一', '二', '三', '四', '五', '六', '日'],
                cnWeek: ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],
                calendar: {
                    calendarSwiperInit: false,
                    currentPage: 0,
                    week0: [],
                    week1: [],
                    selectedDate: null,
                    selectedDateIndex: 0
                }
            }
        },
        mounted() {
            this.initCalendar()
        },
        methods: {
            slideChange(type, newSlideIndex, oldSlideIndex) {
                let today = new Date();
                let cWeek = this.calendar[`week${oldSlideIndex}`]
                if (type === 'next' && cWeek && cWeek.length > 6) {
                    this.calendar[`week${newSlideIndex}`] = this.getWeek(type, cWeek[6].date)
                    this.currentPage = newSlideIndex
                } else if (type === 'prev' && cWeek && cWeek.length > 0) {
                    this.calendar[`week${newSlideIndex}`] = this.getWeek(type, cWeek[0].date)
                    this.currentPage = newSlideIndex
                }
                console.log(this.calendar)
            },
            initCalendar() {
                let today = new Date()
                this.calendar.selectedDate = today
                this.calendar.selectedDateIndex = (today.getDay() === 0 ? 6 : today.getDay() - 1)
                this.calendar.week0 = this.getWeek('curr')
                this.calendar.week1 = this.getWeek('next', this.calendar.week0[0].date)
                this.$nextTick(function () {
                    this.calendar.calendarSwiperInit = true
                    this.currentPage = 0
                });
            },
            getWeek(type, dateObj) {
                let r = [];
                if (type === 'curr') {
                    let dateOfToday = Date.now();
                    let dayOfToday = (new Date().getDay() + 7 - 1) % 7;
                    for (let i = 0; i < 7; i++) {
                        let date = new Date(dateOfToday + (i - dayOfToday) * 1000 * 60 * 60 * 24);
                        let temp = {
                            id: date.getDate(),
                            text: date.getDate(),
                            date: date
                        }
                        r.push(temp);
                    }
                } else if (type === 'prev' && dateObj && dateObj instanceof Date) {
                    for (let i = 0; i < 7; i++) {
                        let date = new Date(dateObj.getFullYear(), dateObj.getMonth(), dateObj.getDate() - (7 - i));
                        let temp = {
                            id: date.getDate(),
                            text: date.getDate(),
                            date: date
                        }
                        r.push(temp);
                    }
                } else if (type === 'next' && dateObj && dateObj instanceof Date) {
                    for (let i = 0; i < 7; i++) {
                        let date = new Date(dateObj.getFullYear(), dateObj.getMonth(), dateObj.getDate() + i + 1);
                        let temp = {
                            id: date.getDate(),
                            text: date.getDate(),
                            date: date
                        }
                        r.push(temp);
                    }
                } else {
                    console.error('日期出错类型或参数错误,获取不了日期')
                }
                return r;
            },
            getSelectedDateInfo(type) {
                let date = this.calendar.selectedDate || new Date()
                if (type === 'year') {
                    return date.getFullYear()
                } else if (type === 'month') {
                    var month = date.getMonth() + 1
                    var monthStr = month
                    if (month < 10) {
                        monthStr = '0' + month
                    }
                    return monthStr
                } else if (type === 'date') {
                    var date1 = date.getDate()
                    if (date1 < 10) {
                        date1 = '0' + date1
                    }
                    return date1
                } else if (type === 'day') {
                    var day = date.getDay()
                    if (this.cnWeek.length > day) {
                        return this.cnWeek[day]
                    }

                }

            }
        },
        computed: {
            getDateInfo() {
                if (this.calendar.selectedDate) {
                    var year = this.getSelectedDateInfo('year')
                    var month = this.getSelectedDateInfo('month')
                    var date = this.getSelectedDateInfo('date')
                    var day = this.getSelectedDateInfo('day')
                    return year + ' 年 ' + month + ' 月 ' + date + ' 日 ' + day
                } else {
                    return ''
                }
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
        .text-center {
            text-align: center;
        }
        .calendar {
            background-color: rgb(245, 245, 245);
            height: 120px;
            margin-bottom: 15px;
            .week-title {
                font-size: 10px;
                padding-top: 10px;
            }
            .calendar-swiper {
                margin-top: 5px;
            }
            .calendar-selected {
                color: white;
                background-color: rgb(73, 169, 242);
                width: 35px;
                height: 35px;
            }
            .calendar-unselected {
                color: black;
                background-color: rgba(73, 169, 242, 0);
                width: 35px;
                height: 35px;
            }
        }

    }

</style>