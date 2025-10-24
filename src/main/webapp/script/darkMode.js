/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


const html = document.documentElement;
const btnDark = document.querySelector("#btn-dark")
if (html.classList.contains('dark')) {
    btnDark.innerHTML = `<img class="size-6" src="https://img.icons8.com/?size=100&id=45475&format=png&color=ffffff" alt="do-not-disturb-2"/>`
} else {
    btnDark.innerHTML = `<img class="size-6" src="https://img.icons8.com/external-glyph-silhouettes-icons-papa-vector/78/external-Light-Mode-interface-glyph-silhouettes-icons-papa-vector.png" alt="external-Light-Mode-interface-glyph-silhouettes-icons-papa-vector"/>`
}
function toggleDarkMode() {
    html.classList.toggle('dark');
    if (html.classList.contains('dark')) {
        btnDark.innerHTML = `<img class="size-6" src="https://img.icons8.com/?size=100&id=45475&format=png&color=ffffff" alt="do-not-disturb-2"/>`
    } else {
        btnDark.innerHTML = `<img class="size-6" src="https://img.icons8.com/external-glyph-silhouettes-icons-papa-vector/78/external-Light-Mode-interface-glyph-silhouettes-icons-papa-vector.png" alt="external-Light-Mode-interface-glyph-silhouettes-icons-papa-vector"/>`
    }
    localStorage.setItem('theme', html.classList.contains('dark') ? 'dark' : 'light');
}