async function initAuthUI() {
  const slot = document.getElementById('auth-slot');
  if (!slot) return;
  const { data: { session } } = await sb.auth.getSession();
  if (session) {
    slot.innerHTML =
      '<span style="font-size:13px;color:var(--text-dim);margin-right:10px">' + session.user.email + '</span>' +
      '<button class="btn" id="logout-btn">Выйти</button>';
    document.getElementById('logout-btn').onclick = async () => {
      await sb.auth.signOut();
      location.href = 'index.html';
    };
  } else {
    slot.innerHTML = '<a href="auth.html" class="btn btn-primary">Вход / Регистрация</a>';
  }
}
initAuthUI();
