/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


/* * Sửa lại: Hàm này chỉ chịu trách nhiệm NGĂN CHẶN nếu người dùng bấm "Cancel".
 * Nếu người dùng bấm "OK", nó không làm gì cả và để cho link href tự chạy.
 */
function confirmBook(id, status) {
    let result;
    if (status === 'borrow') {
        result = confirm(`Are you want to ${status} this book?\nFee: 5.000VND/day
Overdue Fee: 10.000VND/day`);
    } else if (status === 'return') {
        result = confirm(`Are you want to ${status} this book?`);
    } else {
        result = false;
    }

    if (!result) { // Chỉ hành động nếu người dùng bấm "Cancel"
        event.preventDefault();
    }
}