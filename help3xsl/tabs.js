/*
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

function tabs(a, g, j) {
    document.body.className = "js-on";
    var g = a.getElementsByTagName(g),
        d = [],
        c;
    this.active;
    this.total = g.length;
    this.container = a;
    e = a.insertBefore(document.createElement("nav"), g[0]), change = function (f) {
        if (typeof this.active !== "undefined") {
            d[this.active].className = g[this.active].className = ""
        }
        d[f].className = g[f].className = "active";
        this.active = f
    }, clickEvent = function (h, f) {
        h.onclick = function () {
            change(f);
            return false
        }
    };
    for (var b = 0; b < g.length; b++) {
        d[b] = e.appendChild(document.createElement("a"));
        d[b].href = "#";
        c = [g[b].getAttribute("data-title"), g[b].getElementsByTagName(j)[0]];
        d[b].innerHTML = c[0] !== null ? c[0] : c[1] ? c[1]["innerText" || "textContent"] : b + 1;
        new clickEvent(d[b], b)
    }
    change(0)
}
tabs.prototype.change = function (b) {
    change(b - 1)
};
tabs.prototype.next = function (b) {
    active === this.total - 1 ? change(0) : change(active + 1)
};
tabs.prototype.prev = function (b) {
    active === 0 ? change(this.total - 1) : change(active - 1)
};
tabs.prototype.responsive = function (d, c) {
    nav = document.createElement("nav");
    nav.id = "mobiles";
    nav.innerHTML = '<a href="#" onclick="' + d + '.prev(); return false">' + c.prev + '</a><a href="#" onclick="' + d + '.next(); return false">' + c.next + "</a>";
    this.container.insertBefore(nav, this.container.firstChild);
    return this
};
