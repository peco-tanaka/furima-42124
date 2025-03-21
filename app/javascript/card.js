const pay = () => {
  if (typeof gon === "undefined") return;

  const publicKey = gon.public_key
  const payjp = Payjp(publicKey);

  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById("charge-form");

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        const errorInput = document.createElement("input");
        errorInput.setAttribute('type', 'hidden');
        errorInput.setAttribute('name', 'token');
        errorInput.setAttribute('value', "");
        form.appendChild(errorInput);

        form.submit();
      } else {
        const token = response.id;
        const tokenInput = document.createElement("input");
        tokenInput.setAttribute('type', 'hidden');
        tokenInput.setAttribute('name', 'token');
        tokenInput.setAttribute('value', token);
        form.appendChild(tokenInput);

        form.submit();
      };
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);