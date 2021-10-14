function incrementValue(e) {
    e.preventDefault();
    var plusButton = e.target;
    var quantity = plusButton.parentNode.querySelector(".quantity-field");
    console.log(plusButton.parentNode)
    var currentVal = parseInt(quantity.value);
    if (!isNaN(currentVal)) {
        quantity.value = currentVal + 1;
    } else {
        quantity.value = 1;
    }
    // updateBagCount(parseInt(quantity.value));
}
function updateBagCount(x){
    document.getElementsByClassName("shopping-bag__count")[0].innerText= x + "";
}
function decrementValue(e) {
    e.preventDefault();
    var plusButton = e.target;
    var quantity = plusButton.parentNode.querySelector(".quantity-field");
    console.log(quantity);
    var currentVal = parseInt(quantity.value);
    if (!isNaN(currentVal) && currentVal > 1) {
        quantity.value = currentVal - 1;
    } else {
        quantity.value = 1;
    }
    // updateBagCount(parseInt(quantity.value));
}
document.querySelector(".button-plus").addEventListener("click", function (e) {
    incrementValue(e);
})
document.querySelector(".button-minus").addEventListener("click", function (e) {
    decrementValue(e);
})
document.querySelector(".add-to-cart").addEventListener("click", function (e) {
    var quantity = document.querySelector(".quantity-field");
    updateBagCount(parseInt(quantity.value));
})