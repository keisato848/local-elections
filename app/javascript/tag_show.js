'use strict';

if (location.pathname.match('tags')){
  window.addEventListener('load', () => {
    // タブの切り替え
    const tagTab = document.querySelectorAll('.tag-tab li');
    tagTab.forEach(clickedItem => {
      clickedItem.addEventListener('click',() => {
        tagTab.forEach(item => {
          item.classList.remove('active-tab')
        });
        clickedItem.classList.add('active-tab');
      });
    });

    // リストの表示切り替え
    const manifestTab = document.getElementById('tag-manifest-tab');
    const questionTab = document.getElementById('tag-question-tab');
    const manifestList = document.getElementById('manifest-list');
    const questionList = document.getElementById('question-list');
    
    manifestTab.addEventListener('click', () => {
      questionList.classList.remove('active-list');
      manifestList.classList.add('active-list');
    });
    
    questionTab.addEventListener('click', () => {
      manifestList.classList.remove('active-list');
      questionList.classList.add('active-list');
    });
  });
};