<%-- 
    Document   : homeView
    Created on : Jun 1, 2025, 12:09:45 AM
    Author     : DuyPhuc
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html class="">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
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
    <body class="font-mono smooth-transition bg-[#c7f0fc] bg-center bg-no-repeat bg-cover min-h-screen dark:bg-gray-800 text-black dark:text-white">

        <jsp:include page="_header.jsp"></jsp:include>

            <main>
                <div class="text-center">
                    <p class="text-8xl font-bold text-[#5f899f] tracking-widest my-6 ">WELCOME <span class="uppercase line-1 overflow-hidden text-ellipsis whitespace-nowrap">${loginedUser.username}</span></p>
                <form action="${pageContext.request.contextPath}/search" method="post">
                    <input class="p-2 rounded-md w-1/3" type="text" name="search">
                    <button class="bg-[#5f899f] text-white py-2 px-4 rounded-md hover:bg-[#668f9b]">Search</button>
                </form>
            </div>

            <div class="flex gap-4 px-4 py-8">
                <div class="p-4 bg-white rounded-md w-1/6 max-h-max dark:bg-gray-950 smooth-transition ">
                    <p class="py-1 text-3xl text-[#5f899f] font-semibold ">Category</p>

                    <form method="post" action="${pageContext.request.contextPath}/search" 
                          class="text-md gap-1 md:flex md:flex-col">

                        <c:forEach items="${tags}" var="tag">
                            <div class="flex items-center gap-4">
                                <input id="${tag.categoryId}" type="radio" name="search" value="${tag.categoryId}">
                                <label for="${tag.categoryId}" class="text-ellipsis whitespace-nowrap line-1 overflow-hidden">${tag.name}</label>
                            </div>
                        </c:forEach>
                        <button type="submit" class="my-2 py-1 bg-[#303e3b] text-white rounded-md col-span-2 hover:bg-[#668f9b]">Find</button>
                    </form>
                </div>
                <c:choose>
                    <c:when test="${notFound == 'notFound'}">
                        <div class="w-5/6 ">
                            <div class="w-[35rem] mx-auto">
                                <img class="w-full h-full" src="${pageContext.request.contextPath}/image/notFound.PNG" alt="">
                            </div>
                        </div>
                    </c:when> 

                    <c:otherwise>
                        <div class="w-5/6 h-fit gap-4 grid grid-cols-4 xl:grid-cols-5 text-[#5f899f]">
                            <c:forEach items="${books}" var="book">
                                <div class="bg-white rounded-md p-3 dark:bg-gray-950 smooth-transition">
                                    <div class="aspect-img">
                                        <img class="w-full h-full object-cover" src="${pageContext.request.contextPath}/image/${book.urlImage}" alt="${book.title}">
                                    </div>
                                    <p class="text-2xl font-semibold py-2 overflow-hidden text-ellipsis whitespace-nowrap">${book.title}</p>
                                    <p class=" line-2 overflow-hidden text-ellipsis text-left text-sm text-gray-700 font-medium leading-[1.5] min-h-[3em]">${book.description}</p>
                                    <div class="py-3 text-sm flex justify-between items-end">
                                        <a onclick="confirmBook(${book.bookId}, 'borrow')" href="${pageContext.request.contextPath}/user/borrow?id=${book.bookId}" class="py-2 px-3 rounded-md bg-[#303e3b] text-white">Borrow now</a>
                                        <a href="${pageContext.request.contextPath}/detail?id=${book.bookId}" class="underline underline-offset-2">Detail</a>
                                    </div>
                                </div> 
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>



            </div>
        </main>
        <script src="${pageContext.request.contextPath}/script/home.js"></script>
    </body>
</html>
