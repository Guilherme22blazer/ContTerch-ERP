const token = sessionStorage.getItem('simplescalc.apiToken') || '';
const plansEl = document.getElementById('plans');
const topError = document.getElementById('topError');

function showTopError(message) {
  topError.textContent = message;
  topError.style.display = 'block';
}

function escapeHtml(value) {
  return String(value ?? '').replace(/[&<>"']/g, (c) => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
}

async function resolvePriceFromProduct(productId, wantedInterval) {
  const res = await fetch(`/api/admin/stripe/resolve-price?productId=${encodeURIComponent(productId)}`, {
    headers: { 'Authorization': 'Bearer ' + token },
  });
  const data = await res.json();
  if (!res.ok) throw new Error(data.error || 'Falha ao consultar o Stripe.');
  const prices = data.prices || [];
  const match = prices.find((p) => p.interval === wantedInterval) || prices[0];
  if (!match) throw new Error('Nenhuma price ativa encontrada para este Product ID.');
  return match.id;
}

async function loadPlans() {
  if (!token) {
    showTopError('Você precisa estar logado. Abra o sistema em outra aba, faça login como administrador e recarregue esta página.');
    return;
  }
  let data;
  try {
    const res = await fetch('/api/admin/access-management', { headers: { 'Authorization': 'Bearer ' + token } });
    data = await res.json();
    if (!res.ok) throw new Error(data.error || 'Falha ao carregar planos.');
  } catch (error) {
    showTopError(error.message);
    return;
  }
  plansEl.innerHTML = '';
  for (const plan of data.plans || []) {
    const card = document.createElement('div');
    card.className = 'card';
    card.innerHTML = `
      <h2>${escapeHtml(plan.name)}</h2>
      <div class="price">Mensal: R$ ${Number(plan.monthlyValue).toFixed(2)} · Anual: R$ ${Number(plan.annualValue).toFixed(2)}</div>
      <label>Price ID mensal (Stripe)</label>
      <input type="text" class="monthly" placeholder="price_..." value="${escapeHtml(plan.stripePriceIdMonthly)}">
      <label>Price ID anual (Stripe)</label>
      <input type="text" class="yearly" placeholder="price_..." value="${escapeHtml(plan.stripePriceIdYearly)}">
      <label>Product ID (Stripe, opcional — ou cole aqui e clique em "Buscar Price ID" se só tiver o Product ID)</label>
      <input type="text" class="product" placeholder="prod_..." value="${escapeHtml(plan.stripeProductId)}">
      <br><button class="resolve" type="button">Buscar Price ID a partir do Product ID</button>
      <button class="save">Salvar</button>
      <div class="status"></div>
    `;
    const monthlyInput = card.querySelector('.monthly');
    const yearlyInput = card.querySelector('.yearly');
    const productInput = card.querySelector('.product');
    const statusEl = card.querySelector('.status');
    const button = card.querySelector('.save');
    const resolveButton = card.querySelector('.resolve');
    resolveButton.addEventListener('click', async () => {
      const productId = productInput.value.trim();
      if (!productId) { statusEl.className = 'status err'; statusEl.textContent = 'Cole o Product ID (prod_...) primeiro.'; return; }
      resolveButton.disabled = true;
      statusEl.className = 'status';
      statusEl.textContent = 'Buscando no Stripe...';
      try {
        const monthlyPrice = await resolvePriceFromProduct(productId, 'month');
        monthlyInput.value = monthlyPrice;
      } catch (error) {
        // este Product ID pode ser só o da versão anual; tenta preencher o anual abaixo mesmo assim
      }
      try {
        const yearlyPrice = await resolvePriceFromProduct(productId, 'year');
        yearlyInput.value = yearlyPrice;
        statusEl.className = 'status ok';
        statusEl.textContent = 'Price ID(s) encontrado(s). Confira os campos e clique em Salvar.';
      } catch (error) {
        if (!monthlyInput.value) { statusEl.className = 'status err'; statusEl.textContent = error.message; }
        else { statusEl.className = 'status ok'; statusEl.textContent = 'Price ID encontrado. Confira os campos e clique em Salvar.'; }
      }
      resolveButton.disabled = false;
    });
    button.addEventListener('click', async () => {
      button.disabled = true;
      statusEl.className = 'status';
      statusEl.textContent = 'Salvando...';
      try {
        const res = await fetch(`/api/admin/plans/${plan.id}`, {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer ' + token },
          body: JSON.stringify({
            name: plan.name, monthlyValue: plan.monthlyValue, annualValue: plan.annualValue,
            maxUsers: plan.maxUsers, trialDays: plan.trialDays, status: plan.status,
            modules: plan.modules || [],
            stripePriceIdMonthly: monthlyInput.value.trim(),
            stripePriceIdYearly: yearlyInput.value.trim(),
            stripeProductId: productInput.value.trim(),
          }),
        });
        const result = await res.json();
        if (!res.ok) throw new Error(result.error || 'Erro ao salvar.');
        statusEl.className = 'status ok';
        statusEl.textContent = 'Salvo com sucesso.';
      } catch (error) {
        statusEl.className = 'status err';
        statusEl.textContent = error.message;
      }
      button.disabled = false;
    });
    plansEl.appendChild(card);
  }
}
loadPlans();
