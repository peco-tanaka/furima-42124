const calc = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");


  if (!priceInput || !addTaxPrice || !profit) {
    return
  };

  const handleInput = () => {
    const price = parseInt(priceInput.value);

    if (isNaN(price)) {
      addTaxPrice.textContent = 0;
      profit.textContent = 0;
      return;
    };

    const fee = Math.floor(price * 0.1);

    const salesProfit =price - fee;

    addTaxPrice.textContent = fee;
    profit.textContent = salesProfit;
  };

  priceInput.addEventListener('input', handleInput);
};

window.addEventListener('turbo:load', calc);
window.addEventListener('turbo:render', calc);