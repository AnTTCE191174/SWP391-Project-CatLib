<%-- 
    Document   : loginView
    Created on : Jun 1, 2025, 12:08:54 AM
    Author     : DuyPhuc
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Log in</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                darkMode: 'class'
            }
        </script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/styles.css?v=<%= System.currentTimeMillis()%>"/>
    </head>
    <body
        class="relative font-mono smooth-transition bg-[#c7f0fc] bg-center bg-no-repeat bg-cover min-h-screen dark:bg-gray-800 text-[#5f899f] dark:text-white">
        <div class="absolute top-6 left-6">
            <a class="flex items-center h-16 bg-white rounded-full px-4 dark:bg-gray-900 dark:text-gray-100 smooth-transition"
               href="${pageContext.request.contextPath}/home">
                <img class="w-full h-full " src="${pageContext.request.contextPath}/image/logo.PNG" alt="logo CatLib">
                <p class="text-4xl font-bold py-2">CATLIB</p>
            </a>
        </div>

        <main
            class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 bg-white p-12 rounded-[2rem] xl:w-[28rem] lg:w-1/3 md:w-2/5">
            <p class="text-5xl font-bold">Log in</p>

            <form action="${pageContext.request.contextPath}/login" method="post" class="flex flex-col pt-6">
                <label for="username" class="mt-6 mb-2">Username</label>
                <input type="text" name="username" id="username"
                       class="bg-gray-200 rounded-[2rem] border-b-2 border-gray-300 focus:border-[#5f899f] outline-none py-1 px-4 ">

                <label for="password" class="mt-6 mb-2">Password</label>
                <input type="password" name="password" id="password"
                       class="bg-gray-200 rounded-[2rem] border-b-2 border-gray-300 focus:border-[#5f899f] outline-none py-1 px-4 ">

                <div class="pt-2 flex items-center gap-2">
                    <!-- <a href=""></a> -->
                    <input type="checkbox" value="remember" name="remember" id="remember">
                    <label for="remember">Remember me?</label>
                </div>
                <c:if test="${not empty errorString}">
                    <p class="text-red-700 font-bold-">${errorString}</p>
                </c:if>    
                <button type="submit" class="py-2 mt-8 text-sm text-white bg-[#4ca6bf] hover:bg-[#668f9b] rounded-[2rem]">Log
                    in</button>
            </form>

            <div class="after:border after:border-gray-900 after:flex-1 after:ml-3
                 before:border before:border-gray-900 before:flex-1 before:mr-3
                 flex items-center justify-center w-full my-2">
                or
            </div>

            <a href="${pageContext.request.contextPath}/sign-up">
                <p class="w-full bg-gray-100 text-center text-sm rounded-[2rem] py-2 hover:bg-gray-300">sign up</p>
            </a>
        </main>

        <script>
             if (${not empty message}) {
                 alert("${message}");
             }
        </script>
    </body>
</html>
