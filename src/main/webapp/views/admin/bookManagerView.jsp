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
        <script>
            if (localStorage.getItem('theme') === 'dark') {
                document.documentElement.classList.add('dark');
            }

            tailwind.config = {
                darkMode: 'class'
            };
        </script>
        <script>
            // "Bơm" contextPath từ JSP sang biến JavaScript toàn cục
            const contextPath = '${pageContext.request.contextPath}';
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


                <div class="flex-[4]">
                    <div class="w-full flex items-center justify-between py-2 pl-4 pr-6">
                        <div class="py-1 px-2 bg-green-600 border-2 border-green-600 rounded hover:bg-green-800">
                            <button
                                href="#"
                                class="text-neutral-200 font-bold"
                                onclick="openModal('#book')"
                                >
                                <!-- <img src="../plus.png" alt="" class="size-6 hover:opacity-80"/> -->
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
                    <!-- component -->
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
                    <label for="title" class=""> Title </label>
                    <input
                        name="title"
                        type="text"
                        class="py-1 px-3 m2-1 mb-4 bg-gray-200 w-full rounded-[1rem]"
                        id="title"
                        required
                        />
                    <div class="flex gap-4">
                        <div class="flex flex-col flex-1">
                            <label for="publishDate"> Publish Year </label>
                            <input
                                name="publishDate"
                                type="date"
                                class="py-1 px-3 m2-1 mb-4 bg-gray-200 rounded-[1rem]"
                                id="publishDate"
                                required
                                />
                        </div>
                        <div class="flex flex-col flex-1">
                            <label for="publisher"> Publisher </label>
                            <input
                                name="publisher"
                                type="text"
                                class="py-1 px-3 m2-1 mb-4 bg-gray-200 w-full rounded-[1rem]"
                                id="publisher"
                                required
                                />
                        </div>
                    </div>
                    <div class="flex gap-4">
                        <div class="flex flex-col flex-1 relative">
                            <label for="categories">Category</label>
                            <input autocomplete="off" name="categories" type="text" id="categories" oninput="suggest(this)" class="w-full py-1 px-3 mt-1 mb-4 bg-gray-200 rounded-[1rem]"/>
                            <ul
                                id="categoriesSuggestion"
                                class="absolute top-full bg-white hidden border rounded shadow-lg z-10 w-full"></ul>
                        </div>
                        <div class="flex flex-col flex-1 relative">
                            <label for="authors">Author</label>
                            <input autocomplete="off" name="authors" type="text" id="authors" oninput="suggest(this)" class="w-full py-1 px-3 mt-1 mb-4 bg-gray-200 rounded-[1rem]"/>
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
                        id="stockQuantity"
                        required
                        />

                    <label for="description"> Description </label>
                    <textarea
                        name="description"
                        type="text"
                        class="py-1 px-3 m2-1 mb-4 bg-gray-200 rounded-[0.5rem]"
                        id="description"
                        required
                        ></textarea>
                </div>
                <div class="w-2/6 py-2 flex flex-col">
                    <div class="flex-1">
                        <!-- <img class="w-full rounded-[1rem]" src="../solanin.jpg" alt=""> -->
                        <img
                            id="preview"
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
                    <input type="hidden" name="imagePath" id="imagePath">

                </div>

                <div class="w-1/6">
                    <button
                        type="submit"
                        class="py-1 px-4 mt-2 bg-[#4caf50] w-full text-white font-semibold rounded-[1rem]"
                        id="btn-add"
                        >
                        <!-- onclick="successModal('#book')" -->

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
        <script src="${pageContext.request.contextPath}/script/main.js?v=<%= System.currentTimeMillis()%>"></script>

    </body>
</html>
