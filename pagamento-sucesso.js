const params = new URLSearchParams(window.location.search);
const sessionId = params.get("session_id");
const iconEl = document.getElementById("icon");
const titleEl = document.getElementById("title");
const messageEl = document.getElementById("message");
const actionEl = document.getElementById("action");

async function checkStatus(attempt) {
  if (!sessionId) {
    iconEl.textContent = "⚠️";
    titleEl.textContent = "Sessão de pagamento não encontrada";
    messageEl.textContent = "Volte à página de cadastro e tente novamente.";
    return;
  }
  try {
    const res = await fetch(`/api/billing/status?session_id=${encodeURIComponent(sessionId)}`);
    const data = await res.json();
    if (data.active) {
      iconEl.textContent = "✅";
      titleEl.textContent = "Pagamento realizado com sucesso!";
      messageEl.textContent = "Sua assinatura foi ativada.";
      actionEl.innerHTML = '<a class="button" href="/">Acessar meu sistema</a>';
      return;
    }
    if (data.pending && attempt < 15) {
      setTimeout(() => checkStatus(attempt + 1), 2000);
      return;
    }
    iconEl.textContent = "⚠️";
    titleEl.textContent = "Ainda processando";
    messageEl.textContent = "O pagamento pode levar alguns instantes para ser confirmado. Você pode tentar fazer login em breve.";
    actionEl.innerHTML = '<a class="button" href="/">Ir para o login</a>';
  } catch (error) {
    iconEl.textContent = "⚠️";
    titleEl.textContent = "Não foi possível confirmar agora";
    messageEl.textContent = "Tente novamente em instantes.";
  }
}
checkStatus(0);
