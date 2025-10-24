/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
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

    if (result) {
        window.location.href = `${window.location.hostname}/user/${status}?id=${id}`;
    } else {
        event.preventDefault();
    }
}