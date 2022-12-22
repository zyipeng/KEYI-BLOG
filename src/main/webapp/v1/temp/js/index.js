
var danmus="[\n" +
    "    {\n" +
    "        \"blogId\": \"1\", \n" +
    "        \"commentId\": \"1\", \n" +
    "        \"value\": \"你好1！！！\"\n" +
    "    }, \n" +
    "    {\n" +
    "        \"blogId\": \"2\", \n" +
    "        \"commentId\": \"2\", \n" +
    "        \"value\": \"你好2！！！\"\n" +
    "    }, \n" +
    "    {\n" +
    "        \"blogId\": \"3\", \n" +
    "        \"commentId\": \"3\", \n" +
    "        \"value\": \"你好3！！！\"\n" +
    "    }, \n" +
    "    {\n" +
    "        \"blogId\": \"4\", \n" +
    "        \"commentId\": \"4\", \n" +
    "        \"value\": \"你好4！！！\"\n" +
    "    }\n" +
    "]"
$(function () {
    sends();
    window.setInterval(sends, 3000);
})

/*弹幕1*/
var oVideoBox = document.querySelector('.videoBox')
function sends() {
    var danmusJSON = JSON.parse(danmus);
    danmusJSON.forEach(function (value, index, array) {
        add(value.value);
    });
}

function add(content) {
    if (!content) {
        alert('sss');
        return
    }
    var oSpan = document.createElement('span');
    oSpan.className = 'danmu';
    oSpan.innerHTML = content;
    oSpan.style.fontSize = 15 + Math.floor(Math.random() * 5) + 'px';

    var r = Math.floor(Math.random() * 254);
    var g = Math.floor(Math.random() * 254);
    var b = Math.floor(Math.random() * 254);
    oSpan.style.color = "rgb(" + r + "," + g + "," + b + ")";
    oVideoBox.appendChild(oSpan);
    var maxTop = oVideoBox.clientHeight - oSpan.offsetHeight;
    oSpan.style.top = Math.round(Math.random() * maxTop) + 'px';
    // oSpan.style.left = $(".videoBox").offset().left+"px";
    // console.log($(".videoBox").offset().left+"px")
    // console.log( maxTop,oSpan.offsetHeight);

    var timer = setInterval(() => {
        var start = oSpan.offsetLeft;
        start -= 1;
        // console.log(start);
        oSpan.style.left = start + 'px';
        // console.log(start)
        if (start < -oSpan.offsetWidth) {
            clearInterval(timer);
            oSpan.remove();
        }
    }, 20);
}
/*弹幕1*/
