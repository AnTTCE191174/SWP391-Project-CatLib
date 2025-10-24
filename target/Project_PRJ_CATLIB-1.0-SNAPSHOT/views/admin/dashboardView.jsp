<%-- 
    Document   : dashboardView
    Created on : Jun 29, 2025, 5:35:19 PM
    Author     : tvphu
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>
        <script src="https://cdn.tailwindcss.com"></script>
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

        </main>
    </body>
</html>
