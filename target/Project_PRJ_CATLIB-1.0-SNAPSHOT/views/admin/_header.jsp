<%-- 
    Document   : _header
    Created on : Jun 29, 2025, 2:26:31 PM
    Author     : tvphu
--%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<header class="flex justify-between items-center p-6 mt-2 text-[#5f899f]">
    <a
        class="flex items-center h-16 bg-white rounded-full px-4 dark:bg-gray-900 dark:text-gray-100 smooth-transition"
        href="${pageContext.request.contextPath}/admin/book-manager"
        >
        <img class="w-full h-full" src="${pageContext.request.contextPath}/image/logo.PNG" alt="logo CatLib" />
        <p class="text-4xl font-bold py-2">CATLIB</p>
    </a>
    <p class="font-bold text-7xl tracking-[1.5rem]">WELCOME ADMIN</p>
    <div class="flex items-center font-medium text-md">
        <button
            id="btn-dark"
            class="p-2 rounded-full mr-2"
            onclick="toggleDarkMode()"
            ></button>
        <!-- <a href="./signUp.html" class="px-4 py-2 mr-2 rounded-full bg-white dark:bg-[#5f899f] dark:hover:bg-[#4ca6bf] dark:text-white">Sign in</a> -->
        <!-- <a href="./login.html" class="px-4 py-2 rounded-full bg-[#5f899f] text-white hover:bg-[#4ca6bf] dark:bg-white dark:text-[#5f899f]">Login</a> -->
        <div
            class="relative size-10 z-10 rounded-full p-1 dark:bg-neutral-300 smooth-transition profile"
            >
            <img
                class="w-full"
                src="https://img.icons8.com/ios-glyphs/30/user--v1.png"
                alt="user--v1"
                />
            <div
                class="absolute top-12 right-0 bg-white dark:bg-neutral-800 dark:text-white w-28 rounded-md hidden"
                >
                <div class="absolute -top-4 right-0 bg-transparent w-12 h-4"></div>
                <ul class="text-center rounded-md overflow-hidden">
                    <li>
                        <a
                            href="${pageContext.request.contextPath}/log-out"
                            class="px-4 py-1 block hover:bg-neutral-700 hover:text-white"
                            >Log out</a
                        >
                    </li>
                </ul>
            </div>
        </div>
        <!-- <a href="./signUp.html" class="px-4 py-2 rounded-full bg-[#5f899f] text-white hover:bg-[#668f9b]">Log out</a> -->
    </div>
    <script src="${pageContext.request.contextPath}/script/darkMode.js"></script>

</header>
