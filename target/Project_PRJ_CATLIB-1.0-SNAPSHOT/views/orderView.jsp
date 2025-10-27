<%-- 
    Document   : orderView
    Created on : Jun 9, 2025, 8:20:49 AM
    Author     : DuyPhuc
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Page</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            if (localStorage.getItem('theme') === 'dark') {
                document.documentElement.classList.add('dark');
            }
        </script>
        <script>
            tailwind.config = {
                darkMode: 'class'
            };
        </script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/styles.css?v=<%= System.currentTimeMillis()%>"/>
    </head>
    <body
        class="flex flex-col min-h-dvh font-mono smooth-transition bg-[#c7f0fc] bg-center bg-no-repeat bg-cover min-h-screen dark:bg-gray-800 text-[#5f899f] dark:text-white"
        >
        <c:choose>
            <c:when test="${loginedUser == null || loginedUser.role=='user'}">
                <jsp:include page="_header.jsp"></jsp:include>

            </c:when>            
            <c:when test="${loginedUser != null && loginedUser.role=='admin'}">
                <jsp:include page="admin/_header.jsp"></jsp:include>

            </c:when>

        </c:choose>


        <main class="relative flex-1 flex bg-neutral-200 rounded-tl-[3rem] dark:bg-neutral-800 ring smooth-transition">
            <jsp:include page="_menuOrder.jsp"></jsp:include>


                <div class="flex-[5]">
                <c:forEach items="${orders}" var="order">
                    <div class="flex relative p-4 border-b border-neutral-400">
                        <div class="aspect-img bg-white p-2 mr-6 rounded-lg w-[12rem]">
                            <c:choose>
                                <%-- Trường hợp 1: Link API (Bắt đầu bằng http) --%>
                                <c:when test="${fn:startsWith(order.imageUrl, 'http')}">
                                    <img class="w-full h-full object-cover" src="${order.imageUrl}" alt="${order.title}" />
                                </c:when>

                                <%-- Trường hợp 2: Link Local (Bắt đầu bằng image/ hoặc chỉ là tên file) --%>
                                <c:otherwise>
                                    <%-- Tạo đường dẫn local, giả sử file luôn nằm trong thư mục 'image' --%>
                                    <c:set var="localImagePath" value="${order.imageUrl}"/>

                                    <%-- Nếu đường dẫn chưa có tiền tố 'image/' thì thêm vào --%>
                                    <c:if test="${!fn:startsWith(order.imageUrl, 'image/')}">
                                        <c:set var="localImagePath" value="image/${order.imageUrl}"/>
                                    </c:if>

                                    <img class="w-full h-full object-cover" 
                                         src="${pageContext.request.contextPath}/${localImagePath}" 
                                         alt="${order.title}" />
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="flex flex-col justify-between flex-1 text-gray-500 dark:text-gray-300">
                            <div>
                                <p class="text-4xl font-bold text-[#5f899f] dark:text-gray-200">${order.title}</p>
                                <p class="">${order.authorName}</p>
                                <p><span>${order.publisher}</span> - <span>${order.publishYear}</span></p>
                                <p class="text-sm">Borrow date: <span>${order.orderDate}</span></p>
                                <p class="text-sm">Return date: <span>${order.returnDate}</span></p>
                                <!--thêm if else đổi màu cho status-->
                                <c:choose>
                                    <c:when test="${order.status=='pending'}">
                                        <p class="font-semibold">Status: <span  class="text-gray-700 dark:text-gray-300">Pending</span></p>
                                    </c:when>
                                    <c:when test="${order.status=='approved'}">
                                        <p>Rental fee until now: <span>${order.bill}</span>VND</p>
                                        <p class="font-semibold">Status: <span  class="text-green-700">Approved</span></p>
                                    </c:when>
                                    <c:when test="${order.status=='rejected'}">
                                        <p class="font-semibold">Status: <span  class="text-red-700">Rejected</span></p>
                                    </c:when>
                                    <c:when test="${order.status=='overdue'}">
                                        <p>Rental fee until now: <span>${order.bill}</span>VND</p>
                                        <p class="font-semibold">Status: <span  class="text-yellow-700">Overdue</span></p>
                                    </c:when>
                                    <c:when test="${order.status=='returned'}">
                                        <p class="font-semibold">Status: <span  class="text-blue-700">Return</span></p>
                                    </c:when>
                                </c:choose>
                            </div>


                            <!-- <p>Book Available: <span  class="text-green-600">Available</span></p> -->
                            <!--<p>Book Available: <span  class="text-red-600">Unavailable</span></p>-->
                        </div>
                        <div class="absolute bottom-4 right-5 text-right">

                            <c:if test="${loginedUser.role == 'user'}">
                                <c:choose>
                                    <c:when test="${order.status=='pending'}">
                                        <p class="text-gray-500">Status:</p>
                                        <p class="text-gray-800 dark:text-gray-200">You may collect your book from the libary right now</p>
                                    </c:when>

                                    <c:when test="${order.status=='rejected'}">
                                        <p class="text-gray-500">Status:</p>
                                        <p class="text-gray-800 dark:text-gray-200">The book you ordered is no longer available</p>
                                    </c:when>
                                </c:choose>    
                            </c:if>

                            <c:if test="${loginedUser.role == 'admin'}">
                                <c:choose>
                                    <c:when test="${order.status=='pending'}">
                                        <div>

                                            <a
                                                href="${pageContext.request.contextPath}/admin/user-manager/action?id=${order.orderId}&userId=${order.userId}&action=approved"
                                                class="text-center mr-4 px-4 py-2 bg-green-700 text-white rounded border border-green-700 hover:bg-green-600"
                                                >
                                                Approved
                                            </a>

                                            <a
                                                href="${pageContext.request.contextPath}/admin/user-manager/action?id=${order.orderId}&userId=${order.userId}&action=rejected"
                                                class="text-center px-4 py-2 bg-red-700 text-white rounded border border-red-700 hover:bg-red-600"
                                                >
                                                Rejected
                                            </a>
                                        </div>

                                    </c:when>

                                    <c:when test="${order.status=='approved'}">
                                        <div>
                                            <a
                                                href="${pageContext.request.contextPath}/admin/user-manager/action?id=${order.orderId}&userId=${order.userId}&action=returned"
                                                class="text-center px-4 py-2 bg-green-700 text-white rounded border border-green-700 hover:bg-green-600"
                                                >
                                                Return
                                            </a>
                                        </div>
                                    </c:when>
                                    <c:when test="${order.status.toLowerCase()=='overdue'}"> 
                                        <div>
                                            <a href="${pageContext.request.contextPath}/admin/user-manager/action?id=${order.orderId}&userId=${order.userId}&action=returned"
                                               class="text-center px-4 py-2 bg-orange-700 text-white rounded border border-orange-700 hover:bg-orange-600">
                                                Return
                                            </a>
                                        </div>
                                    </c:when>
                                </c:choose>    
                            </c:if>
                        </div>  
                    </div>
                </c:forEach>

            </div>
        </main>

        <!--<script src="${pageContext.request.contextPath}/script/main.js"></script>-->
        <script>
            if (${not empty messageAction}) {
                alert("${messageAction}");
            }
        </script>
    </body>
</html>
