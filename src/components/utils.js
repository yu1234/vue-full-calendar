let utils = {
    isArrayNotNull(arr) {
        let r = false
        if (arr && Array.isArray(arr) && arr.length > 0) {
            r = true
        }
        return r
    },
    flexibleCompare(a, b) {
        if (!a && !b) {
            return 0;
        }
        if (b == null) {
            return -1;
        }
        if (a == null) {
            return 1;
        }
        if (typeof a === 'string' || typeof b === 'string') {
            return String(a).localeCompare(String(b));
        }
        return a - b;
    }
}

module.exports = utils