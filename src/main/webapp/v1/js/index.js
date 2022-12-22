$(function () {
    getRandomCommentDate();
    window.setInterval(getRandomCommentDate(),40000)

});
$(function () {
    // sends();
    window.setInterval(sends, 4000);
})

/*弹幕1*/
var oVideoBox = document.querySelector('.videoBox')
// function sends() {
//     var danmusJSON = JSON.parse(danmus);
//     danmusJSON.forEach(function (value, index, array) {
//         add(value.value);
//     });
// }

function add(content,href) {
    if (!content) {
        alert('sss');
        return
    }
    var oSpan = document.createElement('a');
    oSpan.className = 'danmu';
    oSpan.innerHTML = content;
    oSpan.href=href
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
