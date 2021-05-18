'use strict';

if (location.pathname.match('assemblymen')) {
  window.addEventListener('load', () => {
    const searchBtn = document.getElementById('search-btn');
    const searchForm = document.getElementById('search-form');
    const closeBtn = document.getElementById('close-btn')
    searchBtn.addEventListener('click', () => {
      searchBtn.classList.add('search-btn-active');
      searchForm.classList.remove('search-hidden');
    });
    closeBtn.addEventListener('click', () => {
      searchBtn.classList.remove('search-btn-active');
      searchForm.classList.add('search-hidden');
    });
  });
};