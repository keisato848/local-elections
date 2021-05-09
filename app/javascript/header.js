'use strict';
if (location.pathname === '/'){
  window.addEventListener('load', () => {
    
    // 投稿リンク
    const manifestSession = document.getElementById('manifest-session');
    const postLinkBtn = document.getElementById('post-link-btn');
    const postLink = document.getElementById('post-link');

    manifestSession.addEventListener('mouseover', () => {
      // postLink.classList.add('post-link-active');
      console.log('hoge');
      postLink.classList.add('post-link-active');
    });

    manifestSession.addEventListener('mouseout', () => {
      // postLink.classList.add('post-link-active');
      console.log('hoge');
      postLink.classList.remove('post-link-active');
    });


    // ハンバーガーメニュー
    const openMenu = document.getElementById('open-menu');
    const closeMenu = document.getElementById('close-menu');
    const menuList = document.getElementById('hidden-menu-list');
    
    openMenu.addEventListener('click', () => {
      menuList.setAttribute('style', 'display: block');
    });
    
    closeMenu.addEventListener('click', () => {
      menuList.removeAttribute('style', 'display: block');
    });
    
    // 地域選択タブ
    const prefectureLink = document.querySelectorAll('.region-tab li');
    
    prefectureLink.forEach(clickedItem => {
      clickedItem.addEventListener('click',() => {
        prefectureLink.forEach(item => {
          item.classList.remove('active');
        });
        clickedItem.classList.add('active');
      });
    });
    
    // 都道府県リスト
    const prefectureList = document.querySelectorAll('.hidden ul');
    
    // 北海道・東北
    const hokkaido = document.getElementById('hokkaido-tohoku');
    const hokkaidoTohokuList = document.getElementById('hokkaido-tohoku-list');
    
    hokkaido.addEventListener('click', () => {
      prefectureList.forEach(item => {
        item.setAttribute('style', 'display: none');
      });
      hokkaidoTohokuList.setAttribute('style', 'display: flex');
    });
    
    // 関東
    const kanto = document.getElementById('kanto');
    const kantoList = document.getElementById('kanto-list');
    
    kanto.addEventListener('click', () => {
      prefectureList.forEach(item => {
        item.setAttribute('style', 'display: none');
      });
      kantoList.setAttribute('style', 'display: flex');
    });
    
    // 中部
    const chubu = document.getElementById('chubu');
    const chubuList = document.getElementById('chubu-list');
    
    chubu.addEventListener('click', () => {
      prefectureList.forEach(item => {
        item.setAttribute('style', 'display: none');
      });
      chubuList.setAttribute('style', 'display: flex');
    });
    
    // 近畿
    const kinki = document.getElementById('kinki');
    const kinkiList = document.getElementById('kinki-list');
    
    kinki.addEventListener('click', () => {
      prefectureList.forEach(item => {
        item.setAttribute('style', 'display: none');
      });
      kinkiList.setAttribute('style', 'display: flex');
    });
    
    //  四国
    const chugokuShikoku = document.getElementById('chugoku-shikoku');
    const chugokuShikokuList = document.getElementById('chugoku-shikoku-list');
    
    chugokuShikoku.addEventListener('click', () => {
      prefectureList.forEach(item => {
        item.setAttribute('style', 'display: none');
      });
      chugokuShikokuList.setAttribute('style', 'display: flex');
    });
    
    // 九州・沖縄
    const kyushuOkinawa = document.getElementById('kyushu-okinawa');
    const kyushuOkinawaList = document.getElementById('kyushu-okinawa-list');
    
    kyushuOkinawa.addEventListener('click', () => {
      prefectureList.forEach(item => {
        item.setAttribute('style', 'display: none');
      });
      kyushuOkinawaList.setAttribute('style', 'display: flex');
    });
    
    // 閉じるボタン
    const closeBtn = document.querySelectorAll('.close-btn');
    
    closeBtn.forEach(btn => {
      btn.addEventListener('click', () => {
        prefectureLink.forEach(item => {
          item.classList.remove('active');
        });
        prefectureList.forEach(item => {
          item.setAttribute('style', 'display: none');
        });
      });
    });
    
  });
  
};