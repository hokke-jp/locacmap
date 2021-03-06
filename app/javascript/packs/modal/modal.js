// モーダル時の背景のスクロール固定設定
function setModal() {
  const triggers = document.getElementsByClassName('grad-trigger');
  const body = document.getElementsByTagName('body');
  for (let i = 0; i < triggers.length; i++){
    triggers[i].addEventListener('click', () => {
      if (triggers[i].checked) {
        const posi = window.pageYOffset;
        body[0].style.position = 'fixed';
        body[0].style.top = `${-1 * posi}` + "px";
        triggers[i].dataset.num = posi;
    
        // iframe読み込みをクリック時のみに設定
        const iframe = triggers[i].nextElementSibling.nextElementSibling.getElementsByTagName('iframe');
        if (iframe[0].src === "about:blank") {
          iframe[0].setAttribute("src", iframe[0].dataset.src);
        }

      } else {
        body[0].style.position = 'static';
        const position = triggers[i].dataset.num;
        scrollTo(0, position);
      }
    });
  }
}
setModal();