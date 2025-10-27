<%-- 
    Document   : detailView
    Created on : Jun 2, 2025, 4:02:48 PM
    Author     : DuyPhuc
--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${book.title} detail</title> <link rel="preconnect" href="https://fonts.googleapis.com">
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            if (localStorage.getItem('theme') === 'dark') {
                document.documentElement.classList.add('dark');
            }
        </script>
        <script>
            tailwind.config = {
                darkMode: 'class'
            }
        </script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/styles.css?v=<%= System.currentTimeMillis()%>"/>
    </head>
    <body
        class="relative font-mono smooth-transition bg-[#c7f0fc] bg-center bg-no-repeat bg-cover min-h-screen dark:bg-gray-800 text-black dark:text-white">

        <jsp:include page="_header.jsp"></jsp:include>


            <main class="absolute bottom-0 left-0 right-0 h-1/2 pl-32 flex bg-neutral-100 dark:bg-neutral-800 rounded-tl-[4vw] rounded-tr-[4vw] ring smooth-transition">
                <div class="-translate-y-1/2 w-1/5">
                    <div class="aspect-img">
                        <%-- ===== BẮT ĐẦU SỬA LỖI ẢNH (Dòng 42 cũ) ===== --%>
                        <c:choose>
                            <%-- 1. Nếu là URL đầy đủ từ API --%>
                            <c:when test="${fn:startsWith(book.urlImage, 'http')}">
                                <img class="rounded-xl w-full ring " src="${book.urlImage}" alt="${book.title}" />
                            </c:when>

                            <%-- 2. Nếu đường dẫn ĐÃ BAO GỒM 'image/' (Cách lưu chuẩn) --%>
                            <c:when test="${fn:startsWith(book.urlImage, 'image/')}">
                                <img class="rounded-xl w-full ring " src="${pageContext.request.contextPath}/${book.urlImage}" alt="${book.title}" />
                            </c:when>

                            <%-- 3. Ngược lại (có thể chỉ là tên file) - Thử thêm 'image/' --%>
                            <c:otherwise>
                                <img class="rounded-xl w-full ring " src="${pageContext.request.contextPath}/image/${book.urlImage}" alt="${book.title}" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <p class="text-sm mt-6 pt-2 border-t border-gray-400">tag: <span>${book.categoryName}</span></p>
                </div>
                <div class="w-4/5 px-8">
                    <p class="text-5xl font-bold text-[#5f899f] pt-4 pb-2">${book.title}</p>
                    <p class="text-neutral-700 dark:text-neutral-400 ">${book.authorName}</p>
                    <p class="text-neutral-700 dark:text-neutral-400"><span>${book.publisher}</span> - <span>${book.publishDate}</span></p>
                    <p class="text-neutral-500 dark:text-neutral-200 text-balance">${book.description}</p>

                </div>

                <c:if test="${loginedUser.role != 'admin'}">
                    <div class="absolute top-12 right-0 p-4 text-right ">
                        <p>Fee: <span class="text-neutral-500 pl-2">5.000VND/day</span></p>
                        <p>Overdue Fee:  <span class="text-neutral-500">10.000VND/day</span></p>
                    </div>

                    <div div class="absolute bottom-0 right-0 flex items-end">
                        <div class="bg-gray-800 dark:bg-gray-200  rounded-t-lg ">
                            <a class="block text-xl py-2 px-8 text-white  font-semibold smooth-transition  dark:text-neutral-900" href="${pageContext.request.contextPath}/comment?id=${book.bookId}"> Comment</a>
                        </div>

                        <div class=" bg-[#4ca6bf] dark:bg-neutral-400 rounded-tl-[3vw]">
                            <a onclick="confirmBook(${book.bookId}, 'borrow')" class="block py-8 px-16 text-3xl text-white font-semibold tracking-wider dark:text-neutral-900 smooth-transition" href="${pageContext.request.contextPath}/user/borrow?id=${book.bookId}">Borrow now</a>
                        </div>
                    </div>


                </c:if>
        </main>


        <script src="${pageContext.request.contextPath}/script/home.js"></script>

    </body>
</html>
