'use strict';

window.addEventListener('load', () => {
  function fadeOut(node, duration) {
    node.style.opacity = 1;

    var start = performance.now();
    
    requestAnimationFrame(function tick(timestamp) {
      // イージング計算式（linear）
      var easing = (timestamp - start) / duration;

      // opacityが0より小さくならないように
      node.style.opacity = Math.max(1 - easing, 0);
      
      // イージング計算式の値が1より小さいとき
      if (easing < 1) {
        requestAnimationFrame(tick);
      } else {
        node.style.opacity = '';
        node.style.display = 'none';
      }
    });
  }
  fadeOut(document.getElementById('flash-message'), 6000);
});
