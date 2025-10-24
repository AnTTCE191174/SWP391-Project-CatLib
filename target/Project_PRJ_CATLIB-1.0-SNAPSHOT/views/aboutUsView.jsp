<%-- 
    Document   : aboutUsView
    Created on : Jul 16, 2025, 5:50:27 PM
    Author     : tvphu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>About Us Page</title>
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
        <jsp:include page="_header.jsp"></jsp:include>

            <main class="relative flex-1 smooth-transition">
                <div class="w-[50rem] mx-auto text-center text-xl">
                    <p class="text-6xl">About Us</p>
                    <p class="my-2 text-justify leading-8 italic">
                        This is a project from Group 4 of SE1904 class, with the goal of
                        creating a web application that can manage the library, with
                        additional functions to repair books, see the status of the user,
                        browse the book of user borrowed...
                    </p>
                    <p class="font-bold">
                        If you love this project, you can donate in number account
                    </p>
                    <p class="my-2 font-bold">MBBank: 0847395252</p>

                    <div
                        class="relative hover:z-10 size-64 mx-auto rounded-xl overflow-hidden hover:scale-[2.5] transition-transform duration-500 ease-in-out"
                        >
                        
                </div>
            </div>

            <div class="w-full mt-52">
                <ul class="flex gap-4 justify-between text-white text-center">
                    <li class="relative flex-1 bg-[#4ca6bf] pb-8">
                        <div
                            class="absolute bottom-full translate-y-1/2 bg-[#4ca6bf] w-full aspect-square rounded-t-full"
                            >
                            <div
                                class="absolute -top-1/2 translate-y-1/2 translate-x-1/2 w-40 mx-auto text-center p-1 rounded-md rotate-6 hover:rotate-0 transition-transform duration-500 ease-in-out"
                                >
                                <img
                                    src="${pageContext.request.contextPath}/image/member/member1.PNG?v=<%= System.currentTimeMillis()%>"
                                    alt=""
                                    class="w-full h-full"
                                    />
                            </div>
                        </div>
                        <div class="relative px-6 z-10">
                            <p class="text-2xl font-bold ">Trần Tấn Đạt</p>
                            <p class="py-2">Backend Devloper</p>
                            <p class="text-justify italic">
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Beatae
                                eaque ipsa, facere sit recusandae deleniti.
                            </p>
                        </div>
                    </li>

                    <li class="relative flex-1 bg-[#4ca6bf] pb-8">
                        <div
                            class="absolute bottom-full translate-y-1/2 bg-[#4ca6bf] w-full aspect-square rounded-t-full"
                            >
                            <div
                                class="absolute -top-1/2 translate-y-1/2 translate-x-1/2 w-40 mx-auto text-center p-1 rounded-md -rotate-6 hover:rotate-0 transition-transform duration-500 ease-in-out"
                                >
                                <img
                                    src="${pageContext.request.contextPath}/image/member/member2.PNG?v=<%= System.currentTimeMillis()%>"
                                    alt=""
                                    class="w-full h-full"
                                    />
                            </div>
                        </div>
                        <div class="relative px-6 z-10">
                            <p class="text-2xl font-bold ">Lâm Gia Bảo</p>
                            <p class="py-2"></p>
                            <p class="text-justify italic">
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Beatae
                                eaque ipsa, facere sit recusandae deleniti.
                            </p>
                        </div>
                    </li>

                    <li class="relative flex-1 bg-[#4ca6bf] pb-8">
                        <div
                            class="absolute bottom-full translate-y-1/2 bg-[#4ca6bf] group w-full aspect-square rounded-t-full"
                            >
                            <div
                                class="absolute -top-1/2 translate-y-1/2 translate-x-1/2 w-40 mx-auto text-center p-1 rounded-md"
                                >
                                <div class="p-1 animate-spin-manual">
                                    <img
                                        src="${pageContext.request.contextPath}/image/member/member3.PNG?v=<%= System.currentTimeMillis()%>"
                                        alt=""
                                        class="w-full h-full "
                                        />
                                </div>
                            </div>
                        </div>
                        <div class="relative px-6 z-10">
                            <p class="text-2xl font-bold ">Kim Cheese</p>
                            <p class="py-2"></p>
                            <p class="text-justify italic">
                                <!--                                Trời Cần Thơ mưa dai như đỉa - Nhớ em nhiều anh có ỉa được đâu-->
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Beatae
                                eaque ipsa, facere sit recusandae deleniti.
                            </p>
                        </div>
                    </li>

                    <li class="relative flex-1 bg-[#4ca6bf] pb-8">
                        <div
                            class="absolute bottom-full translate-y-1/2 bg-[#4ca6bf] w-full aspect-square rounded-t-full"
                            >
                            <div
                                class="absolute -top-1/2 translate-y-1/2 translate-x-1/2 w-40 mx-auto text-center p-1 rounded-md -rotate-6 hover:rotate-0 transition-transform duration-500 ease-in-out"
                                >
                                <img
                                    src="${pageContext.request.contextPath}/image/member/member4.PNG?v=<%= System.currentTimeMillis()%>"
                                    alt=""
                                    class="w-full h-full"
                                    />
                            </div>
                        </div>
                        <div class="relative px-6 z-10">
                            <p class="text-2xl font-bold ">Chang Chih An - 張志安</p>
                            <p class="py-2"></p>
                            <p class="text-justify italic">
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Beatae
                                eaque ipsa, facere sit recusandae deleniti.
                            </p>
                        </div>
                    </li>

                    <li class="relative flex-1 bg-[#4ca6bf] pb-8">
                        <div
                            class="absolute bottom-full translate-y-1/2 bg-[#4ca6bf] w-full aspect-square rounded-t-full"
                            >
                            <div
                                class="absolute -top-1/2 translate-y-1/2 translate-x-1/2 w-40 mx-auto text-center p-1 rounded-md rotate-6 hover:rotate-0 transition-transform duration-500 ease-in-out"
                                >
                                <img
                                    src="${pageContext.request.contextPath}/image/member/member5.PNG?v=<%= System.currentTimeMillis()%>"
                                    alt=""
                                    class="w-full h-full"
                                    />
                            </div>
                        </div>
                        <div class="relative px-6 z-10">
                            <p class="text-2xl font-bold ">Lâm Hoàng Phúc</p>
                            <p class="py-2"></p>
                            <p class="text-justify italic">
                                <!--Lọ Thánh Chí Tôn – kẻ đã lọ suốt thiên niên kỷ, đạt đến cảnh giới mà người đời chỉ dám mơ.-->
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Beatae
                                eaque ipsa, facere sit recusandae deleniti.
                            </p>
                        </div>
                    </li>
                </ul>
            </div>
        </main>
    </body>
</html>
