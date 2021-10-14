document.getElementsByClassName("switch-to-sign-in")[0].addEventListener("click", function(e){
    document.getElementsByClassName("switch-to-sign-up")[0].classList.remove("active-show-after");
    this.classList.add("active-show-after");
})
document.getElementsByClassName("switch-to-sign-up")[0].addEventListener("click", function(e){
    document.getElementsByClassName("switch-to-sign-in")[0].classList.remove("active-show-after");
    this.classList.add("active-show-after");
})