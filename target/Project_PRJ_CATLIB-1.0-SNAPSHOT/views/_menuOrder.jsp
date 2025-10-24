<%-- 
    Document   : _menuOrder
    Created on : Jun 23, 2025, 10:29:51 PM
    Author     : Truong Duy Phuc - CE190116
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div
    class="flex-1 py-8 px-4 font-normal text-2xl border-r border-neutral-400 dark:border-neutral-600 transition-colors duration-500"
    >
    <ul class="sticky top-12 left-0">
        <li class="px-4 mb-2 ml-1 hover:font-extrabold">
            <div
                onclick="selectOption('returned')"
                class="block"
                >History</div>
        </li>

        <!-- Dropdown -->
        <li class="relative ml-1">
            <button
                id="dropdownBtn"
                class="w-full bg-neutral-200 dark:bg-neutral-800 dark:text-white px-4 py-2 rounded-lg flex justify-between items-center smooth-transition"
                >
                <span id="selectedLabel">All</span>
                <svg class="w-4 h-4 ml-2" viewBox="0 0 20 20">
                <path
                    d="M5.516 7.548L10 12.032l4.484-4.484L16 9.064l-6 6-6-6z"
                    />
                </svg>
            </button>

            <div
                id="dropdownMenu"
                class="absolute z-10 w-full bg-neutral-100 dark:bg-neutral-700 mt-1 rounded-lg overflow-hidden shadow-lg origin-top scale-y-0 opacity-0 pointer-events-none smooth-transition"
                >
                <div
                    onclick="selectOption('all')"
                    class="px-4 py-2 hover:bg-neutral-300 dark:hover:bg-neutral-600 cursor-pointer"
                    >
                    All
                </div>
                <div
                    onclick="selectOption('pending')"
                    class="px-4 py-2 hover:bg-neutral-300 dark:hover:bg-neutral-600 cursor-pointer"
                    >
                    Pending
                </div>
                <div
                    onclick="selectOption('approved')"
                    class="px-4 py-2 hover:bg-neutral-300 dark:hover:bg-neutral-600 cursor-pointer"
                    >
                    Approved
                </div>
                <div
                    onclick="selectOption('rejected')"
                    class="px-4 py-2 hover:bg-neutral-300 dark:hover:bg-neutral-600 cursor-pointer"
                    >
                    Rejected
                </div>
                <div
                    onclick="selectOption('overdue')"
                    class="px-4 py-2 hover:bg-neutral-300 dark:hover:bg-neutral-600 cursor-pointer"
                    >
                    OverDue
                </div>
            </div>
        </li>
    </ul>
</div>

<script>
    const btn = document.getElementById("dropdownBtn");
    const menu = document.getElementById("dropdownMenu");
    const label = document.getElementById("selectedLabel");

    // 1. Gán sự kiện mở/đóng menu
    btn.addEventListener("click", () => {
        menu.classList.toggle("scale-y-100");
        menu.classList.toggle("opacity-100");
        menu.classList.toggle("pointer-events-auto");
    });

    // 2. Gọi chuyển hướng
    function redirectOption(status) {
        const url = new URL(window.location.href);
        if (!status || status.toLowerCase() === 'all') {
            url.searchParams.delete('status');
        } else {
            url.searchParams.set('status', status);
        }
        // Reload với URL mới
        window.location.href = url.pathname + url.search;
    }


    // 3. Gọi khi click chọn option
    function selectOption(value) {
        redirectOption(value);
    }

    // 4. Khi load lại trang, đọc giá trị từ URL để cập nhật label
    window.addEventListener('DOMContentLoaded', () => {
        const urlParams = new URLSearchParams(window.location.search);
        const status = urlParams.get('status');
        const value = status ? status : 'All';
        document.getElementById('selectedLabel').innerText = value.charAt(0).toUpperCase() + value.slice(1);
    });

</script>


