# tnqbao-k8s-cluster-management

Quản lý cấu hình và triển khai Kubernetes cho nền tảng và dự án cá nhân, bao gồm các môi trường tách biệt như `production` và `staging`. Dự án sử dụng [Kustomize](https://kustomize.io/) kết hợp với template hóa YAML bằng `envsubst` để tăng tính linh hoạt và khả năng tái sử dụng.

## Cấu trúc thư mục | Directory Structure

```
tnqbao-k8s-cluster-management/
├── production/
│   ├── apply.sh
│   ├── init-env.sh
│   ├── kustomization.yaml
│   ├── namespace.yaml
│   └── <module-name>/  # ví dụ: database-resource
└── staging/
    ├── apply.sh
    ├── init-env.sh
    ├── kustomization.yaml
    ├── namespace.yaml
    └── <module-name>/
```

| Tiếng Việt                    | English                             |
|-------------------------------|-------------------------------------|
| Môi trường triển khai         | Deployment environment              |
| Tệp cấu hình namespace        | Namespace definition file           |
| Module triển khai             | Deployment module                   |
| Tệp template                  | Template file                       |
| Biến môi trường (`.env`)      | Environment variables (`.env`)      |
| Áp dụng cấu hình (`apply.sh`) | Apply configuration (`apply.sh`)    |
| Gỡ cấu hình (`unapply.sh`)    | Delete configuration (`unapply.sh`) |

> Các module như `database-resource/` chứa các tài nguyên triển khai cụ thể (Deployment, Service, Secret, HPA, ...). Trong tương lai có thể mở rộng thêm các module khác như `backend-service/`, `redis-cache/`, v.v.

---

## Quy trình triển khai | Deployment Workflow

![Workflow Diagram](https://i.ibb.co/jPZV1jvW/Workflow.png)

### 1. Khởi tạo file `.env` | Generate `.env` file

Chạy script `init-env.sh` để tạo ra các file `.env` từ `.env.example`. Script này sẽ tái sử dụng các biến cũ nếu đã có, đảm bảo không ghi đè giá trị đã được định nghĩa thủ công.

```bash
cd production
./init-env.sh
```

### 2. Apply toàn bộ môi trường | Apply entire environment

Sau khi `.env` đã được tạo, chạy lệnh sau để apply namespace và các tài nguyên được liệt kê trong `kustomization.yaml`.

```bash
./apply.sh
```

### 3. Apply từng module cụ thể (nếu cần) | Apply individual module (optional)

Mỗi module có `apply.sh` riêng để xử lý template và apply.

```bash
cd production/<module-name>
./apply.sh
```

Tương tự, bạn có thể gỡ bỏ (delete) một module bằng:

```bash
./unapply.sh
```

---

## Kiến trúc ví dụ | Example Architecture

![Architecture Diagram](https://i.ibb.co/SD83WdYT/Workflow-1.png)

---

## Template hóa YAML | YAML Templating

Các module sử dụng thư mục `template/` chứa các file YAML có chứa biến môi trường (VD: `${DEPLOY_ENV}`). Script `apply_envsubst.sh` sẽ tự động render sang thư mục `base/` để sẵn sàng apply với Kustomize.

---

## Lưu ý | Notes

* Namespace của `staging` và `production` hiện đang giống nhau (`bao-production-env`) – cần đảm bảo namespace khác biệt nếu triển khai song song.
* Các file `.env` cần được cấu hình kỹ trước khi apply để tránh lỗi runtime.
* Module PostgreSQL hiện chưa sử dụng Persistent Volume – nên bổ sung nếu cần lưu dữ liệu lâu dài.

---

## Phụ thuộc | Dependencies

* `kubectl`
* `kustomize`
* `envsubst` (thường đi kèm trong GNU `gettext`)

---

## Gợi ý mở rộng | Suggestions for Extension

* Thêm các module như `backend-service`, `frontend`, `redis`, ...
* Tích hợp CI/CD để tự động apply khi có thay đổi.
* Dùng GitOps với ArgoCD hoặc FluxCD.

---

## Giấy phép | License

Dự án này được phát hành theo giấy phép MIT. Xem tệp LICENSE để biết chi tiết.

## Liên hệ | Contact

Nếu bạn có bất kỳ câu hỏi hoặc đề xuất nào, vui lòng liên hệ qua email:

* Github: [tnqbao](https://github.com/tnqbao)
* LinkedIn: [https://www.linkedin.com/in/tnqb2004/](https://www.linkedin.com/in/tnqb2004/)
