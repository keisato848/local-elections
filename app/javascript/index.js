'use strict';
if (location.pathname === '/'){
  window.addEventListener('load', () => {
    // 新着情報エリア
    const update_title = document.querySelectorAll('.update-title li');
    update_title.forEach(clickedItem => {
      clickedItem.addEventListener('click',() => {
        update_title.forEach(item => {
          item.classList.remove('update-active')
        });
        clickedItem.classList.add('update-active');
      });
    });
    
    const update_content = document.querySelectorAll('.update-content');
    const new_title = document.getElementById('new');
    const new_content = document.getElementById('new-content');
    
    new_title.addEventListener('click', () => {
      update_content.forEach(item => {
        item.setAttribute('style', 'display: none')
      });
      new_content.setAttribute('style', 'display: block')
    });
    
    const election_title = document.getElementById('election');
    const election_content = document.getElementById('election-content');
    election_title.addEventListener('click', () => {
      update_content.forEach(item => {
        item.setAttribute('style', 'display: none')
      });
      election_content.setAttribute('style', 'display: block')
    });
    
    const info_title = document.getElementById('info');
    const info_content = document.getElementById('info-content');
    info_title.addEventListener('click', () => {
      update_content.forEach(item => {
        item.setAttribute('style', 'display: none')
      });
      info_content.setAttribute('style', 'display: block')
    });
    // 新着情報エリア
  });
};