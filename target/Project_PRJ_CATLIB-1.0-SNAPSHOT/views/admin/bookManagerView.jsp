<%-- 
    Document   : dashBoardView
    Created on : Jun 29, 2025, 2:25:07 PM
    Author     : tvphu
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DashBoard</title>
        <script src="https://cdn.tailwindcss.com"></script>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>
            if (localStorage.getItem('theme') === 'dark') {
                document.documentElement.classList.add('dark');
            }

            tailwind.config = {
                darkMode: 'class'
            };
        </script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/styles.css?v=<%= System.currentTimeMillis()%>"/>
    </head>
    <body
        class="flex flex-col min-h-dvh font-mono smooth-transition bg-[#c7f0fc] bg-center bg-no-repeat bg-cover min-h-screen dark:bg-gray-800 text-[#5f899f] dark:text-white"
        >

        <jsp:include page="_header.jsp"></jsp:include>

            <main
                class="relative flex-1 flex border-t-2 border-gray-300 bg-neutral-100 dark:bg-neutral-800 smooth-transition"
                >
            <jsp:include page="_menuManager.jsp"></jsp:include>

                <%-- Phần bảng (table) của bạn giữ nguyên, không thay đổi --%>
                <div class="flex-[4]">
                    <div class="w-full flex items-center justify-between py-2 pl-4 pr-6">
                        <div class="py-1 px-2 bg-green-600 border-2 border-green-600 rounded hover:bg-green-800">
                            <button
                                href="#"
                                class="text-neutral-200 font-bold"
                                onclick="openModal('#book')"
                                >
                                Create new book
                            </button>
                        </div>
                        <div>
                            <input
                                id="searchBook"
                                class="border-2 border-neutral-800 py-1 px-2 rounded-lg w-96"
                                type="text"
                                placeholder="search"
                                name="search"
                                autocomplete="off"
                                />
                        </div>
                    </div>
                    <div class="max-h-[40rem] overflow-y-auto ">
                        <table class="min-w-full border-collapse block md:table  smooth-transition">
                            <thead class="block md:table-header-group">
                                <tr
                                    class="border border-grey-500 md:border-none block md:table-row absolute -top-full md:top-auto -left-full md:left-auto md:relative"
                                    >
                                    <th
                                        class="bg-gray-600 p-2 text-white font-bold md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        ID
                                    </th>
                                    <th
                                        class="bg-gray-600 p-2 text-white font-bold md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        Title
                                    </th>
                                    <th
                                        class="bg-gray-600 p-2 text-white font-bold md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        Authors
                                    </th>
                                    <th
                                        class="bg-gray-600 p-2 text-white font-bold md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        Stock Quantity
                                    </th>
                                    <th
                                        class="bg-gray-600 p-2 text-white font-bold md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        Action
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="table_body" class="block md:table-row-group">
                            <c:forEach items="${books}" var="book" >
                                <tr
                                    class="bg-gray-300 dark:bg-gray-700 border border-grey-500 md:border-none block md:table-row"
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
                                            href="${pageContext.request.contextPath}/detail?id=${book.bookId}"
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
                                            onclick="confirmDel(${book.bookId})"
                                            class="bg-red-500 hover:bg-red-700 text-white font-bold py-1 px-2 border border-red-500 rounded inline-block cursor-pointer"
                                            >
                                            Delete
                                        </a>
                                    </td>
                                </tr>


                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>

        <dialog
            id="book"
            class="abolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 bg-white shadow-lg m-0 w-3/5 rounded-[2rem]"
            >
            <form id="form-book" class="py-2 px-4 w-full flex text-[#5f899f] gap-6" method="post" action="${pageContext.request.contextPath}/admin/book-manager/add">
                <div class="w-3/6 flex flex-col p-2">
                    
                    <div class="p-2 mb-4 border border-blue-300 rounded-lg bg-blue-50">
                        <label for="isbnQuery" class="font-bold">Nâng cấp: Tự động điền bằng ISBN</label>
                        <div class="flex gap-2 mt-1">
                            <input
                                type="text"
                                id="isbnQuery"
                                placeholder="Nhập mã ISBN (10 hoặc 13 số)"
                                class="py-1 px-3 bg-white border border-gray-300 w-full rounded-[1rem]"
                                />
                            <button
                                type="button"
                                onclick="fetchBookInfo()"
                                class="py-1 px-3 bg-blue-500 text-white font-bold rounded-[1rem] hover:bg-blue-700"
                                >
                                Tìm
                            </button>
                        </div>
                        <span id="loading" style="display:none; color: blue;">Đang tìm...</span>
                        <span id="error" style="color:red;"></span>
                    </div>
                    <hr class="mb-4">
                    <label for="title" class=""> Title </label>
                    <input
                        name="title"
                        type="text"
                        class="py-1 px-3 m2-1 mb-4 bg-gray-200 w-full rounded-[1rem]"
                        id="title" <%-- ID này đã đúng --%>
                        required
                        />
                    <div class="flex gap-4">
                        <div class="flex flex-col flex-1">
                            <label for="publishDate"> Publish Year </label>
                            <input
                                name="publishDate"
                                type="date"
                                class="py-1 px-3 m2-1 mb-4 bg-gray-200 rounded-[1rem]"
                                id="publishDate" <%-- ID này đã đúng --%>
                                required
                                />
                        </div>
                        <div class="flex flex-col flex-1">
                            <label for="publisher"> Publisher </label>
                            <input
                                name="publisher"
                                type="text"
                                class="py-1 px-3 m2-1 mb-4 bg-gray-200 w-full rounded-[1rem]"
                                id="publisher" <%-- ID này đã đúng --%>
                                required
                                />
                        </div>
                    </div>
                    <div class="flex gap-4">
                        <div class="flex flex-col flex-1 relative">
                            <label for="categories">Category</label>
                            <input autocomplete="off" name="categories" type="text" id="categories" oninput="suggest(this)" class="w-full py-1 px-3 mt-1 mb-4 bg-gray-200 rounded-[1rem]"/> <%-- ID này đã đúng --%>
                            <ul
                                id="categoriesSuggestion"
                                class="absolute top-full bg-white hidden border rounded shadow-lg z-10 w-full"></ul>
                        </div>
                        <div class="flex flex-col flex-1 relative">
                            <label for="authors">Author</label>
                            <input autocomplete="off" name="authors" type="text" id="authors" oninput="suggest(this)" class="w-full py-1 px-3 mt-1 mb-4 bg-gray-200 rounded-[1rem]"/> <%-- ID này đã đúng --%>
                            <ul
                                id="authorsSuggestion"
                                class="absolute top-full bg-white hidden border rounded shadow-lg z-10 w-full"></ul>
                        </div>
                    </div>

                    <label for="stockQuantity"> Stock Quantity </label>
                    <input
                        name="stockQuantity"
                        type="number"
                        class="py-1 px-3 m2-1 mb-4 bg-gray-200 w-24 rounded-[1rem]"
                        id="stockQuantity" <%-- ID này đã đúng --%>
                        required
                        />

                    <label for="description"> Description </label>
                    <textarea
                        name="description"
                        type="text"
                        class="py-1 px-3 m2-1 mb-4 bg-gray-200 rounded-[0.5rem]"
                        id="description" <%-- ID này đã đúng --%>
                        required
                        ></textarea>
                </div>
                <div class="w-2/6 py-2 flex flex-col">
                    <div class="flex-1">
                        <img
                            id="preview" <%-- ID này đã đúng --%>
                            class="w-full h-full object-cover rounded-[1rem]"
                            src="../image/no-img.png"
                            alt=""
                            />
                    </div>
                    <button
                        onclick="triggerFileUpload()"
                        class="p-2 mt-2 w-32 text-center text-white font-semibold bg-[#4ca6bf] rounded-[1rem] inline-block"
                        type="button"
                        >
                        Add Image
                    </button>

                    <input
                        id="file-upload"
                        type="file"
                        accept="image/*"
                        class="hidden"
                        onchange="previewImage(this)"
                        name="imageUrl"
                        />
                    <input type="hidden" name="imagePath" id="imagePath"> <%-- ID này đã đúng --%>

                </div>

                <div class="w-1/6">
                    <button
                        type="submit"
                        class="py-1 px-4 mt-2 bg-[#4caf50] w-full text-white font-semibold rounded-[1rem]"
                        id="btn-add"
                        >
                        Add Book
                    </button>
                    <button
                        type="reset"
                        class="py-1 px-4 mt-4 bg-gray-400 w-full text-white font-semibold rounded-[1rem]"
                        onclick="closeModal('#book')"
                        >
                        Cancel
                    </button>
                </div>
            </form>
        </dialog>
        
        <script>
            if (${not empty message}) {
                alert("${message}");
            }
        </script>
        
        <script>
            // TODO: Thay thế bằng API Key của bạn (lấy từ Google Cloud Console)
            const API_KEY = "AIzaSyBVvrIFfQV92R3lGNf7kWoUnUDE4URurN4"; 

            function fetchBookInfo() {
                let isbn = $('#isbnQuery').val().trim().replace(/-/g, ""); // Xóa gạch nối và khoảng trắng
                if (!isbn) {
                    $('#error').text("Vui lòng nhập mã ISBN.");
                    return;
                }

                $('#loading').show();
                $('#error').text("");

                // URL để gọi Google Books API bằng mã ISBN
                let apiUrl = "https://www.googleapis.com/books/v1/volumes?q=isbn:" + isbn + "&key=" + API_KEY;

                // Dùng jQuery AJAX để gọi API
                $.ajax({
                    url: apiUrl,
                    method: 'GET',
                    success: function(response) {
                        $('#loading').hide();
                        
                        if (response.totalItems > 0) {
                            // Tìm thấy sách! Lấy thông tin cuốn đầu tiên
                            let book = response.items[0].volumeInfo;
                            
                            console.log(book); // (Mở Console F12 để xem đầy đủ thông tin)

                            // Tự động điền thông tin vào form (DÙNG ĐÚNG ID CỦA BẠN)
                            $('#title').val(book.title || '');
                            $('#authors').val(book.authors ? book.authors.join(', ') : '');
                            $('#publisher').val(book.publisher || '');
                            
                            // Chuyển đổi định dạng ngày YYYY-MM-DD (nếu có)
                            if (book.publishedDate) {
                                let dateStr = book.publishedDate;
                                if (dateStr.length === 4) { // Chỉ có năm
                                    dateStr += "-01-01";
                                } else if (dateStr.length === 7) { // YYYY-MM
                                    dateStr += "-01";
                                }
                                $('#publishDate').val(dateStr.split('T')[0]);
                            }
                            
                            $('#description').val(book.description || '');
                            $('#categories').val(book.categories ? book.categories.join(', ') : '');
                            
                            // Lấy ảnh bìa và gán vào thẻ <img> preview
                            if (book.imageLinks && book.imageLinks.thumbnail) {
                                // Thay http bằng https để tránh lỗi mixed content
                                let imageUrl = book.imageLinks.thumbnail.replace('http://', 'https://');
                                $('#preview').attr('src', imageUrl);
                                // Gán URL vào hidden input để Servlet có thể nhận
                                $('#imagePath').val(imageUrl); 
                            } else {
                                $('#preview').attr('src', '../image/no-img.png');
                                $('#imagePath').val('');
                            }
                            
                        } else {
                            $('#error').text("Không tìm thấy sách nào với ISBN này.");
                        }
                    },
                    error: function(err) {
                        $('#loading').hide();
                        $('#error').text("Có lỗi xảy ra khi gọi API. (Kiểm tra API Key)");
                        console.error(err);
                    }
                });
            }
        </script>
        <script src="${pageContext.request.contextPath}/script/main.js?v=<%= System.currentTimeMillis()%>"></script>

    </body>
</html>