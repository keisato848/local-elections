if (location.pathname.match('manifests/new')){
  document.addEventListener('DOMContentLoaded', () => {
    const inputElement = document.getElementById('tag-name');
    inputElement.addEventListener('keyup', () => {
      const keyword = document.getElementById('tag-name').value;
      const XHR = new XMLHttpRequest();
      XHR.open('GET', `search/?keyword=${keyword}`, true);
      XHR.responseType = 'json';
      XHR.send();
    });
  });
};