<%-- 
    Document   : _header
    Created on : Jun 1, 2025, 12:11:37 AM
    Author     : DuyPhuc
--%>

<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<header class="flex justify-between items-center p-6 text-[#5f899f]">

    <c:choose>
        <c:when test="${loginedUser == null || loginedUser.role=='user'}">
            <a class="flex items-center h-16 bg-white rounded-full px-4 dark:bg-gray-900 dark:text-gray-100 smooth-transition" 
               href="${pageContext.request.contextPath}/home">
                <img class="w-full h-full " src="${pageContext.request.contextPath}/image/logo.PNG" alt="logo CatLib">
                <p class="text-4xl font-bold py-2">CATLIB</p>
            </a>
        </c:when>            
        <c:when test="${loginedUser != null && loginedUser.role=='admin'}">
            <a class="flex items-center h-16 bg-white rounded-full px-4 dark:bg-gray-900 dark:text-gray-100 smooth-transition" 
               href="${pageContext.request.contextPath}/admin/book-manager">
                <img class="w-full h-full " src="${pageContext.request.contextPath}/image/logo.PNG" alt="logo CatLib">
                <p class="text-4xl font-bold py-2">CATLIB</p>
            </a>
        </c:when>

    </c:choose>
    <nav>
        <ul
            class="flex justify-between gap-4 text-2xl font-semibold tracking-wider"
            >
            <li class="group py-2 px-4 rounded relative">
                <a
                    href="${pageContext.request.contextPath}/home"
                    class="menu-link relative z-10 transition-colors duration-500 ease-in-out"
                    >Home
                    <span
                        class="line absolute -bottom-2 left-1/2 h-1 w-0 bg-[#5f899f] transform -translate-x-1/2 group-hover:left-0 group-hover:w-full group-hover:translate-x-0 transition-all duration-500 ease-in-out"
                        ></span>
                </a>
            </li>

            <li class="group py-2 px-4 rounded relative">
                <a
                    href="${pageContext.request.contextPath}/about-us"
                    class="menu-link relative z-10 transition-colors duration-500 ease-in-out"
                    >About us
                    <span
                        class="line absolute -bottom-2 left-1/2 h-1 w-0 bg-[#5f899f] transform -translate-x-1/2 group-hover:left-0 group-hover:w-full group-hover:translate-x-0 transition-all duration-500 ease-in-out"
                        ></span>
                </a>
            </li>

            <li class="group py-2 px-4 rounded relative">
                <a
                    href="${pageContext.request.contextPath}/user/order"
                    class="menu-link relative z-10 transition-colors duration-500 ease-in-out"
                    >Stocks
                    <span
                        class="line absolute -bottom-2 left-1/2 h-1 w-0 bg-[#5f899f] transform -translate-x-1/2 group-hover:left-0 group-hover:w-full group-hover:translate-x-0 transition-all duration-500 ease-in-out"
                        ></span>
                </a>
            </li>
        </ul>
    </nav>
    <div class="flex items-center font-medium text-md">
        <button id="btn-dark" class="p-2 rounded-full mr-2 " onclick="toggleDarkMode()">

        </button>

        <c:choose>

            <c:when test = "${loginedUser != null}">
                <div class="relative size-10 z-10 rounded-full p-1 dark:bg-neutral-300 smooth-transition profile">
                    <img class="w-full" src="https://img.icons8.com/ios-glyphs/30/user--v1.png" alt="user--v1" />
                    <div
                        class="absolute top-12 right-0 bg-white dark:bg-neutral-800 dark:text-white w-28 rounded-md  hidden ">
                        <div class="absolute -top-4 right-0 bg-transparent w-12 h-4"></div>
                        <ul class="text-center rounded-md overflow-hidden  ">
                            <li>
                                <a href="${pageContext.request.contextPath}/log-out" class="px-4 py-1 block hover:bg-neutral-700 hover:text-white">Log out</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </c:when>

            <c:otherwise>
                <a href="${pageContext.request.contextPath}/sign-up" class="px-4 py-2 mr-2 rounded-full bg-white dark:bg-[#5f899f] dark:hover:bg-[#4ca6bf] dark:text-white smooth-transition">Sign up</a>
                <a href="${pageContext.request.contextPath}/login" class="px-4 py-2 rounded-full bg-[#5f899f] text-white hover:bg-[#4ca6bf] dark:bg-white dark:text-[#5f899f] smooth-transition">Login</a>
            </c:otherwise>

        </c:choose>
    </div>


    <script>
        const currentPath = window.location.pathname;
        document.querySelectorAll(".menu-link").forEach((link) => {
            const href = link.getAttribute("href");
            if (href === currentPath) {
                const line = link.querySelector(".line");
                line.classList.add("left-0", "w-full", "translate-x-0");
            }
        });
    </script>
    <script src="${pageContext.request.contextPath}/script/darkMode.js"></script>

</header>
