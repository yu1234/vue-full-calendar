let utils = {
    isArrayNotNull: function (arr) {
        let r = false
        if (arr && Array.isArray(arr) && arr.length > 0) {
            r = true
        }
        return r
    },
    flexibleCompare: function (a, b) {
        if (!a && !b) {
            return 0
        }
        if (b == null) {
            return -1
        }
        if (a == null) {
            return 1
        }
        if (typeof a === 'string' || typeof b === 'string') {
            return String(a).localeCompare(String(b))
        }
        return a - b
    },
    colorRgba: function (color, a) {
        let sColor = ''
        if (color === undefined || color === null) {
            return color
        }
        if (a === undefined || a === null) {
            a = 1
        }
        if (a < 0) {
            a = 0
        }
        sColor = color.toLowerCase()
        //十六进制颜色值的正则表达式
        let reg = /^#([0-9a-fA-f]{3}|[0-9a-fA-f]{6})$/
        // 如果是16进制颜色
        if (sColor && reg.test(sColor)) {
            if (sColor.length === 4) {
                let sColorNew = '#'
                for (let i = 1; i < 4; i += 1) {
                    sColorNew += sColor.slice(i, i + 1).concat(sColor.slice(i, i + 1))
                }
                sColor = sColorNew
            }
            //处理六位的颜色值
            let sColorChange = [];
            for (let i = 1; i < 7; i += 2) {
                sColorChange.push(parseInt('0x' + sColor.slice(i, i + 2)))
            }
            return `rgba(${sColorChange.join(",")},${a})`;
        }
        return sColor;
    }
}

module.exports = utils