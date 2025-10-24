<%-- 
    Document   : userManagerView
    Created on : Jul 8, 2025, 2:42:48 PM
    Author     : tvphu
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Manager</title>
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


                <div class="flex-[4]">
                    <!-- component -->
                    <div class="max-h-[40rem] overflow-y-auto ">
                        <table class="min-w-full border-collapse block md:table ">
                            <thead class="block md:table-header-group  smooth-transition">
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
                                        Username
                                    </th>
                                    <th
                                        class="bg-gray-600 p-2 text-white font-bold md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        Email Address
                                    </th>
                                    <th
                                        class="bg-gray-600 p-2 text-white font-bold md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        Is Active
                                    </th>
                                    <th
                                        class="bg-gray-600 p-2 text-white font-bold md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        Action
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="table_body" class="block md:table-row-group">
                            <c:forEach items="${users}" var="user" >
                                <tr
                                    class="bg-gray-300 dark:bg-gray-700 border border-grey-500 md:border-none block md:table-row"
                                    >
                                    <td
                                        class="p-2 md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        <span class="inline-block w-1/3 md:hidden font-bold">ID:</span>${user.userId}
                                    </td>
                                    <td
                                        class="p-2 md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        <span class="inline-block w-1/3 md:hidden font-bold"
                                              >UserName:</span
                                        >${user.username}
                                    </td>
                                    <td
                                        class="p-2 md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        <span class="inline-block w-1/3 md:hidden font-bold"
                                              >Email Address:</span
                                        >${user.email}
                                    </td>
                                    <td
                                        class="p-2 md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        <span class="inline-block w-1/3 md:hidden font-bold"
                                              >Is Active:</span
                                        >
                                        <c:choose>
                                            <c:when test="${user.active}">
                                                Active
                                            </c:when>
                                            <c:otherwise>
                                                Deactivate
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td
                                        class="p-2 md:border md:border-grey-500 text-left block md:table-cell"
                                        >
                                        <span class="inline-block w-1/3 md:hidden font-bold"
                                              >Actions</span
                                        >
                                        <a
                                            href="/CatLib/admin/user-manager/order?id=${user.userId}"
                                            class="bg-stone-500 hover:bg-stone-700 text-white font-bold py-1 px-2 border border-stone-500 rounded inline-block cursor-pointer"
                                            >
                                            Book Orders
                                        </a>
                                        <c:choose>
                                            <c:when test="${user.active}">
                                                <a  
                                                    href="/CatLib/admin/user-manager/deactivate?id=${user.userId}&isActive=true"
                                                    class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-2 border border-blue-500 rounded inline-block cursor-pointer"
                                                    >
                                                    Deactivate
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a  
                                                    href="/CatLib/admin/user-manager/deactivate?id=${user.userId}&isActive=false"
                                                    class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-2 border border-blue-500 rounded inline-block cursor-pointer"
                                                    >
                                                    Active
                                                </a>
                                            </c:otherwise>
                                        </c:choose>

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
        <script>
            if (${not empty active}) {
                alert("${active}");
            }
        </script>
        <script src="${pageContext.request.contextPath}/script/main.js?v=<%= System.currentTimeMillis()%>"></script>
    </body>
</html>
