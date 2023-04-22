-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost
-- Thời gian đã tạo: Th4 20, 2023 lúc 12:55 PM
-- Phiên bản máy phục vụ: 8.0.32
-- Phiên bản PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `webmail`
--

CREATE DATABASE IF NOT EXISTS `webmail` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `webmail`;


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `attachment`
--

CREATE TABLE `attachment` (
  `id` int NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `file_size` int DEFAULT NULL,
  `data` longblob,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `message_id` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `attachment`
--

INSERT INTO `attachment` (`id`, `filename`, `file_type`, `file_size`, `data`, `created_at`, `updated_at`, `message_id`) VALUES
(1, 'file1.pdf', 'pdf', 1024, 0x3c62696e61727920646174613e, '2023-04-20 05:44:52', '2023-04-20 05:44:52', 'M1'),
(2, 'image1.jpg', 'jpg', 2048, 0x3c62696e61727920646174613e, '2023-04-20 05:44:52', '2023-04-20 05:44:52', 'M2'),
(3, 'file2.docx', 'docx', 3072, 0x3c62696e61727920646174613e, '2023-04-20 05:44:52', '2023-04-20 05:44:52', 'M1'),
(4, 'image2.png', 'png', 4096, 0x3c62696e61727920646174613e, '2023-04-20 05:44:52', '2023-04-20 05:44:52', 'M3'),
(5, 'file3.txt', 'txt', 5120, 0x3c62696e61727920646174613e, '2023-04-20 05:44:52', '2023-04-20 05:44:52', 'M2'),
(6, 'image3.gif', 'gif', 6144, 0x3c62696e61727920646174613e, '2023-04-20 05:44:52', '2023-04-20 05:44:52', 'M4'),
(7, 'file4.xlsx', 'xlsx', 7168, 0x3c62696e61727920646174613e, '2023-04-20 05:44:52', '2023-04-20 05:44:52', 'M3'),
(8, 'image4.bmp', 'bmp', 8192, 0x3c62696e61727920646174613e, '2023-04-20 05:44:52', '2023-04-20 05:44:52', 'M5'),
(9, 'file5.pptx', 'pptx', 9216, 0x3c62696e61727920646174613e, '2023-04-20 05:44:52', '2023-04-20 05:44:52', 'M4'),
(10, 'image5.jpeg', 'jpeg', 10240, 0x3c62696e61727920646174613e, '2023-04-20 05:44:52', '2023-04-20 05:44:52', 'M6');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `mailbox`
--

CREATE TABLE `mailbox` (
  `id` varchar(10) NOT NULL,
  `sender` varchar(10) DEFAULT NULL,
  `receiver` varchar(10) DEFAULT NULL,
  `original_sender` varchar(10) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `content` text,
  `is_read` json DEFAULT NULL,
  `is_starred` json DEFAULT NULL,
  `is_archived` json DEFAULT NULL,
  `is_trash` json DEFAULT NULL,
  `is_deleted` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `mailbox`
--

INSERT INTO `mailbox` (`id`, `sender`, `receiver`, `original_sender`, `subject`, `content`, `is_read`, `is_starred`, `is_archived`, `is_trash`, `is_deleted`, `created_at`, `updated_at`) VALUES
('M1', 'U1', 'U2', 'U1', 'Chào bạn', 'Nội dung thư', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', NULL, NULL, '2023-04-20 05:29:50', '2023-04-20 05:29:50'),
('M10', 'U1', 'U2', NULL, 'Chủ đề 7', 'Nội dung thư 7', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '2023-04-20 05:35:16', '2023-04-20 05:35:16'),
('M11', 'U3', 'U4', NULL, 'Thông báo nghỉ lễ', 'Nội dung thông báo nghỉ lễ', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '2023-04-20 05:42:06', '2023-04-20 05:42:06'),
('M12', 'U3', 'U4', NULL, 'Cập nhật hệ thống', 'Nội dung cập nhật hệ thống', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '2023-04-20 05:42:06', '2023-04-20 05:42:06'),
('M13', 'U1', 'U4', NULL, 'Yêu cầu hỗ trợ', 'Nội dung yêu cầu hỗ trợ', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '2023-04-20 05:42:07', '2023-04-20 05:42:07'),
('M14', 'U1', 'U4', NULL, 'Thông báo đến tất cả người dùng', 'Nội dung thông báo đến tất cả người dùng', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '2023-04-20 05:42:06', '2023-04-20 05:42:06'),
('M15', 'U2', 'U4', NULL, 'Thông tin tài khoản', 'Nội dung thông tin tài khoản', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '2023-04-20 05:42:06', '2023-04-20 05:42:06'),
('M2', 'U2', 'U1', 'U2', 'Cảm ơn bạn', 'Nội dung thư', '{\"sender\": 1, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 0}', NULL, NULL, '2023-04-20 05:29:50', '2023-04-20 05:29:50'),
('M3', 'U3', 'U1', 'U3', 'Hỏi về sản phẩm', 'Nội dung thư', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', NULL, NULL, '2023-04-20 05:29:50', '2023-04-20 05:29:50'),
('M4', 'U1', 'U2', NULL, 'Chủ đề 1', 'Nội dung thư 1', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '2023-04-20 05:35:16', '2023-04-20 05:35:16'),
('M5', 'U2', 'U1', 'U3', 'Chủ đề 2', 'Nội dung thư 2', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '2023-04-20 05:35:16', '2023-04-20 05:35:16'),
('M6', 'U3', 'U1', NULL, 'Chủ đề 3', 'Nội dung thư 3', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '2023-04-20 05:35:16', '2023-04-20 05:35:16'),
('M7', 'U1', 'U3', NULL, 'Chủ đề 4', 'Nội dung thư 4', '{\"sender\": 1, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '2023-04-20 05:35:16', '2023-04-20 05:35:16'),
('M8', 'U2', 'U3', 'U1', 'Chủ đề 5', 'Nội dung thư 5', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '2023-04-20 05:35:16', '2023-04-20 05:35:16'),
('M9', 'U3', 'U2', NULL, 'Chủ đề 6', 'Nội dung thư 6', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '2023-04-20 05:35:16', '2023-04-20 05:35:16'),
('U16', 'U4', 'U1', 'U2', 'Subject 1', 'Content 1', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '2023-04-20 08:02:23', '2023-04-20 08:02:23'),
('U17', 'U4', 'U2', 'U3', 'Subject 2', 'Content 2', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 1}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '2023-04-20 08:02:23', '2023-04-20 08:02:23'),
('U18', 'U4', 'U3', 'U1', 'Subject 3', 'Content 3', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '2023-04-20 08:02:23', '2023-04-20 08:02:23'),
('U19', 'U4', 'U1', NULL, 'Subject 4', 'Content 4', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '2023-04-20 08:02:23', '2023-04-20 08:02:23'),
('U20', 'U4', 'U2', 'U3', 'Subject 5', 'Content 5', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '2023-04-20 08:02:23', '2023-04-20 08:02:23'),
('U21', 'U4', 'U3', 'U1', 'Subject 6', 'Content 6', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 0}', '2023-04-20 08:02:23', '2023-04-20 08:02:23'),
('U22', 'U4', 'U1', 'U1', 'Tiêu đề 1', 'Nội dung 1', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 1, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '2023-04-20 08:12:04', '2023-04-20 08:12:04'),
('U23', 'U4', 'U2', 'U2', 'Tiêu đề 2', 'Nội dung 2', '{\"sender\": 1, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 1, \"receiver\": 1, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 0}', '2023-04-20 08:12:04', '2023-04-20 08:12:04'),
('U24', 'U4', 'U3', 'U3', 'Tiêu đề 3', 'Nội dung 3', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 1}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '2023-04-20 08:12:04', '2023-04-20 08:12:04'),
('U25', 'U4', 'U1', 'U1', 'Tiêu đề 4', 'Nội dung 4', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '2023-04-20 08:12:04', '2023-04-20 08:12:04'),
('U26', 'U4', 'U2', 'U2', 'Tiêu đề 5', 'Nội dung 5', '{\"sender\": 1, \"receiver\": 1, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 0, \"receiver\": 1, \"original_sender\": 1}', '2023-04-20 08:12:04', '2023-04-20 08:12:04'),
('U27', 'U4', 'U3', 'U3', 'Tiêu đề 6', 'Nội dung 6', '{\"sender\": 1, \"receiver\": 1, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 1}', '{\"sender\": 1, \"receiver\": 0, \"original_sender\": 0}', '{\"sender\": 0, \"receiver\": 0, \"original_sender\": 0}', '2023-04-20 08:12:04', '2023-04-20 08:12:04');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `id` varchar(10) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `locked` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `locked`, `created_at`, `updated_at`) VALUES
('U1', 'ThanhDat', 'thanhdat@example.com', '123456', 0, '2023-04-20 05:29:32', '2023-04-20 05:29:32'),
('U2', 'KhanhLinh', 'khanhlinh@example.com', '123456', 0, '2023-04-20 05:29:32', '2023-04-20 05:29:32'),
('U3', 'MinhHai', 'minhhai@example.com', '123456', 0, '2023-04-20 05:29:32', '2023-04-20 05:29:32'),
('U4', 'admin', 'admin', '123456', 0, '2023-04-20 05:29:32', '2023-04-20 05:29:32');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `attachment`
--
ALTER TABLE `attachment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_id` (`message_id`);

--
-- Chỉ mục cho bảng `mailbox`
--
ALTER TABLE `mailbox`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender` (`sender`),
  ADD KEY `receiver` (`receiver`),
  ADD KEY `original_sender` (`original_sender`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email_2` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `attachment`
--
ALTER TABLE `attachment`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `attachment`
--
ALTER TABLE `attachment`
  ADD CONSTRAINT `attachment_ibfk_1` FOREIGN KEY (`message_id`) REFERENCES `mailbox` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `mailbox`
--
ALTER TABLE `mailbox`
  ADD CONSTRAINT `mailbox_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `mailbox_ibfk_2` FOREIGN KEY (`receiver`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `mailbox_ibfk_3` FOREIGN KEY (`original_sender`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
