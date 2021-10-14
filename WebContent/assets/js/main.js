const swiper = new Swiper('.swiper.swiper-1', {
  // Optional parameters
  direction: 'horizontal',
  loop: true,

  // If we need pagination
  pagination: {
    el: '.swiper-pagination',
    clickable: true,
  },

  // Navigation arrows
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },

  autoplay: {
    delay: 4000,
    disableOnInteraction: false,
  },

  effect: "fade",
  fadeEffect: {
    crossFade: true
  },
});
const swiper2 = new Swiper('.swiper.swiper-2', {
  // Optional parameters
  direction: 'horizontal',
  loop: true,

  // If we need pagination
  pagination: {
    el: '.swiper-pagination',
    clickable: true,
  },

  // Navigation arrows
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },

});

// header

document.querySelector(".mobile-menu-button").addEventListener("click", function (e) {
  if (this.classList.contains("active")) {
    this.classList.remove("active");
    document.querySelector(".nav__bottom").classList.remove("active");
    document.querySelector(".overcoat").classList.remove("active");
    return;
  } else {
    this.classList.add("active");
    document.querySelector(".nav__bottom").classList.add("active");
    document.querySelector(".overcoat").classList.add("active");
  }
});

window.onscroll = function (e) {
  var scrollTop = window.pageYOffset || (document.documentElement || document.body.parentNode || document.body).scrollTop;
  if (scrollTop > 73) {
    if (document.querySelector(".nav__top").style.top === "-32px") {
      return;
    }
    document.querySelector(".nav__middle-left").style.boxShadow = "0px 0px 4px -2px"
    document.querySelector(".nav__top").style.transition = "all .3s ease-out";
    document.querySelector(".nav__top").style.top = "-32px";
    document.querySelector(".nav__middle-left").style.transition = "all .3s ease-out";
    document.querySelector(".nav__middle-left").style.top = 0;
    document.querySelector(".nav__log-in").style.transition = "all .3s ease-out";
    document.querySelector(".nav__log-in").style.top = 0;
    document.querySelector(".nav__bottom").style.transition = "all .3s ease-out";
    document.querySelector(".nav__bottom").style.top = 105 - 34.4 + "px";
    document.querySelector(".mobile-menu-button").style.transition = "all .3s ease-out";
    document.querySelector(".mobile-menu-button").style.top = "6px";
  } else {
    if (document.querySelector(".nav__top").style.top === "0px") {
      return;
    }
    document.querySelector(".nav__middle-left").style.boxShadow = "unset";
    document.querySelector(".nav__top").style.transition = "all .3s ease-out";
    document.querySelector(".nav__top").style.top = "0px";
    document.querySelector(".nav__middle-left").style.transition = "all .3s ease-out";
    document.querySelector(".nav__middle-left").style.top = "32px";
    document.querySelector(".nav__log-in").style.transition = "all .3s ease-out";
    document.querySelector(".nav__log-in").style.top = "32px";
    document.querySelector(".nav__bottom").style.transition = "all .3s ease-out";
    document.querySelector(".nav__bottom").style.top = "105px";
    document.querySelector(".mobile-menu-button").style.transition = "all .3s ease-out";
    document.querySelector(".mobile-menu-button").style.top = "38px";
  }
}
var submenuContainers = document.querySelectorAll(".nav__submenu-container.flex-1");
for (var i = 0; i < submenuContainers.length; i++) {
  submenuContainers[i].addEventListener("click", function (e) {
    var parent = e.target;
    while (true) {
      if (parent.classList.contains("nav__submenu-container") && parent.classList.contains("relative")) {
        break;
      } else {
        parent = parent.parentNode;
      }
    }
    console.log(parent)
    if (parent.querySelector(".submenu").classList.contains("active")) {
      parent.querySelector(".submenu").classList.remove("active");
      return;
    } else {
      parent.querySelector(".submenu").classList.add("active");
    }
  })
}