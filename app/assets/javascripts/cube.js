$(document).ready(function() {
  var xAngle = 0, yAngle = 0;
  document.addEventListener('keydown', function(e) {
    switch(e.keyCode) {
      case 37: // left
        yAngle -= 90;
        break;
    //  case 38: // up
    //    xAngle += 90;
    //    break;
      case 39: // right
        yAngle += 90;
        break;
    //  case 40: // down
    //    xAngle -= 90;
    //    break;
    };
    $('#cube').css({
      "webkitTransform" : "rotateX("+xAngle+"deg) rotateY("+yAngle+"deg)",
      "mozTransform" : "rotateX("+xAngle+"deg) rotateY("+yAngle+"deg)",
      "msTransform" : "rotateX("+xAngle+"deg) rotateY("+yAngle+"deg)",
      "OTransform" : "rotateX("+xAngle+"deg) rotateY("+yAngle+"deg)",
      "transform" : "rotateX("+xAngle+"deg) rotateY("+yAngle+"deg)"
    });
  }, false);
  $(document).on('click', 'img', function(e) {
    switch($(this).attr('class')) {
      case 'left': // left
        yAngle -= 90;
        break;
    //  case 'up': // up
    //    xAngle += 90;
    //    break;
      case 'right': // right
        yAngle += 90;
        break;
    //  case 'down': // down
    //    xAngle -= 90;
    //    break;
    };
    $('#cube').css({
      "webkitTransform" : "rotateX("+xAngle+"deg) rotateY("+yAngle+"deg)",
      "mozTransform" : "rotateX("+xAngle+"deg) rotateY("+yAngle+"deg)",
      "msTransform" : "rotateX("+xAngle+"deg) rotateY("+yAngle+"deg)",
      "OTransform" : "rotateX("+xAngle+"deg) rotateY("+yAngle+"deg)",
      "transform" : "rotateX("+xAngle+"deg) rotateY("+yAngle+"deg)"
    });
  });
  cubePosition();
  $(window).resize(function() {
    cubePosition();
  });
});

function cubePosition() {
  $('#camera').css({
    'top' : $(window).height() / 2 - 300
  });
}