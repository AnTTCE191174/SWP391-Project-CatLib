/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */




const removeVietnameseTones = (str) => {
    return str
            .normalize("NFD") // chuẩn hóa chuỗi (chia ký tự có dấu thành ký tự gốc + dấu)
            .replace(/[\u0300-\u036f]/g, "") // xoá các dấu
            .replace(/đ/g, "d")
            .replace(/Đ/g, "D")
            .toLowerCase(); // không phân biệt hoa thường
};

document.addEventListener("DOMContentLoaded", () => {
    const input = document.getElementById("searchBook");
    const tableBody = document.getElementById("table_body");
    input.addEventListener("input", (e) => {
        const filterBook = dataObj.books.filter((book) =>
            removeVietnameseTones(book.title).includes(removeVietnameseTones(e.target.value))
        );
        const html = filterBook.map((book) => {
            return `<tr
                                    class="bg-gray-300 border border-grey-500 md:border-none block md:table-row"
                                    >
                                    <td
                                        class="p-2 md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        <span class="inline-block w-1/3 md:hidden font-bold">ID:</span>${book.bookId}
                                    </td>
                                    <td
                                        class="p-2 md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        <span class="inline-block w-1/3 md:hidden font-bold"
                                              >Title:</span
                                        >${book.title}
                                    </td>
                                    <td
                                        class="p-2 md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        <span class="inline-block w-1/3 md:hidden font-bold"
                                              >Author:</span
                                        >${book.authorName}
                                    </td>
                                    <td
                                        class="p-2 md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        <span class="inline-block w-1/3 md:hidden font-bold"
                                              >Stock Quantity</span
                                        >${book.stockQuantity}
                                    </td>
                                    <td
                                        class="p-2 md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        <span class="inline-block w-1/3 md:hidden font-bold"
                                              >Actions</span
                                        >
                                        <a
                                            href="${window.location.href}/detail?id=${book.bookId}"
                                            class="bg-stone-500 hover:bg-stone-700 text-white font-bold py-1 px-2 border border-stone-500 rounded inline-block cursor-pointer"
                                            >
                                            Detail
                                        </a>
                                        <a
                                            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-2 border border-blue-500 rounded inline-block cursor-pointer"
                                            onclick="openModalUpdate(${book.bookId})"
                                            >
                                            Edit
                                        </a>
                                        <a
                                            href="${window.location.href}/admin/book-manager/delete?id=${book.bookId}"
                                            class="bg-red-500 hover:bg-red-700 text-white font-bold py-1 px-2 border border-red-500 rounded inline-block cursor-pointer"
                                            >
                                            Delete
                                        </a>
                                    </td>
                                </tr>`;
        }).join("");
        tableBody.innerHTML = html;
    });
});

function triggerFileUpload() {
    document.getElementById('file-upload').click();
}

function previewImage(input) {
    if (input.files && input.files[0]) {
        const file = input.files[0];
        const reader = new FileReader();

        reader.onload = function (e) {
            document.getElementById("preview").src = e.target.result;
        };

        reader.readAsDataURL(file);

        document.getElementById("imagePath").value = file.name;
    }
}


const openModal = (id, book) => {
    const dialog = document.querySelector(id);
    dialog.showModal();
//    getData();
};
const closeModal = (id) => {
    const dialog = document.querySelector(id);
    const preview = document.querySelector("#preview");
    dialog.close();
    preview.src = "../image/no-img.png";
};

const successModal = (id) => {
    closeModal(id);
};

const openModalUpdate = (bookId) => {
    fetch(`${window.location.href}/update?id=${bookId}`)
            .then(res => res.json())
            .then(data => {
                const dialog = document.querySelector("#book");
                const title = document.querySelector("#title ");
                const publishDate = document.querySelector("#publishDate ");
                const publisher = document.querySelector("#publisher ");
                const category = document.querySelector("#categories");
                const author = document.querySelector("#authors");
                const stockQuantity = document.querySelector("#stockQuantity");
                const description = document.querySelector("#description ");
                const imageURL = document.querySelector("#preview");
                const imageInput = document.querySelector("#imagePath");
                const btnAdd = document.querySelector("#btn-add");
                const form = document.querySelector("#form-book");
                dialog.showModal();
                title.value = data.title;
                publishDate.value = data.publishDate;
                publisher.value = data.publisher;
                category.value = data.categoryName;
                author.value = data.authorName;
                stockQuantity.value = data.stockQuantity;
                description.value = data.description;
                imageURL.src = "/CatLib/image/" + data.urlImage;
                imageInput.value = data.urlImage;
                btnAdd.textContent = 'Update';
                form.action = window.location.href + '/update?id=' + bookId;

            })
            .catch(err => console.error("Lỗi khi fetch:", err));

};

let dataObj;
const getData = () => {
    fetch(`${window.location.href}/get-book`)
            .then((res) => res.json())
            .then((data) => {
                dataObj = data;
                console.log(data);
            })
            .catch((err) => console.error("Lỗi khi fetch:", err));
};
console.log('heheh');
getData();


const suggest = (input) => {

    const array = dataObj[input.name].filter((e) => {
        if (input.value.length > 2) {
            return removeVietnameseTones(e.name).includes(removeVietnameseTones(input.value));
        }
        return false;
    });
    const ul = document.querySelector(`#${input.name}Suggestion`);
    const liElement = array.map((e) => {
        return `<li onclick="fillInput(this, ${input.name})" class="px-4 pt-1 border-b border-b-gray-400 line-1 overflow-hidden hover:bg-gray-100">${e.name}</li>`;
    });
    if (liElement.length > 0) {
        ul.classList.remove("hidden");
        ul.innerHTML = liElement.join("");
    } else {
        ul.classList.add("hidden");
    }
};

const fillInput = (element, inputName) => {
    const value = element.textContent.trim();
    inputName.value = value;
    const ul = element.parentNode;
    ul.classList.add("hidden");
};

function confirmDel(id) {

    const result = confirm(`Are you want to delete this book?`);
    if (result) {
        window.location.href = `${window.location.href}/delete?id=${id}`;
    } else {
        event.preventDefault();
    }
}
