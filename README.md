## 🧰 Trước khi bắt đầu (áp dụng cho tất cả thành viên)

### 1️⃣ Cài đặt môi trường
- Java JDK 17 trở lên  
- Git ([https://git-scm.com/downloads](https://git-scm.com/downloads))  
- IDE: IntelliJ IDEA hoặc NetBeans  
- Tomcat Server (cùng phiên bản 10.x)

### 2️⃣ Clone project về máy
```bash
git clone https://github.com/<username>/<repo-name>.git
cd <repo-name>

### 3️⃣ Cập nhật code mới nhất
git pull origin main

### 4️⃣ Tạo branch riêng để làm việc
git checkout -b feature/<tên-tính-năng>

### 5️⃣ Commit và Push

Sau khi hoàn thành một phần code:

git add .
git commit -m "Hoàn thành chức năng đăng nhập"
git push origin feature/login

### 6️⃣ Tạo Pull Request (PR)

Vào GitHub → chọn Compare & pull request

Viết mô tả chi tiết thay đổi

Leader sẽ review và merge vào main

Quy tắc	Mô tả
1️⃣	Mỗi thành viên chỉ làm trên branch riêng
2️⃣	Luôn git pull origin main trước khi bắt đầu làm việc
3️⃣	Mỗi commit cần mô tả rõ ràng, ngắn gọn
4️⃣	Không commit file target/, .idea/, *.iml hoặc file cấu hình cá nhân
5️⃣	Leader là người duy nhất merge vào main
6️⃣	Khi có xung đột, tự xử lý cẩn thận trước khi push lại
