/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */
/*
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

function hideNavs() {
    let navs = document.querySelectorAll('[data-a11y-toggle] + nav');
    navs.forEach((nav) => {
        if (!nav.hasAttribute('hidden')) {
            nav.previousElementSibling.setAttribute('aria-expanded', 'false');
            nav.setAttribute('hidden', 'true');
        }
    });
}
const navToggle = document.querySelectorAll('[data-a11y-toggle]');
navToggle.forEach((toggle) => {
      let navList = toggle.nextElementSibling;
      let navLinks = navList.querySelectorAll('a');
      toggle.addEventListener('click', (event) => {
          if (navList.hasAttribute('hidden')) {
              toggle.setAttribute('aria-expanded', 'true');
              navList.removeAttribute('hidden');
              // Set focus on first link
              // will be highlighted for keyboard users
              navLinks[0].focus();
          } else {
              navList.setAttribute('hidden', 'true');
              toggle.setAttribute('aria-expanded', 'false');
          }
          event.stopPropagation();
    }, false);
});
document.addEventListener('keydown', (event) => {
    // Ignore IME composition
    if (event.isComposing || event.keyCode === 229) {
        return;
    }

    // Close menu with ESC key
    if (event.keyCode === 27) {
        hideNavs();
    }
}, false);
document.addEventListener('click', (event) => {
    // close navigation menus when clicking anywhere (except when on mobile)
    if (event.target.closest('[data-a11y-toggle] + nav') || Math.max(document.documentElement.clientWidth, window.innerWidth || 0) < 960) return
    hideNavs();
})

/* vim:set shiftwidth=4 softtabstop=4 expandtab cinoptions=b1,g0,N-s cinkeys+=0=break: */
