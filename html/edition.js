// edition.js – Choice-Toggle für die digitale Edition

document.addEventListener("DOMContentLoaded", function () {

  // Choice-Toggle: Original - Normalisiert 

  var toggleBtn  = document.getElementById("toggle-choice");
  var choiceLabel = document.getElementById("choice-label");
  var showOrig = true; //Original-Text standardmäßig anzeigen

  function applyChoice() {
    var origSpans = document.querySelectorAll(".orig-text");
    var regSpans  = document.querySelectorAll(".reg-text");

    origSpans.forEach(function (el) { el.style.display = showOrig ? "inline" : "none"; });
    regSpans.forEach(function  (el) { el.style.display = showOrig ? "none"   : "inline"; });

    if (choiceLabel) {
      choiceLabel.textContent = showOrig ? " [Original]" : " [Normalisiert]";
    }
  }

  if (toggleBtn) {
    toggleBtn.addEventListener("click", function () {
      showOrig = !showOrig;
      applyChoice();
    });
  }

  // Original-Zustand beim Laden setzen
  applyChoice();

});
