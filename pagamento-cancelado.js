document.getElementById("retry").addEventListener("click", async () => {
  const button = document.getElementById("retry");
  const errorEl = document.getElementById("error");
  const email = document.getElementById("email").value.trim();
  const password = document.getElementById("password").value;
  errorEl.textContent = "";
  if (!email || !password) {
    errorEl.textContent = "Informe e-mail e senha.";
    return;
  }
  button.disabled = true;
  button.textContent = "Gerando novo pagamento...";
  try {
    const res = await fetch("/api/checkout/resume", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, password }),
    });
    const data = await res.json();
    if (data.checkoutUrl) {
      window.location.href = data.checkoutUrl;
      return;
    }
    errorEl.textContent = data.error || "Não foi possível gerar um novo pagamento.";
  } catch (error) {
    errorEl.textContent = "Erro de comunicação com o servidor.";
  }
  button.disabled = false;
  button.textContent = "Tentar pagamento novamente";
});
