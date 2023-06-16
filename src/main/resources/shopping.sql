/*
 Navicat Premium Data Transfer

 Source Server         : Shopping
 Source Server Type    : MySQL
 Source Server Version : 50739
 Source Host           : console.gz1.colourfur.com:3306
 Source Schema         : shopping

 Target Server Type    : MySQL
 Target Server Version : 50739
 File Encoding         : 65001

 Date: 16/06/2023 16:06:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for carts
-- ----------------------------
DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of carts
-- ----------------------------
INSERT INTO `carts` VALUES (16, 1, 10);
INSERT INTO `carts` VALUES (18, 4, 10);
INSERT INTO `carts` VALUES (19, 3, 10);

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `product_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `date` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (16, '书是好书，值得推荐购买，有很好的学习意义 纸质材料都很好 字也是很清晰 老师要求买的，做起来，希望对下学期有帮助，谢谢老师的，老师要求买的，做起来，希望对下学期有帮助，谢谢老师的，老师要求买的，做起来，希望对下学期有帮助，谢谢老师的，', 9, 1, '2023-06-16 15:56:21');
INSERT INTO `comments` VALUES (17, '留言测试', 10, 1, '2023-06-16 16:01:58');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 'book', '呐喊', '《呐喊》是现代文学家鲁迅的短篇小说集，收录鲁迅于1918年至1922年所作的14篇短篇小说，1923年由北京新潮社出版，现编入《鲁迅全集》第1卷。', 20.00, '//fur233.oss-cn-hangzhou.aliyuncs.com/shopping/%E5%91%90%E5%96%8A.jpg');
INSERT INTO `products` VALUES (2, 'book', '彷徨', '《彷徨》是近代文学家鲁迅创作的小说集，于1926年8月由北京北新书局初版，列为作者所编的《乌合丛书》之一，后编入《鲁迅全集》。', 19.99, '//fur233.oss-cn-hangzhou.aliyuncs.com/shopping/%E5%BD%B7%E5%BE%A8.jpg');
INSERT INTO `products` VALUES (3, 'book', '朝花夕拾', '《朝花夕拾》原名《旧事重提》，是现代文学家鲁迅的散文集，收录鲁迅于1926年创作的10篇回忆性散文，1928年由北京未名社出版，现编入《鲁迅全集》第2卷。', 20.99, '//fur233.oss-cn-hangzhou.aliyuncs.com/shopping/%E6%9C%9D%E8%8A%B1%E5%A4%95%E6%8B%BE.webp');
INSERT INTO `products` VALUES (4, 'book', '从百草园到三味书屋', '《从百草园到三味书屋》是现代文学家鲁迅于1926年写的一篇对童年妙趣生活的回忆性散文，此文被收入《朝花夕拾》。全文描述了色调不同，情韵各异的两大景片：百草园和三味书屋。', 21.99, '//fur233.oss-cn-hangzhou.aliyuncs.com/shopping/%E4%BB%8E%E7%99%BE%E8%8D%89%E5%9B%AD%E5%88%B0%E4%B8%89%E5%91%B3%E4%B9%A6%E5%B1%8B.webp');
INSERT INTO `products` VALUES (5, 'book', 'C语言程序设计', 'C语言之父&图灵奖得主作品，K&R的TCPL新版典藏版，豆瓣评分9.4，全球数千万程序员学习C语言的选择。让你从语言设计者的角度理解C语言。', 0.01, '//fur233.oss-cn-hangzhou.aliyuncs.com/shopping/C%E8%AF%AD%E8%A8%80%E7%A8%8B%E5%BA%8F%E8%AE%BE%E8%AE%A1.jpg');
INSERT INTO `products` VALUES (6, 'food', '鸡蛋', '这是鸡蛋，egg。', 1.00, '//fur233.oss-cn-hangzhou.aliyuncs.com/shopping/%E9%B8%A1%E8%9B%8B.png');
INSERT INTO `products` VALUES (7, 'food', '牛奶', '这是牛奶，milk。', 2.50, '//fur233.oss-cn-hangzhou.aliyuncs.com/shopping/%E7%89%9B%E5%A5%B6.png');
INSERT INTO `products` VALUES (8, 'food', '披萨', 'pizza。', 79.00, '//fur233.oss-cn-hangzhou.aliyuncs.com/shopping/%E6%8A%AB%E8%90%A8.jpg');
INSERT INTO `products` VALUES (9, 'food', '双层吉士牛肉堡', '麦当劳随心配套餐经典之选，有谁不爱穷哥们套餐呢？', 13.90, '//fur233.oss-cn-hangzhou.aliyuncs.com/shopping/%E5%8F%8C%E5%B1%82%E5%90%89%E5%A3%AB%E7%89%9B%E8%82%89%E5%A0%A1.png');
INSERT INTO `products` VALUES (10, 'food', '巨无霸', '麦当劳经典！', 25.00, '//fur233.oss-cn-hangzhou.aliyuncs.com/shopping/%E5%B7%A8%E6%97%A0%E9%9C%B8.jpg');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `username`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (9, 'test', 'test');
INSERT INTO `users` VALUES (10, 'test2', 'test2');

SET FOREIGN_KEY_CHECKS = 1;
