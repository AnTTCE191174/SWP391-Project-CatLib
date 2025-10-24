-- Trước khi Code mở file Project ra chạy 2 lệnh này trong Git Bash:
git checkout main
git pull origin main
-- Mỗi thành viên làm việc trên branch riêng để tránh xung đột:
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
