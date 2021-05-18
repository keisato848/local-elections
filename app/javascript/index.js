'use strict';
if (location.pathname === '/'){
  window.addEventListener('load', () => {
    // 新着情報エリア
    const updateTitle = document.querySelectorAll('.update-title li');
    updateTitle.forEach(clickedItem => {
      clickedItem.addEventListener('click',() => {
        updateTitle.forEach(item => {
          item.classList.remove('update-active')
        });
        clickedItem.classList.add('update-active');
      });
    });
    
    const updateContent = document.querySelectorAll('.update-content');
    const manifestTitle = document.getElementById('manifest');
    const manifestContent = document.getElementById('manifest-content');
    
    manifestTitle.addEventListener('click', () => {
      updateContent.forEach(item => {
        item.setAttribute('style', 'display: none')
      });
      manifestContent.setAttribute('style', 'display: block')
    });
    
    const questionTitle = document.getElementById('question');
    const questionContent = document.getElementById('question-content');
    questionTitle.addEventListener('click', () => {
      updateContent.forEach(item => {
        item.setAttribute('style', 'display: none')
      });
      questionContent.setAttribute('style', 'display: block')
    });
    
    const infoTitle = document.getElementById('info');
    const infoContent = document.getElementById('info-content');
    infoTitle.addEventListener('click', () => {
      updateContent.forEach(item => {
        item.setAttribute('style', 'display: none')
      });
      infoContent.setAttribute('style', 'display: block')
    });
    // 新着情報エリア
  });
};