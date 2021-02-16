'use strict';

window.addEventListener('load', () => {

  // 地域選択タブ
  const prefecture_link = document.querySelectorAll('.region-tab li')

  prefecture_link.forEach(clickedItem => {
    clickedItem.addEventListener('click',() => {
      prefecture_link.forEach(item => {
        item.classList.remove('active')
      });
      clickedItem.classList.add('active');
    });
  });

  // 都道府県リスト
  const prefecture_list = document.querySelectorAll('.hidden div')
  
  // 北海道・東北
  const hokkaido = document.getElementById('hokkaido-tohoku');
  const hokkaido_tohoku_list = document.getElementById('hokkaido-tohoku-list');
  
  hokkaido.addEventListener('click', () => {
    prefecture_list.forEach(item => {
      item.setAttribute('style', 'display: none')
    });
    hokkaido_tohoku_list.setAttribute('style', 'display: block')
  });

  const hokkaido_tohoku_close = document.getElementById('hokkaido-tohoku-close');
  
  hokkaido_tohoku_close.addEventListener('click', () => {
    prefecture_list.forEach(item => {
      item.setAttribute('style', 'display: none')
    });
  });

  // 関東
  const kanto = document.getElementById('kanto');
  const kanto_list = document.getElementById('kanto-list');
  
  kanto.addEventListener('click', () => {
    prefecture_list.forEach(item => {
      item.setAttribute('style', 'display: none')
    });
    kanto_list.setAttribute('style', 'display: block')
  });

  const kanto_close = document.getElementById('kanto-close');
  
  kanto_close.addEventListener('click', () => {
    prefecture_list.forEach(item => {
      item.setAttribute('style', 'display: none')
    });
  });
  
  // 中部
  const chubu = document.getElementById('chubu');
  const chubu_list = document.getElementById('chubu-list');
  
  chubu.addEventListener('click', () => {
    prefecture_list.forEach(item => {
      item.setAttribute('style', 'display: none')
    });
    chubu_list.setAttribute('style', 'display: block')
  });

  const chubu_close = document.getElementById('chubu-close');
  
  chubu_close.addEventListener('click', () => {
    prefecture_list.forEach(item => {
      item.setAttribute('style', 'display: none')
    });
  });
  
  // 近畿
  const kinki = document.getElementById('kinki');
  const kinki_list = document.getElementById('kinki-list');
  
  kinki.addEventListener('click', () => {
    prefecture_list.forEach(item => {
      item.setAttribute('style', 'display: none')
    });
    kinki_list.setAttribute('style', 'display: block')
  });
  
  const kinki_close = document.getElementById('kinki-close');

  kinki_close.addEventListener('click', () => {
    prefecture_list.forEach(item => {
      item.setAttribute('style', 'display: none')
    });
  });
  
  //  四国
  const chugoku_shikoku = document.getElementById('chugoku-shikoku');
  const chugoku_shikoku_list = document.getElementById('chugoku-shikoku-list');
  
  chugoku_shikoku.addEventListener('click', () => {
    prefecture_list.forEach(item => {
      item.setAttribute('style', 'display: none')
    });
    chugoku_shikoku_list.setAttribute('style', 'display: block')
  });
  
  const chugoku_shikoku_close = document.getElementById('chugoku-shikoku-close');

  chugoku_shikoku_close.addEventListener('click', () => {
    prefecture_list.forEach(item => {
      item.setAttribute('style', 'display: none')
    });
  });
  
  // 九州・沖縄
  const kyushu_okinawa = document.getElementById('kyushu-okinawa');
  const kyushu_okinawa_list = document.getElementById('kyushu-okinawa-list');
  
  kyushu_okinawa.addEventListener('click', () => {
    prefecture_list.forEach(item => {
      item.setAttribute('style', 'display: none')
    });
    kyushu_okinawa_list.setAttribute('style', 'display: block')
  });
  
  const kyushu_okinawa_close = document.getElementById('kyushu-okinawa-close');

  kyushu_okinawa_close.addEventListener('click', () => {
    prefecture_list.forEach(item => {
      item.setAttribute('style', 'display: none')
    });
  });

});
