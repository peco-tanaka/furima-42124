function calc () {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  console.log("価格入力欄", priceInput);

  if (!priceInput || !addTaxPrice || !profit) {
    console.log("必要な要素が見つかりません");
    return
  };

  console.log("必要な要素を全て検出しました:")

  const handleInput = () => {
    const price = parseInt(priceInput.value);
    console.log("入力された値:", price);

    if (isNaN(price)) {
      console.log("有効な数値ではありません");
      addTaxPrice.textContent = 0;
      profit.textContent = 0;
      return;
    };

    const fee = Math.floor(price * 0.1);
    console.log("計算された手数料:", fee);

    const salesProfit =price - fee;
    console.log("計算された利益", salesProfit);

    addTaxPrice.textContent = fee;
    profit.textContent = salesProfit;
  };

  priceInput.addEventListener('input', handleInput);
};



window.addEventListener('turbo:load', calc);