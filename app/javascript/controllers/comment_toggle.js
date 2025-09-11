document.addEventListener("turbo:submit-end", function(event) {
  // コメントフォームの送信イベントか確認
  if (event.target.classList.contains("comment-form")) {
    const tweetId = event.target.closest("[id^='comment-modal-']").id.split('-').pop();
    const modal = document.getElementById(`comment-modal-${tweetId}`);
    if (modal) {
      modal.classList.remove("open"); // openクラスを外して閉じる
    }
  }
});

