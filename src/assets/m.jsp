<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    String moduleid = request.getParameter("moduleid");
%>
<div vueId="scheduleMainPage">
    <!-- 标题栏 -->
    <header class="bar bar-nav" style="border-bottom: none">
        <i class="app-icon icon-nav app-icon-1x2 nav-icon-return  pull-left" v-on:click="back('index')"></i>
        <div class="title">日程</div>
        <div class="pull-right">
            <i class="iconfont icon icon-list_icon_addition nav-icon"></i>
            <i class="iconfont icon icon-nav_btn_timeline" style="font-size: 1.5rem"></i>
            <i class="iconfont icon icon-nav_btn_mail_menu" style="font-size: 1.5rem"></i>
        </div>
    </header>
    <div class="bar bar-header-secondary">
        <mu-flexbox style="font-size: .5rem;padding-top: .5rem">
            <mu-flexbox-item class="text-center" v-for="(day,i) in weekday" :key="day">
                {{day}}
            </mu-flexbox-item>
        </mu-flexbox>
        <local-swiper ref="calendarSwiper" :options="calendar.swiperOptions"
                      @slide-prev-transition-start="weekChange('prev')"
                      @slide-next-transition-start="weekChange('next')" style="margin-top: .25rem">
            <local-slide v-for="(slide,index) in calendar.slides" :key="index">
                <mu-flexbox style="font-size: .85rem">
                    <mu-flexbox-item v-for="(week,i) in slide.week" :key="week.id" class="text-center"
                                     @click="calendarDayClick(i)">
                        <mu-avatar
                                :class="{'calendar-unselected':calendar.options.selectedIndex!==i,'calendar-selected':calendar.options.selectedIndex===i}">
                            <div style="display: inline-flex;flex-direction: column;">
                                <span style="line-height: .5rem;">{{week.text}}</span>
                                <span style="line-height: 0;font-size: 1.2rem;font-weight: bold">.</span>
                            </div>
                        </mu-avatar>
                    </mu-flexbox-item>
                </mu-flexbox>
            </local-slide>
        </local-swiper>
        <div class="text-center" style="margin-top: .75rem">
            <span style="font-size: .75rem;">{{getDateInfo}}</span>&nbsp;&nbsp;
            <i class="iconfont  icon-calendar_icon_pulldo" style="font-size: .75rem;"></i>
        </div>
    </div>
    <div class="content">
    </div>
</div>