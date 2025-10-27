<%-- 
    Document   : commentView
    Created on : Jun 3, 2025
    Author     : C
--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comments</title>

        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            if (localStorage.getItem('theme') === 'dark') {
                document.documentElement.classList.add('dark');
            }
            tailwind.config = {
                darkMode: 'class'
            }
        </script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/styles.css?v=<%= System.currentTimeMillis()%>"/>
    </head>

    <body class="flex flex-col min-h-dvh font-mono smooth-transition bg-[#c7f0fc] bg-center bg-no-repeat bg-cover min-h-screen dark:bg-gray-800 text-[#5f899f] dark:text-white">

        <jsp:include page="_header.jsp"></jsp:include>

            <main class="relative flex-1 flex border-t-2 border-gray-300 bg-neutral-100 dark:bg-neutral-800 smooth-transition">

                <div class="w-1/3 border-r-2 border-gray-300 p-6 flex flex-col items-center dark:bg-gray-800">
                    <div class="relative w-[450px] h-[600px] mb-4">
                    <c:choose>
                        <c:when test="${fn:startsWith(book.urlImage, 'http')}">
                            <img class="rounded-xl w-full h-full object-cover absolute top-0 left-0 shadow-lg"
                                 src="${book.urlImage}" alt="${book.title}" />
                        </c:when>
                        <c:when test="${fn:startsWith(book.urlImage, 'image/')}">
                            <img class="rounded-xl w-full h-full object-cover absolute top-0 left-0 shadow-lg"
                                 src="${pageContext.request.contextPath}/${book.urlImage}" alt="${book.title}" />
                        </c:when>
                        <c:otherwise>
                            <img class="rounded-xl w-full h-full object-cover absolute top-0 left-0 shadow-lg"
                                 src="${pageContext.request.contextPath}/image/${book.urlImage}" alt="${book.title}" />
                        </c:otherwise>
                    </c:choose>
                </div>

                <h2 class="text-2xl font-semibold text-center mb-1">${book.title}</h2>
                <p class="text-neutral-700 dark:text-neutral-400 text-center">${book.authorName}</p>
                <p class="text-neutral-700 dark:text-neutral-400 text-center">${book.publishDate} - ${book.publisher}</p>
            </div>

            <!-- Cột phải: Comment -->
            <div class="w-2/3 flex-grow p-6 flex flex-col">
                <div class="flex-1 space-y-6 overflow-y-auto pr-2">

                    <!-- ====== COMMENT MẪU CỐ ĐỊNH ====== -->
                    <div class="bg-gray-100 dark:bg-gray-700 p-4 rounded-lg shadow flex gap-4">
                        <div class="flex-shrink-0">
                            <img class="size-10 rounded-full" src="https://img.icons8.com/ios-glyphs/30/user--v1.png" alt="user avatar" />
                        </div>
                        <div class="flex-1">
                            <div class="flex justify-between items-center mb-1">
                                <p class="font-semibold text-gray-900 dark:text-white">Phuc Lam</p>
                                <p class="text-sm text-gray-500 dark:text-gray-400">14/08/2025</p>
                            </div>
                            <p class="text-gray-700 dark:text-gray-300">
                                Happy Ending, I Love it
                            </p>
                        </div>
                    </div>

                    <div class="bg-gray-100 dark:bg-gray-700 p-4 rounded-lg shadow flex gap-4">
                        <div class="flex-shrink-0">
                            <img class="size-10 rounded-full" src="https://img.icons8.com/ios-glyphs/30/user--v1.png" alt="user avatar" />
                        </div>
                        <div class="flex-1">
                            <div class="flex justify-between items-center mb-1">
                                <p class="font-semibold text-gray-900 dark:text-white">Vu Dinh Trong Thang</p>
                                <p class="text-sm text-gray-500 dark:text-gray-400">16/08/2025</p>
                            </div>
                            <p class="text-gray-700 dark:text-gray-300">
                                Love it
                            </p>
                        </div>
                    </div>

                    <div class="bg-gray-100 dark:bg-gray-700 p-4 rounded-lg shadow flex gap-4">
                        <div class="flex-shrink-0">
                            <img class="size-10 rounded-full" src="https://img.icons8.com/ios-glyphs/30/user--v1.png" alt="user avatar" />
                        </div>
                        <div class="flex-1">
                            <div class="flex justify-between items-center mb-1">
                                <p class="font-semibold text-gray-900 dark:text-white">Beatnik</p>
                                <p class="text-sm text-gray-500 dark:text-gray-400">18/09/2025</p>
                            </div>
                            <p class="text-gray-700 dark:text-gray-300">
                                Asano Inio's Solanin captures people in a pivotal moment in their lives...
                                <br><br>
                                But there is going sideways. Speaking of sideways, Asano's stories feature elements that are so out of left-field it prevents his manga from falling...
                            </p>
                        </div>
                    </div>
                    <!-- ====== END COMMENT MẪU ====== -->

                    <!-- ====== COMMENT TỪ DB ====== -->
                    <c:forEach items="${comments}" var="comment">
                        <div class="bg-gray-100 dark:bg-gray-700 p-4 rounded-lg shadow flex gap-4 items-start">
                            <img class="w-10 h-10 rounded-full" src="https://img.icons8.com/ios-glyphs/30/user--v1.png" alt="avatar" />
                            <div class="flex-1">
                                <div class="flex justify-between items-center mb-1">
                                    <p class="font-semibold text-gray-900 dark:text-white">${comment.username}</p>
                                    <p class="text-sm text-gray-500 dark:text-gray-400">${comment.date}</p>
                                </div>
                                <p class="text-gray-700 dark:text-gray-300 leading-relaxed">${comment.text}</p>
                            </div>
                        </div>
                    </c:forEach>
                    <!-- ====== END COMMENT DB ====== -->
                </div>

                <!-- Nếu đăng nhập -->
                <c:if test="${not empty loginedUser}">
                    <form action="${pageContext.request.contextPath}/add-comment" method="POST" class="mt-6">
                        <input type="hidden" name="bookId" value="${book.bookId}">
                        <input type="hidden" name="userId" value="${loginedUser.userId}">

                        <div class="bg-gray-100 dark:bg-gray-700 p-4 rounded-lg shadow flex gap-4 items-center">
                            <img class="w-10 h-10 rounded-full" src="https://img.icons8.com/ios-glyphs/30/user--v1.png" alt="your avatar" />
                            <textarea name="commentText"
                                      class="bg-transparent border-none resize-none flex-1 text-black dark:text-white placeholder-gray-500 focus:outline-none"
                                      rows="2"
                                      placeholder="Write your comment..."></textarea>
                            <button type="submit" class="p-2 text-black dark:text-white hover:opacity-75 smooth-transition">
                                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M5 4l10 6-10 6V4z"/>
                                </svg>
                            </button>
                        </div>
                    </form>
                </c:if>

                <!-- Nếu chưa đăng nhập -->
                <c:if test="${empty loginedUser}">
                    <div class="mt-6 p-4 bg-gray-100 dark:bg-gray-700 rounded-lg text-center">
                        <p class="text-gray-700 dark:text-gray-300">
                            Vui lòng <a href="${pageContext.request.contextPath}/login"
                                        class="font-bold text-blue-500 hover:underline">đăng nhập</a>
                            để để lại bình luận.
                        </p>
                    </div>
                </c:if>
            </div>
        </main>

        <script src="${pageContext.request.contextPath}/script/darkMode.js"></script>
    </body>
</html>
