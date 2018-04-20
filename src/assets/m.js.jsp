<%@ page language="java" contentType="application/javascript; charset=UTF-8"
	pageEncoding="UTF-8"%>
    +function (mObj) {
        console.log(mObj.moduleid)
        $(function () {
            /**
             *================================================================页面初始化区域 start=============================================
             */
                //页面初始化
            var onload_fun = function (params) {
                    mObj.init();
                }
            var onshow_fun = function (params) {
                if (mObj.vueCreated) {
                    mObj.refresh();
                } else {
                    //等待vue创建完成
                    var interval = setInterval(function () {
                        if (mObj.vueCreated) {
                            clearInterval(interval);
                            mObj.refresh();
                        }
                    }, 1000);
                }
            }
            tw_registerOnload(mObj.moduleid, onload_fun);
            tw_registerOnshow(mObj.moduleid, onshow_fun);
            //初始化方法
            mObj.init = function () {

            }
            //页面刷新方法
            mObj.refresh = function () {
                mObj.methods.refresh();
            }
            /**
             *================================================================页面初始化区域 end=============================================
             */
            /**
             * =====================================================vue 组件============================================================
             */
            mObj.components = {
                LocalSwiper: VueAwesomeSwiper.swiper,
                LocalSlide: VueAwesomeSwiper.swiperSlide
            };
            /**
             * ===============================================================vue start======================================================
             */
            //vue实例
            mObj.vueObj;
            //vue是否已经实例化flag
            mObj.vueCreated = false;
            //vue原始数据源,用于还原vue数据模型
            mObj.getDefaultData = function () {
                return {
                    weekday: ['一', '二', '三', '四', '五', '六', '日'],
                    cnWeek: ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],
                    calendar: {
                        selectedDate: null,
                        slides: [],
                        options: {
                            cacheMaxSize: 10,
                            selectedIndex: 0
                        },
                        swiperOptions: {
                            initialSlide: 1,
                            observer: true,//修改swiper自己或子元素时，自动初始化swiper
                            observeParents: true//修改swiper的父元素时，自动初始化swiper
                        }
                    }
                };
            };
            //vue数据源
            mObj.vueData = mObj.getDefaultData();
            //vue方法
            mObj.methods = {
                test: function () {
                    alert("此功能暂未使用");
                },
                back: function (url) {
                    tw_pageBack(url);
                },
                refresh: function () {
                    mObj.customMethods.initCalendar()
                },
                weekChange: function (type) {
                    mObj.vueObj.calendar.options.selectedIndex = 0
                    var index = mObj.vueObj.calendarSwiper.realIndex
                    var slideToIndex = index
                    if (type === 'prev' && twc_arrayNotNull(mObj.vueObj.calendar.slides)) {
                        if (index === 0) {
                            var cWeek = mObj.vueObj.calendar.slides[index].week
                            var prevWeek = mObj.customMethods.getWeek(type, cWeek[0].date)
                            if (mObj.vueObj.calendar.slides.length >= mObj.vueObj.calendar.options.cacheMaxSize) {
                                mObj.vueObj.calendar.slides.pop()
                            }
                            mObj.vueObj.calendar.slides.unshift({week: prevWeek})
                            slideToIndex++
                        }
                    } else if (type === 'next' && twc_arrayNotNull(mObj.vueObj.calendar.slides)) {
                        if (index === (mObj.vueObj.calendar.slides.length - 1)) {
                            var cWeek = mObj.vueObj.calendar.slides[index].week
                            var nextWeek = mObj.customMethods.getWeek(type, cWeek[6].date)
                            if (mObj.vueObj.calendar.slides.length >= mObj.vueObj.calendar.options.cacheMaxSize) {
                                mObj.vueObj.calendar.slides.shift()
                                slideToIndex--
                            }
                            mObj.vueObj.calendar.slides.push({week: nextWeek})
                        }
                    }
                    mObj.vueObj.$nextTick().then(function () {
                        mObj.vueObj.calendarSwiper.slideTo(slideToIndex, 0, false);
                        if (twc_arrayNotNull(mObj.vueObj.calendar.slides) && mObj.vueObj.calendar.slides.length > slideToIndex && mObj.vueObj.calendar.slides[slideToIndex].week) {
                            mObj.vueObj.calendar.selectedDate = mObj.vueObj.calendar.slides[slideToIndex].week[mObj.vueObj.calendar.options.selectedIndex].date
                        }
                    })
                },
                getSelectedDateInfo(type) {
                    if (!mObj.vueObj) {
                        return
                    }
                    var date = mObj.vueObj.calendar.selectedDate || new Date()
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
                        if (mObj.vueObj.cnWeek.length > day) {
                            return mObj.vueObj.cnWeek[day]
                        }

                    }

                },
                /**
                 * 日历点击事件
                 */
                calendarDayClick(index) {
                    var realIndex = mObj.vueObj.calendarSwiper.realIndex
                    if (twc_arrayNotNull(mObj.vueObj.calendar.slides) && mObj.vueObj.calendar.slides.length > realIndex && mObj.vueObj.calendar.slides[realIndex].week) {
                        mObj.vueObj.calendar.options.selectedIndex = index
                        mObj.vueObj.calendar.selectedDate = mObj.vueObj.calendar.slides[realIndex].week[index].date
                    }
                }
            }
            //vue 过滤方法
            mObj.filters = {}
            //vue 计算方法
            mObj.computed = {
                calendarSwiper: function () {
                    return this.$refs.calendarSwiper.swiper
                },
                getDateInfo: function () {
                    if (this.calendar && this.calendar.selectedDate) {
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
            //vue初始化
            var vue = {
                el: '#' + mObj.moduleid + ' div[vueId="scheduleMainPage"]',
                data: mObj.vueData,
                methods: mObj.methods,
                filters: mObj.filters,
                computed: mObj.computed,
                components: mObj.components,
                /**
                 * 页面渲染结束回调
                 */
                updated: function () {
                },
                /**
                 * 错误捕捉
                 */
                errorCaptured: function (err) {
                },
                beforeCreate: function () {
                },
                created: function () {
                    mObj.vueCreated = true;
                }

            };
            mObj.vueObj = new Vue(vue);
            /**
             * ===============================================================vue end======================================================
             */

            mObj.customMethods = {
                initCalendar: function () {
                    var today = new Date();
                    mObj.vueObj.calendar.options.selectedIndex = (today.getDay() === 0 ? 6 : today.getDay() - 1)
                    mObj.vueObj.calendar.slides = []
                    var cWeek = mObj.customMethods.getWeek('curr')
                    if (cWeek && cWeek.length > mObj.vueObj.calendar.options.selectedIndex) {
                        mObj.vueObj.calendar.selectedDate = cWeek[mObj.vueObj.calendar.options.selectedIndex].date
                    }
                    var prevWeek = []
                    var nextWeek = []
                    if (twc_arrayNotNull(cWeek)) {
                        prevWeek = mObj.customMethods.getWeek('prev', cWeek[0].date)
                    }
                    if (twc_arrayNotNull(cWeek) && cWeek.length > 6) {
                        nextWeek = mObj.customMethods.getWeek('next', cWeek[6].date)
                    }
                    mObj.vueObj.calendar.slides.push({week: prevWeek})
                    mObj.vueObj.calendar.slides.push({week: cWeek})
                    mObj.vueObj.calendar.slides.push({week: nextWeek})
                },
                getWeek: function (type, dateObj) {
                    var r = [];
                    var week = new Array(7);
                    if (type === 'curr') {
                        var dateOfToday = Date.now();
                        var dayOfToday = (new Date().getDay() + 7 - 1) % 7;
                        $.each(week, function (i, v) {
                            var date = new Date(dateOfToday + (i - dayOfToday) * 1000 * 60 * 60 * 24);
                            var temp = {
                                text: date.getDate(),
                                date: date
                            }
                            r.push(temp);
                        })
                    } else if (type === 'prev' && dateObj) {
                        $.each(week, function (i, v) {
                            var date = new Date(dateObj.getFullYear(), dateObj.getMonth(), dateObj.getDate() - (7 - i));
                            var temp = {
                                text: date.getDate(),
                                date: date
                            }
                            r.push(temp);
                        })
                    } else if (type === 'next' && dateObj) {
                        $.each(week, function (i, v) {
                            var date = new Date(dateObj.getFullYear(), dateObj.getMonth(), dateObj.getDate() + i + 1);
                            var temp = {
                                id: date.getDate(),
                                text: date.getDate(),
                                date: date
                            }
                            r.push(temp);
                        })
                    }
                    return r;
                }
            }
        });
    }(tw_funcParam('<%=request.getParameter("moduleid")%>'));