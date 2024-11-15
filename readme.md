# BOOK BOOK Database Design
### 2110322 Database Systems Final Project
### Computer Engineering, Chulalongkorn University


## SQL Part

### PostgreSQL Database Configuration

1. สร้าง Database ใหม่

2. รัน Query สร้าง Table ตามลำดับ
 - create-user-tables.sql
 - create-book-tables.sql
 - create-post-tables.sql
 - create-trans-table.sql
 - create-other-tables.sql

3. Import CSV เข้าแต่ละ Table สำหรับแต่ละ Relation (ดูชื่อ CSV แต่ละไฟล์ใน /sql/sample_data_csv)

4. รัน Query เพิ่ม Referential Integrity และ Update serial
 - add-ref-integrity.sql

5. ลองรัน Query ที่ต้องส่งใน Final Report ได้ใน /sql/query

Note: โค้ด Python ใช้แปลง Sample Excel Data แต่ละ Sheet เป็น Header-less CSV แต่ละ Relation