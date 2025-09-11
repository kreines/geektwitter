console.log("✅ application.js loaded!");

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "./controllers/comment_toggle"

console.log("✅ application.js loaded!");

// Turboのロードイベントにする
document.addEventListener("turbo:load", () => { 
  const checkbox = document.getElementById("completed-toggle"); 
  const status = document.getElementById("completed-status"); 
  if (!checkbox || !status) return; // 要素がなければ処理しない 
  const updateStatus = () => { console.log("checked?", checkbox.checked); 
    if (checkbox.checked) { status.textContent = "完成"; } 
    else { status.textContent = "未完成"; } }; updateStatus(); // 初期表示を反映 
    checkbox.addEventListener("change", updateStatus); });

document.addEventListener("turbo:load", () => {
  const modal = document.getElementById("comment-modal");
  const modalBody = document.getElementById("comment-modal-body");
  const closeBtn = modal.querySelector(".modal-close");

  // コメントボタンでモーダル表示
  document.querySelectorAll(".open-comment-modal").forEach(btn => {
    btn.addEventListener("click", async (e) => {
      e.preventDefault();

      const tweetId = btn.dataset.tweetId;
      const from = btn.dataset.from || "home"; // ← ここで判定

      try {
        const res = await fetch(`/tweets/${tweetId}/comments_list?from=${from}`);
        const html = await res.text();

        modalBody.innerHTML = html;
        modal.dataset.from = from; // ← モーダルに保持

        const textarea = modalBody.querySelector("textarea");
        if (textarea) textarea.classList.add("comment-textarea");

        modal.classList.remove("hidden");
      } catch (err) {
        console.error("コメント取得エラー:", err);
      }
    });
  });

  // モーダル閉じる
  closeBtn.addEventListener("click", () => modal.classList.add("hidden"));
  modal.querySelector(".modal-overlay").addEventListener("click", () => modal.classList.add("hidden"));

  // コメント送信後
  modalBody.addEventListener("turbo:submit-end", (e) => {
    if (!e.detail.success) return;

    const from = modal.dataset.from; // ← 保存しておいた値を利用
    modal.classList.add("hidden");

    // 遷移先を分岐
    if (from === "mypage") {
  window.location.href = `/users/${CURRENT_USER_ID}`;
} else {
  window.location.href = "/tweets";
}

  });
});

  



