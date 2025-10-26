-- Trước khi Code mở file Project ra chạy các lệnh này trong Git Bash:


git checkout develop

git pull origin develop

git checkout -b feature/<tên-tính-năng>


-- Sau khi hoàn thiện phần việc:


git add .

git commit -m "Hoàn thiện chức năng tên chức năng"

git push origin feature/<tên-tính-năng>


-- Tạo Pull Request (PR)


1. Truy cập repository trên GitHub
   
2. Chọn Compare & pull request
   
3. Viết mô tả chi tiết thay đổi
  
4. Gửi yêu cầu để Leader review và merge vào main

Nếu bạn đã test ổn định ở nhánh develop và muốn cập nhật lên main, làm như sau:

# Chuyển sang nhánh main
git checkout main

# Cập nhật code mới nhất từ develop
git merge develop

# Push lên GitHub
git push origin main

