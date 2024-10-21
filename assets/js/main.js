// Hamburger menu
document.addEventListener("DOMContentLoaded", () => {
  const btn = document.getElementById("menu-btn");
  const nav = document.getElementById("menu");

  if (btn) {
    btn.addEventListener("click", () => {
      btn.classList.toggle("open");
      nav.classList.toggle("flex");
      nav.classList.toggle("hidden");
    });
  }
});
