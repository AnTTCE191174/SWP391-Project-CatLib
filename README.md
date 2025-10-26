1️⃣ Lấy code mới nhất từ GitHub về máy

(Làm trước khi bắt đầu code mỗi ngày)

git checkout develop
git pull origin develop

2️⃣ Tạo nhánh riêng để làm việc

git checkout -b feature/<tên-tính-năng>

Ví dụ:

git checkout -b feature/login

3️⃣ Sau khi code xong, đẩy code lên GitHub

git add .
git commit -m "Hoàn thiện chức năng <tên-tính-năng>"
git push origin feature/<tên-tính-năng>
Sau đó vào GitHub → Compare & pull request → Gửi PR để Leader review & merge.

4️⃣ Sau khi Leader merge xong

(Để đồng bộ lại code mới nhất về máy)

git checkout develop
git pull origin develop

Nếu thấy ổn định ở nhánh develop và muốn cập nhật lên main, làm như sau:

# Chuyển sang nhánh main
git checkout main

# Cập nhật code mới nhất từ develop
git merge develop

# Push lên GitHub
git push origin main


